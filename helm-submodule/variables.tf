


variable "sets" {
  description = "List of dynamic Helm set entries"
  type = list(object({
    name  = string
    value = any
    type  = optional(string, "set")
  }))
  default = []
}

variable "name" {
  type        = string
  description = "Release name."
}

variable "repository" {
  type        = string
  description = "Helm repository URL."
}

variable "chart" {
  type        = string
  description = "Chart name."
}

variable "chart_version" {
  type        = string
  description = "Chart version (optional)."
  default     = null
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace."
}

variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it doesn't exist."
  default     = true
}

