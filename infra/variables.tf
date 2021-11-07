variable "app_name" {
  default = "nordcloud-ghost"
}

variable "vpc-cidr" {
  default = "10.32.0.0/16"
}

variable priv-sb-count {
    default = "2"
}

variable pub-sb-count {
    default = "2"
}
#variable "pub-sb-count" {
#  default = "3"
#}

#variable "priv-sb-count" {
#  default = "2"
#}