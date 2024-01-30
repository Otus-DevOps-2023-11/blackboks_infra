resource "yandex_lb_target_group" "lb-group" {
  name      = "reddit-app-lb-group"
  region_id = var.region_id

  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app[0].network_interface.0.ip_address

  }

  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app[1].network_interface.0.ip_address
  }

#   dynamic "target" {
#     for_each = yandex_compute_instance.app.*.network_interface.0.ip_address
#     content {
#       subnet_id = var.subnet_id
#       address   = target.value
#     }
#   }

 }


resource "yandex_lb_network_load_balancer" "balancer" {
  name = "reddit-app-balancer"

  listener {
    name = "reddit-app-listener"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.lb-group.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 9292

      }
    }
  }
}
