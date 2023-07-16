#
# Flux
#

resource "flux_bootstrap_git" "main" {
  path = "manifests"
}
