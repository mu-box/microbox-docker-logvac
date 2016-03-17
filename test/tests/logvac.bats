# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "logvac-test"
}

@test "Verify logvac installed" {
  # ensure logvac executable exists
  run docker exec "logvac-test" bash -c "[ -f /usr/local/bin/logvac ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "logvac-test"
}
