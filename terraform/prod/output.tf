output "external_ip_address_app" {
  value = module.app.external_ip_address_app
}
output "external_ip_address_db" {
  value = module.db.external_ip_address_db
}



# output "external_ip_addresses_app" {
#   value = yandex_compute_instance.app[*].network_interface.0.nat_ip_address
# }

# output "external_ip_addresses_db" {
#   value = yandex_compute_instance.db[*].network_interface.0.nat_ip_address
# }


# output "external_ip_address_lb" {
#   value = yandex_lb_network_load_balancer.balancer.listener[*].external_address_spec[*].address
# }
