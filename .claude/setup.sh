#!/usr/bin/env bash
# SocialiseWebsite — Claude Code cloud session bootstrap
# Run this once per new cloud environment before starting Claude Code.
# Usage: bash .claude/setup.sh

set -e

echo "=== Socialise Website — Claude Code Environment Setup ==="
echo ""

# ── 1. Check Node / npx ──────────────────────────────────────────────────────
if ! command -v node &>/dev/null; then
  echo "ERROR: Node.js is not installed. Install it from https://nodejs.org"
  exit 1
fi
NODE_VER=$(node -v)
echo "✓ Node.js $NODE_VER detected"

if ! command -v npx &>/dev/null; then
  echo "ERROR: npx not found. Update Node.js to a version that includes npx."
  exit 1
fi
echo "✓ npx available"
echo ""

# ── 2. Verify required env vars for MCP servers ────────────────────────────
MISSING=0

check_env() {
  local var="$1"
  local label="$2"
  if [ -z "${!var}" ]; then
    echo "  ✗ $var  ← required for $label"
    MISSING=1
  else
    echo "  ✓ $var"
  fi
}

echo "Checking MCP server environment variables:"
check_env "TWENTYFIRST_API_KEY"        "21st.dev Magic (component library)"
check_env "GEMINI_API_KEY"             "Nano Banana (image generation)"
check_env "STITCH_GOOGLE_CLOUD_PROJECT" "Stitch (UI mockup generator)"

echo ""
if [ "$MISSING" -eq 1 ]; then
  echo "Some env vars are missing. Export them before starting Claude Code:"
  echo ""
  echo "  export TWENTYFIRST_API_KEY=\"...\""
  echo "  export GEMINI_API_KEY=\"...\""
  echo "  export STITCH_GOOGLE_CLOUD_PROJECT=\"...\""
  echo ""
  echo "Tip: Add them to your shell profile (~/.bashrc, ~/.zshrc) or a local"
  echo ".env file that you source before running claude."
  echo ""
  echo "NOTE: context7 (docs lookup) requires no API key — it will work as-is."
  exit 1
fi

# ── 3. Pre-warm MCP packages (optional, speeds up first use) ──────────────
echo "Pre-warming MCP packages (first run may take a moment)..."
npx -y @upstash/context7-mcp@latest --version 2>/dev/null || true
npx -y @21st-dev/magic@latest --version 2>/dev/null || true
npx -y nano-banana-mcp --version 2>/dev/null || true
npx -y @_davideast/stitch-mcp --version 2>/dev/null || true
echo ""

echo "=== Setup complete. Start Claude Code with: claude ==="
