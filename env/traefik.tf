resource "helm_release" "traefik" {
    name      = "traefik"
    chart     = "stable/traefik"

    namespace = "dev"

    set {
        name = "loadBalancerIP"
        value = "10.1.0.254"
    }

    values = [<<VALUES
        service:
          annotations:
            service.beta.kubernetes.io/azure-load-balancer-internal: "true"
        rbac:
          enabled: true
        dashboard:
          enabled: true
          domain: ${azurerm_public_ip.demo.fqdn}
    VALUES
    ]
}