#!/usr/bin/env bash
# Build PDF from DocBook XML using pandoc + LaTeX
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XML_FILE="$REPO_ROOT/xml/robie-llmflow.xml"
PDF_DIR="$REPO_ROOT/pdf"
PDF_FILE="$PDF_DIR/robie-llmflow.pdf"

# Create pdf directory
mkdir -p "$PDF_DIR"

echo "Building PDF from DocBook XML..."
# Run pandoc from xml/ directory so relative image paths work
cd "$REPO_ROOT/xml"
pandoc \
  --from docbook \
  --to pdf \
  --pdf-engine=xelatex \
  --include-in-header="$REPO_ROOT/latex-header.tex" \
  --output "$PDF_FILE" \
  robie-llmflow.xml 2>&1 | grep -v "Missing character" || true

echo "✅ PDF generated: $PDF_FILE"
