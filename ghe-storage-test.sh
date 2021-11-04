#!/bin/bash
#/ Usage: ghe-actions-console [-ch]
#/
#/ Opens an interactive console to a GitHub Actions service.  Only use this
#/ command if directed by GitHub Enterprise support.
#/
#/ OPTIONS:
#/   -c | --command     LightRail command to run, leave out this arg for an
#/                      interactive console
#/   -h | --help        Show this message
#/
set -e

# Default options
command=
pwsh_params=()
docker_params=()
env_vars=()

usage() {
    grep '^#/' < "$0" | cut -c 4-
    exit 2
}

while [ $# -gt 0 ]; do
  case "$1" in
    -c|--command)
      command="$2"
      shift 2
      ;;
    -h|--help)
      usage
      ;;
    *)
      >&2 echo "Unrecognized argument: $1"
      usage
      ;;
  esac
done

if [[ -z "$command" ]]; then
  pwsh_params+=("-NoExit")
  docker_params+=("-it")
fi

image="containers.pkg.github.com/github/actions/actions-console:main"

docker_params+=("--mount" "type=tmpfs,destination=/home/actions/.actions-dev")
docker_params+=("--mount" "type=tmpfs,destination=/LR/Logs")

# Configure Application settings
env_vars+=("ApplicationSettings__DeploymentType=OnPremises")
env_vars+=("ApplicationSettings__DeploymentEnvironment=Ghes")

# Create a protected temp file to store the env vars.
temp_file="$(mktemp)"

function cleanup {
    rm -f "$temp_file"
}

trap cleanup EXIT
( IFS=$'\n'; echo "${env_vars[*]}" ) > "$temp_file"

docker_run() {
  docker run \
    --rm \
    --entrypoint pwsh \
    --network host \
    --env-file "$temp_file" \
    "${docker_params[@]}" \
    "$image" \
    "${pwsh_params[@]}" Invoke-LightRail.ps1 -Initial "Actions/OnPrem" -Command "$command"
}

# Launch the Actions console.
if [[ -z "$command" ]]; then
  docker_run
else
  # sed commands make the LightRail output more readable.
  docker_run | sed 's/      \+/\n/g' | sed 's/    //g' | sed "s/^/LR actions> /"
  exit "${PIPESTATUS[0]}"
fi
