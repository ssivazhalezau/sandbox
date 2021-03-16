variable "region" {
  default = "us-west-2"
}
variable "profile" {
  default = "internship"
}
variable "environment" {
  default = "Development"
}
variable "jenkins_admin_password" {
  type = string
  sensitive = true
}
variable "ingress_jenkins_server" {
  type = list(number)
  default = [22, 8080, 50000 ]
}
variable "ingress_frontend" {
  type = list(number)
  default = [22, 80, 443, 44357 ]
}
variable "jenkins_pub_key" {
  default = "jenkins: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDexSbeqUUpSpV5kJcPgz5UePdfzACffLsg09hxGSCiaf3N65qOqLD+cEHTYAcHyz/72UzL4IDyHQsAqOWdtjmIs+sy+Qzl5sSmf2lkrDqlnloVpH4tN52Plei/kWNr5hBF83moRLLJ5R+5Xqv4+fQbJqS6LlcGTEs4BrHyv7/VtaPG5+qPGzhfqDPiDIrV7+2xQ4SD58C1k5fLU/DMTj6OGNAINqcqF+m4v9vovQf66BX1jSZbuJzTf9X7OhJC+BqAa8ujqi3nzVZmymVYO4K3/nnKSFgM8b+Yqx0xshZixqFCInUxHVI3QO88QApyWUhJ9pSVPx87IvEyopqMKuNhN7+7q/KgynzygZ8LIp8GF925kLQ1MAcj57rCA7ODDLa2p1r6hXMkLWnDLJfjUhOUQ4ih9LW4j/tpAOgT87B1mp4US75X7DBuoMWvVyM6gpGbT1snQKZhc5k/MRZk8IoiMlrspZitWXlnbmWjMAVDYnu3OY6VAzJBx47+Ec/tzDM2ewok2XHSNe6i1kvrgYcOzDsUuxjaFOOAuHTYMnn5CLMTF2fsVzlcNm8QlSPEMCxfdupE9hSWlBNReJVPOiRmaNEutRu+SPq8fclcSwi0hFw9EBYj2Uwsq1NZM4SLuYVGF4EYATTTCssVAFdyceTig5CylQLqO1LgdSZHVCdTww=="
}
variable "deployer_pub_key" {
  default = "deployer: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1v1on5aBooHM5JcCQXZXBusVLwVRrGOFHEYaYlrGe0YBfNsfoRrqIQXUGvs99EgIJ6g1eRprOpsTrYhJknlgXeOaCOPoyR/fZ0CFuYqFp0PZ56AHHD0RMQ9MCsYlsE8tl2vcM5yN91tjYsios/Pk2EqJgWDyH1zGeAjK/VbZiyh3VXOiuWI9wUxgkNsk7QqqAk+QORVXBH1wUXTeb1k1hGkPTcC9Xkyaw21NUR/Qf1MC6DMH81zKN6rzVENgblwChjFlEP/vyqtKoa5cmvnZkq3N7J0KQV2C9H0wfijMnGoDP+pVBNigEX90n/MMS3yjcLjd3D2ildmxWlggihAFQul2Zvcb0PsXOIFpb8kowgaPwwlPuHzVRQkCFKli/F3hIfJo1vDLuN54RjCfb1nJ/GmlaXuI44JV6yJFKmwocB2pXQbcADLnGFe2Zj0Nl/PLSzm2ptnUgsIrdvQ2WSdAieQlyMDzJAqDk28Z28jLhZxYyRM4aQeyepCekulG0qpagDWhD6lwW+WKndLSRUO4e9ApVymot2zKKT5xcyc6uXE4IS9q77BKtfjo5HuVCn2eeAQCyH8Lsz3eNWxXHiriEnLajkWSU4GZW2PIjeJUg/9125QoKb8OD8XRttqvBC/UULGINJ9EH9bNqPYvSUcIxHD0e7blywOZxhQJ9LtJpNw=="
}