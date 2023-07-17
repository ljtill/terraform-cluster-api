#
# Flux
#

resource "flux_bootstrap_git" "main" {
  path = "clusters/management"
}
