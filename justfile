set shell := ["bash", "-euo", "pipefail", "-c"]

install:
    @target="$(command -v nullclaw || true)"; \
    if [[ -z "$target" ]]; then \
      target="$HOME/.local/bin/nullclaw"; \
      mkdir -p "$HOME/.local/bin"; \
      echo "nullclaw not found in PATH; defaulting install target to $target"; \
    fi; \
    echo "Building nullclaw (ReleaseSmall)..."; \
    zig build -Doptimize=ReleaseSmall; \
    src="zig-out/bin/nullclaw"; \
    if [[ ! -x "$src" ]]; then \
      echo "Built binary not found: $src"; \
      exit 1; \
    fi; \
    echo "Installing $src -> $target"; \
    install -m 0755 "$src" "$target"; \
    echo "Done: $target"
