#!/bin/bash
# ErgoDesk Guide — Deploy Script
# Deploys to Netlify (recommended) or GitHub Pages

set -e

SITE_DIR="/home/chris/.openclaw/workspace/ergodeskguide"
PUBLIC="$SITE_DIR/public"

echo "=== Building ErgoDesk Guide ==="
cd "$SITE_DIR"
hugo --theme PaperMod

echo ""
echo "=== Build complete ==="
echo "Pages: $(ls $PUBLIC/*.html 2>/dev/null | wc -l)"
echo "Size:  $(du -sh $PUBLIC | cut -f1)"
echo ""

# Check for Netlify CLI
if command -v netlify &> /dev/null; then
    echo "Netlify CLI found. Deploying..."
    cd "$PUBLIC"
    netlify deploy --prod
else
    echo "Netlify CLI not found."
    echo ""
    echo "To deploy to Netlify (recommended):"
    echo "  1. Install: npm install -g netlify-cli"
    echo "  2. Run: netlify login"
    echo "  3. Update this script with your site ID, or run:"
    echo "     cd $PUBLIC && netlify deploy --prod"
    echo ""
    echo "Alternative: Push to GitHub and enable GitHub Pages."
    echo "  git init && git remote add origin https://github.com/YOURUSER/ergodeskguide.git"
    echo "  git add . && git commit -m 'Initial build'"
    echo "  git push origin main"
fi
