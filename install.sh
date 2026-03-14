#!/usr/bin/env bash

# =============================================================================
# SketchyBar Gruvbox — Easy Install Script
# https://github.com/FelixKratz/SketchyBar
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.config/sketchybar"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "${BLUE}==>${NC} ${BOLD}$1${NC}"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}⚠${NC}  $1"; }
error()   { echo -e "${RED}✗${NC} $1"; exit 1; }

echo -e "${BOLD}"
echo "  SketchyBar Gruvbox Installer"
echo "  ============================="
echo -e "${NC}"

# =============================================================================
# 1. Check macOS
# =============================================================================
info "Checking system..."
if [ "$(uname)" != "Darwin" ]; then
  error "This script is macOS only."
fi
success "macOS detected"

# =============================================================================
# 2. Homebrew
# =============================================================================
info "Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  warn "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add brew to PATH for Apple Silicon
  if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  success "Homebrew installed"
else
  success "Homebrew already installed"
fi

# =============================================================================
# 3. SketchyBar
# =============================================================================
info "Checking for SketchyBar..."
if ! brew list sketchybar &>/dev/null; then
  warn "SketchyBar not found. Installing..."
  brew tap FelixKratz/formulae
  brew install sketchybar
  success "SketchyBar installed"
else
  success "SketchyBar already installed"
fi

# =============================================================================
# 4. JetBrainsMono Nerd Font
# =============================================================================
info "Checking for JetBrainsMono Nerd Font..."
if ! system_profiler SPFontsDataType 2>/dev/null | grep -q "JetBrainsMono Nerd Font"; then
  warn "Font not found. Installing via Homebrew..."
  brew install --cask font-jetbrains-mono-nerd-font
  success "JetBrainsMono Nerd Font installed"
else
  success "JetBrainsMono Nerd Font already installed"
fi

# =============================================================================
# 5. Copy config files
# =============================================================================
info "Installing config files..."
mkdir -p "$DEST/plugins"

cp "$SCRIPT_DIR/sketchybarrc" "$DEST/sketchybarrc"
success "Copied sketchybarrc"

PLUGINS=(battery.sh clock.sh cpu.sh date.sh front_app.sh memory.sh network.sh space.sh volume.sh)
for f in "${PLUGINS[@]}"; do
  if [ -f "$SCRIPT_DIR/$f" ]; then
    cp "$SCRIPT_DIR/$f" "$DEST/plugins/$f"
    success "Copied $f"
  else
    warn "$f not found in $SCRIPT_DIR — skipping"
  fi
done

# =============================================================================
# 6. Permissions
# =============================================================================
info "Setting execute permissions..."
chmod +x "$DEST/plugins/"*.sh
success "Permissions set"

# =============================================================================
# 7. Start SketchyBar
# =============================================================================
info "Starting SketchyBar..."
if brew services list | grep sketchybar | grep -q "started"; then
  brew services restart sketchybar
  success "SketchyBar restarted"
else
  brew services start sketchybar
  success "SketchyBar started"
fi

# =============================================================================
# Done
# =============================================================================
echo ""
echo -e "${GREEN}${BOLD}All done!${NC}"
echo ""
echo "  If icons look wrong, make sure you've set your terminal"
echo "  and any status bar font to 'JetBrainsMono Nerd Font'."
echo ""
echo "  To reload the bar at any time:"
echo "    sketchybar --reload"
echo ""
echo "  To uninstall:"
echo "    brew services stop sketchybar"
echo "    rm -rf ~/.config/sketchybar"
echo ""
