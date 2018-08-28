# Discover Consul settings from another deplyoment
module "consul_vertical" {
  source       = "github.com/nubisproject/nubis-terraform//consul?ref=v2.3.1"
  region       = "${var.region}"
  environment  = "${var.environment}"
  account      = "${var.account}"
  service_name = "vertical"
}

# Configure our Consul provider, module can't do it for us
provider "consul" {
  address    = "${module.consul_vertical.address}"
  scheme     = "${module.consul_vertical.scheme}"
  datacenter = "${module.consul_vertical.datacenter}"
}

# Retrieve Vertical client security group
data "consul_keys" "vertical" {
  key {
    name = "client_security_group_id"
    path = "${module.consul_vertical.config_prefix}/clients/security-group-id"
  }
}
