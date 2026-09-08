#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
PACKAGE_DIR="$REPO_ROOT/packages"
PACKAGE_PATH="$PACKAGE_DIR/aidn-product-skills.plugin"

mkdir -p "$PACKAGE_DIR"

(
  cd "$REPO_ROOT"
  zip -X -FS -r "$PACKAGE_PATH" \
    .claude-plugin \
    .mcp.json \
    skills \
    README.md \
    -x '*.DS_Store'
)

echo "built: $PACKAGE_PATH"
