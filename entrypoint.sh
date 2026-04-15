#!/bin/bash
set -e

echo "Starting PDF → ZIM pipeline..."

mkdir -p /workdir/html
mkdir -p /output

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
zimname="collection_${timestamp}.zim"

echo "Normalizing filenames..."
for f in /input/*.pdf; do
    [ -e "$f" ] || continue
    nf=$(echo "$f" | tr ' ' '_' | tr -cd '[:alnum:]_.-/')
    if [ "$f" != "$nf" ]; then
        mv "$f" "$nf"
    fi
done

echo "Running OCR on PDFs (if needed)..."
for f in /input/*.pdf; do
    [ -e "$f" ] || continue
    base=$(basename "$f" .pdf)
    ocrmypdf --skip-text "$f" "/workdir/${base}_ocr.pdf"
done

echo "Converting PDFs to HTML..."
for f in /workdir/*_ocr.pdf; do
    base=$(basename "$f" _ocr.pdf)
    pdf2htmlEX "$f" "/workdir/html/${base}.html"
done

echo "Generating index.html..."
echo "<h1>PDF Collection</h1><ul>" > /workdir/html/index.html
for f in /workdir/html/*.html; do
    name=$(basename "$f")
    echo "<li><a href=\"$name\">${name%.html}</a></li>" >> /workdir/html/index.html
done
echo "</ul>" >> /workdir/html/index.html

echo "Building ZIM file..."
zimwriterfs /workdir/html "/output/${zimname}" \
  --title="PDF Collection" \
  --description="Automatically generated from PDFs" \
  --creator="Brian" \
  --language="en"

echo "Done. ZIM file created at /output/${zimname}"
