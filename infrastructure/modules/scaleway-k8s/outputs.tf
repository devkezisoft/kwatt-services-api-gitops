output "kubeconfig_file" {
  value = local_file.kubeconfig.filename
}

output "cluster_id" {
  value = scaleway_k8s_cluster.this.id
}
