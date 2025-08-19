#!/usr/bin/env bash
# nixos-auto-update.sh
# A safe, configurable script to update your flake inputs and switch your NixOS system
# Improvements: safer default log location (user-writable), fallback to /tmp if needed.

set -euo pipefail
IFS=$'
	'

# Colors
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
INFO="$(tput setaf 4)[INFO]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
RESET="$(tput sgr0)"

# Defaults
TARGET_HOSTNAME=""
DRY_RUN=false
AUTO_COMMIT=false
AUTO_REBOOT=false
AUTO_YES=false
UPDATE_INPUTS=""  # comma separated list. empty => update all
LOGFILE=""         # can be overridden by -l or env var

usage() {
    cat <<EOF
Usage: $0 [options]

Options:
  -h HOST        Target hostname to pass to --flake .#HOST (default: current hostname)
  -i INPUTS      Comma-separated flake inputs to update (e.g. nixpkgs,home-manager). Empty = update all
  -c             Auto-commit and push flake.lock if inside a git repo
  -r             Reboot automatically after a successful switch
  -d             Dry-run (do not make changes)
  -y             Assume yes for prompts
  -l FILE        Log file path (default: XDG_STATE_HOME or $HOME/.local/state/nixos-auto-update.log)
  -?             Show this help

Example: $0 -h myhost -i nixpkgs -c -r
EOF
}

# Parse args
while getopts ":h:i:cdryl:?" opt; do
    case $opt in
        h) TARGET_HOSTNAME="$OPTARG" ;;
        i) UPDATE_INPUTS="$OPTARG" ;;
        c) AUTO_COMMIT=true ;;
        r) AUTO_REBOOT=true ;;
        d) DRY_RUN=true ;;
        y) AUTO_YES=true ;;
        l) LOGFILE="$OPTARG" ;;
        ?) usage; exit 0 ;;
    esac
done

# Set target hostname default
if [ -z "$TARGET_HOSTNAME" ]; then
    TARGET_HOSTNAME=$(hostname 2>/dev/null || echo "default")
fi

# Set a safe default logfile (user-writable). Prefer XDG_STATE_HOME, then ~/.local/state
if [ -z "${LOGFILE:-}" ]; then
    LOGFILE="${XDG_STATE_HOME:-$HOME/.local/state}/nixos-auto-update.log"
fi

# Ensure log directory exists and is writable; otherwise fallback to /tmp
LOGDIR="$(dirname "$LOGFILE")"
if ! mkdir -p "$LOGDIR" 2>/dev/null; then
    # directory couldn't be created (maybe because it's under /var/log)
    LOGFILE="/tmp/nixos-auto-update.log"
else
    # try to create the file if it doesn't exist
    if ! touch "$LOGFILE" 2>/dev/null; then
        # unable to touch (permissions?) -> fallback
        LOGFILE="/tmp/nixos-auto-update.log"
    fi
fi

# Quick safety: ensure touch succeeded for the final logfile
mkdir -p "$(dirname "$LOGFILE")" 2>/dev/null || true
: > "$LOGFILE" 2>/dev/null || true

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "")"

# Ensure hosts dir exists for the chosen host
if [ ! -d "hosts/$TARGET_HOSTNAME" ]; then
    printf "%s Host configuration 'hosts/%s' not found in hosts/ directory.
" "$ERROR" "$TARGET_HOSTNAME"
    exit 1
fi

log() {
    local msg="$1"
    # Use tee -a so messages are both printed and logged. If tee fails, fall back to echo >>
    if ! { echo "$(date --iso-8601=seconds) $msg" | tee -a "$LOGFILE" 2>/dev/null; }; then
        # try simple append. If that also fails, print to stderr.
        if ! echo "$(date --iso-8601=seconds) $msg" >> "$LOGFILE" 2>/dev/null; then
            >&2 echo "$(date --iso-8601=seconds) $msg"
        fi
    fi
}

confirm() {
    if $AUTO_YES || $DRY_RUN; then
        return 0
    fi
    read -rp "$1 [y/N]: " ans
    case "$ans" in
        [Yy]*) return 0;;
        *) return 1;;
    esac
}

# Start
log "${INFO} Starting NixOS auto-update for host: $TARGET_HOSTNAME"
log "${NOTE} Logfile: $LOGFILE"
if $DRY_RUN; then
    log "${NOTE} Running in dry-run mode. No changes will be made."
fi

# Build nix flake update command
FLAKE_UPDATE_CMD=(nix flake update)
if [ -n "$UPDATE_INPUTS" ]; then
    IFS=',' read -ra inputs <<< "$UPDATE_INPUTS"
    for iname in "${inputs[@]}"; do
        FLAKE_UPDATE_CMD+=(--update-input "$iname")
    done
fi

log "${INFO} Running: ${FLAKE_UPDATE_CMD[*]}"
if $DRY_RUN; then
    log "${NOTE} Dry-run: skipping flake update."
else
    "${FLAKE_UPDATE_CMD[@]}"
fi

# Check git repo status
if [ -n "$REPO_ROOT" ]; then
    cd "$REPO_ROOT"
    GIT_STATUS_OUT=$(git status --porcelain=2 --untracked-files=no || true)
    if [ -n "$GIT_STATUS_OUT" ]; then
        log "${NOTE} Repository has uncommitted changes. Will not auto-commit unless you resolve them."
        AUTO_COMMIT=false
    fi
else
    log "${NOTE} Not in a git repository. Auto-commit disabled."
    AUTO_COMMIT=false
fi

# Detect if flake.lock changed
flake_changed=false
if [ -f flake.lock ]; then
    if git diff --no-ext-diff --quiet --exit-code -- flake.lock 2>/dev/null; then
        # no change
        flake_changed=false
        log "${INFO} No change in flake.lock after update."
    else
        flake_changed=true
        log "${OK} flake.lock changed."
    fi
else
    log "${NOTE} No flake.lock found in repo root."
fi

# Auto-commit if requested and flake.lock changed
if $AUTO_COMMIT && $flake_changed; then
    if $DRY_RUN; then
        log "${NOTE} Dry-run: would git add/commit flake.lock and push."
    else
        git add flake.lock
        git commit -m "chore(flake): update flake.lock ($(date --iso-8601=seconds))" || true
        # attempt to push to the current upstream
        if git rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1; then
            git push
            log "${OK} Committed and pushed flake.lock"
        else
            log "${NOTE} No upstream configured; committed locally."
        fi
    fi
fi

# Run nixos-rebuild switch --upgrade
REBUILD_CMD=(sudo nixos-rebuild switch --flake .#"$TARGET_HOSTNAME" --upgrade)
log "${INFO} Running rebuild: ${REBUILD_CMD[*]}"
if $DRY_RUN; then
    log "${NOTE} Dry-run: skipping nixos-rebuild."
    rebuild_success=true
else
    if "${REBUILD_CMD[@]}"; then
        rebuild_success=true
        log "${OK} nixos-rebuild finished successfully."
    else
        rebuild_success=false
        log "${ERROR} nixos-rebuild failed. Attempting to log details."
    fi
fi

# On failure: attempt to rollback to last generation (best-effort)
if ! $DRY_RUN && ! $rebuild_success; then
    log "${NOTE} Attempting to switch to previous generation (best-effort)."
    if sudo nixos-rebuild switch --rollback; then
        log "${OK} Rolled back to previous generation."
    else
        log "${ERROR} Rollback attempt failed. Please inspect your system manually."
    fi
    exit 2
fi

# Optionally reboot
if $AUTO_REBOOT && $rebuild_success; then
    if $DRY_RUN; then
        log "${NOTE} Dry-run: would reboot now."
    else
        if confirm "Reboot now?"; then
            log "${CAT} Rebooting system now."
            sudo systemctl reboot
            # systemctl reboot should not return
        else
            log "${NOTE} Reboot canceled by user."
        fi
    fi
fi

log "${OK} Done."
exit 0
