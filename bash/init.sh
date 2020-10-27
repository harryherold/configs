
config_dir=$(dirname "${BASH_SOURCE[0]}")
config_dir=$(realpath "$config_dir")

source "$config_dir/.bash_slurm"
source "$config_dir/.bash_scorep"

export MY_BASH_CONFIG="$config_dir"

