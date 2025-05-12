resource "scaleway_k8s_cluster" "this" {
  name     = var.name
  version  = var.k8s_version
  region   = var.region
  cni      = "cilium"
  delete_additional_resources = false
}

resource "scaleway_k8s_pool" "this" {
  cluster_id = scaleway_k8s_cluster.this.id
  node_type  = var.node_type
  size       = var.node_count
  zone       = var.zone
  name       = "scaleway_k8s_pool"
  min_size = 2
  max_size = 3
  autoscaling = true
  autohealing = true
}

resource "local_file" "kubeconfig" {
  content  = scaleway_k8s_cluster.this.kubeconfig[0].config_file
  filename = "${var.name}-kubeconfig.yaml"
}

resource "null_resource" "k8s_bootstrap" {
  provisioner "local-exec" {
    command = <<EOT
export KUBECONFIG=${local_file.kubeconfig.filename}
kubectl create ns argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl create ns ${var.app_namespace} --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret docker-registry ghcr-secret \\
  --docker-server=ghcr.io \\
  --docker-username=${var.ghcr_username} \\
  --docker-password=${var.ghcr_pat} \\
  --docker-email=${var.ghcr_email} \\
  --namespace=${var.app_namespace}

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

cat <<EOF | kubectl apply -f -
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: ${var.app_namespace}
  namespace: argocd
spec:
  project: default
  source:
    repoURL: ${var.app_repo_url}
    path: ${var.app_path}
    targetRevision: ${var.app_revision}
  destination:
    server: https://kubernetes.default.svc
    namespace: ${var.app_namespace}
  syncPolicy:
    automated:
      selfHeal: true
      prune: true
    syncOptions:
      - CreateNamespace=true
EOF
EOT
  }
  depends_on = [scaleway_k8s_pool.this]
}
