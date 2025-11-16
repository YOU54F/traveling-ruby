#!/bin/bash
set -e
SELFDIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_DIR="$1"
ARCHITECTURE="${2:-x86_64}"

if [[ -z "$OUTPUT_DIR" ]]; then
  echo "Usage: ./setup-runtime.sh <OUTPUT DIR> [ARCHITECTURE]"
  exit 1
fi

if [[ ! -d "$OUTPUT_DIR" ]]; then
  echo "ERROR: $OUTPUT_DIR does not exist."
  exit 1
fi

RIDK_CMD="$OUTPUT_DIR/bin/ridk.cmd"

if [[ ! -f "$RIDK_CMD" ]]; then
  echo "ERROR: $RIDK_CMD not found. Ensure RubyInstaller is extracted to $OUTPUT_DIR."
  exit 1
fi

# Only run ridk setup for arm64
if [[ "$ARCHITECTURE" == "arm64" ]]; then
  echo "Setting up MSYS2 environment with ridk for arm64..."
  "$RIDK_CMD" install 2 3
  # "$RIDK_CMD" enable
  # "$RIDK_CMD" exec sh -c "pacman -Suy --noconfirm"
  # "$RIDK_CMD" exec sh -c "pacman -S --noconfirm mingw-w64-clang-aarch64-clang"
  # echo "ridk and clang setup complete."
else
  echo "No additional runtime setup required for architecture: $ARCHITECTURE"
fi
