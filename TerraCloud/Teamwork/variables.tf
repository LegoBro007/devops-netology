variable "create_folder" {
  type        = bool
  default     = false
}

variable "yc_cloud_id" {
  description = "Cloud id for deploy resources"
  type        = string
  default     = "b1gju96knd0digar5ljh"
}

variable "yc_folder_id" {
  description = "Folder id for deplot resources"
  type        = string
  default     = "b1gehcd932u7u1rabubf"
}

variable "name" {
  description = "test_vpc"
  type        = string
}

variable "description" {
  description = "An optional description of this resource. Provide this property when you create the resource."
  type        = string
  default     = "Auto-created"
}

variable "subnets" {
  type    = list(object({
    zone           = string
    v4_cidr_blocks = list(string)
  }))
  default = [
    {
      zone           = "ru-central1-a"
      v4_cidr_blocks = ["10.130.0.0/24"]
    },
    {
      zone           = "ru-central1-b"
      v4_cidr_blocks = ["10.129.0.0/24"]
    },
    {
      zone           = "ru-central1-c"
      v4_cidr_blocks = ["10.128.0.0/24"]
    }
  ]
}

variable "labels" {
  description = "A set of key/value label pairs to assign."
  type        = map(string)
  default     = {}
}

