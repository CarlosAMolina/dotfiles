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

create_dir() {
    if [[ -d "$@" ]]; then
        log "The $@ folder already exists"
    else
        log "The $@ folder does not exist. Creating"
        execute mkdir -p "$@"
    fi
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

