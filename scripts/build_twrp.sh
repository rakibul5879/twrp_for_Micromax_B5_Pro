#!/usr/bin/env bash
set -euo pipefail

GWD=$(pwd)
WORKDIR="$GITHUB_WORKSPACE/twrp_src"
MANIFEST_URL="${MANIFEST_URL:-}"
MANIFEST_BRANCH="${MANIFEST_BRANCH:-twrp-3.2}"

echo "Build script starting in $GWD"
echo "WORKDIR=$WORKDIR"

if [ -z "$MANIFEST_URL" ]; then
  echo "MANIFEST_URL environment variable is required. Set it in the workflow dispatch input 'manifest_url'." >&2
  exit 1
fi

export PATH=~/bin:$PATH

cd "$WORKDIR"
if [ ! -d .repo ]; then
  repo init -u "$MANIFEST_URL" -b "$MANIFEST_BRANCH" || repo init -u "$MANIFEST_URL" || true
fi

repo sync --force-sync -c -j$(nproc) || (sleep 4 && repo sync --force-sync -c -j2)

echo "Repo sync finished. Copying device tree if present."
if [ -d "$GITHUB_WORKSPACE/device/micromax/B5_Pro" ]; then
  mkdir -p device/micromax
  cp -R "$GITHUB_WORKSPACE/device/micromax/B5_Pro" device/micromax/ || true
fi

echo "Starting build environment setup"
source build/envsetup.sh

# Use the known product name from AndroidProducts.mk
TARGET="omni_B5_Pro-eng"
echo "Using lunch target: $TARGET"
if ! lunch "$TARGET" >/dev/null 2>&1; then
  echo "lunch $TARGET failed. Try adjusting TARGET in scripts/build_twrp.sh or verify AndroidProducts.mk." >&2
  exit 1
fi

echo "Running make for recoveryimage"
time mka recoveryimage -j$(nproc) || time make recoveryimage -j$(nproc)

echo "Build finished. Searching for produced images"
OUT_IMG=$(ls -1 out/target/product/*/recovery*.img 2>/dev/null || true)
if [ -z "$OUT_IMG" ]; then
  echo "No recovery image found in out/target/product/*" >&2
  ls -la out/target/product || true
  exit 1
fi

echo "Artifacts produced:"
ls -la out/target/product/*/recovery*.img || true

echo "Build script completed successfully."
