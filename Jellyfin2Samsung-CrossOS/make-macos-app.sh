#!/usr/bin/env bash
#
# make-macos-app.sh — wrap a self-contained publish folder into a double-clickable
# Apps2Samsung.app bundle (ad-hoc signed), the same layout the release workflow
# produces. Handy for testing local builds on macOS.
#
# Usage:
#   ./make-macos-app.sh [osx-arm64|osx-x64]      # default: osx-arm64
#
# Build the publish folder first, e.g.:
#   dotnet publish Apps2Samsung.csproj -c Release -r osx-arm64 \
#     -p:SelfContained=true -p:UseAppHost=true -o publish/osx-arm64
#
set -euo pipefail

ARCH="${1:-osx-arm64}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXE="Apps2Samsung"
PUB="$SCRIPT_DIR/publish/$ARCH"
APPROOT="$SCRIPT_DIR/publish/Apps2Samsung.app"
APP="$APPROOT/Contents"

if [ ! -f "$PUB/$EXE" ]; then
    echo "error: no publish output found at:" >&2
    echo "  $PUB/$EXE" >&2
    echo >&2
    echo "Build it first, e.g.:" >&2
    echo "  dotnet publish \"$SCRIPT_DIR/Apps2Samsung.csproj\" -c Release -r $ARCH \\" >&2
    echo "    -p:SelfContained=true -p:UseAppHost=true -o \"$PUB\"" >&2
    exit 1
fi

echo "Assembling $APPROOT"
echo "  from     $PUB"
rm -rf "$APPROOT"
mkdir -p "$APP/MacOS" "$APP/Resources"
cp -R "$PUB/." "$APP/MacOS/"
chmod +x "$APP/MacOS/$EXE"
cp "$SCRIPT_DIR/Assets/jelly2sams.icns" "$APP/Resources/"
cp "$SCRIPT_DIR/Info.plist" "$APP/Info.plist"

echo "Ad-hoc signing the bundle (apphost + dylibs + bundled esbuild)..."
codesign --deep --force --sign - "$APPROOT"
codesign --verify --deep --strict "$APPROOT" && echo "  signature: OK"

# Re-register with LaunchServices so `open` / double-click works immediately after
# the bundle is replaced (otherwise the first launch can fail with error -609).
LSREGISTER=/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister
if [ -x "$LSREGISTER" ]; then
    "$LSREGISTER" -f "$APPROOT" || true
fi

echo
echo "Done: $APPROOT"
echo "Run it:   open \"$APPROOT\""
echo "Install:  cp -R \"$APPROOT\" /Applications/"
