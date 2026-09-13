log() {
    if [[ $dry_run == "1" ]]; then
        echo "[DRY_RUN] $@"
    else
        echo "[DEBUG] $@"
    fi
}

# To run commands with pipes: execute bash -c '... | ...'
execute() {
    log "execute $@"
    if [[ $dry_run == "1" ]]; then
        return
    fi
    "$@"
}

copy_dir_config() {
    local folder=$1
    if [[ -z "$folder" ]]; then
        echo "Error: folder must not be empty" >&2
        return 1
    fi
    local script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    local repo_root="$( cd "$script_path/../.." && pwd )"
    local dotfiles_path="$repo_root/dotfiles"
    local from_path="$dotfiles_path/$folder"
    local config_path_dest="$HOME/.config"
    if [[ ! -d "$from_path" ]]; then
        echo "Error: source folder does not exist: $from_path" >&2
        return 1
    fi
    execute mkdir -p "$config_path_dest"
    execute rm -rf "$config_path_dest/$folder"
    execute cp -r "$from_path" "$config_path_dest/$folder"
}

get_linux_distribution() {
    if [[ ! -f /etc/os-release ]]; then
        echo "[ERROR] Unable to determine Linux distribution" >&2
        return 1
    fi

    . /etc/os-release

    case "${ID:-}" in
      arch|archarm)
        echo "arch"
        ;;

      ubuntu|debian|linuxmint|pop)
        echo "debian"
        ;;

      *)
        # Some derivatives identify themselves through ID_LIKE.
        case " ${ID_LIKE:-} " in
          *" arch "*)
            echo "arch"
            ;;

          *" debian "*)
            echo "debian"
            ;;

          *)
            echo "[ERROR] Unsupported Linux distribution: ${ID:-unknown}" >&2
            return 1
            ;;
        esac
        ;;
    esac
}

get_os() {
    case "$(uname)" in
      Darwin)
        echo "darwin"
        ;;

      *BSD*)
        echo "bsd"
        ;;

      Linux)
        get_linux_distribution
        ;;

      *)
        echo "[ERROR] Unsupported OS: $(uname)" >&2
        return 1
        ;;
    esac
}
