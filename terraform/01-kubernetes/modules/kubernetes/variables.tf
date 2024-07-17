variable "k8s_version" {
  description = "The Kubernetes version to use for this cluster. (required)"
  default     = "1.30"
}

variable "region" {
  description = "The region where your cluster will be located. (required)"
  default     = "us-central"
}

variable "tags" {
  description = "Tags to apply to your cluster for organizational purposes. (optional)"
  type        = list(string)
  default     = ["testing"]
}

variable "pools" {
  description = "The Node Pool specifications for the Kubernetes cluster. (required)"
  type = list(object({
    type  = string
    count = number
  }))
  default = [
    {
      type  = "g6-standard-1"
      count = 1
    },
  ]
}

variable "environment" {
  description = "Name of environment.  (required)"
  type = string
}