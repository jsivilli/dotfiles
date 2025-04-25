#!/bin/bash

# Cleanup Downloads folder into a single archive

DOWNLOADS="$HOME/Downloads"
ARCHIVE_NAME="downloads-$(date +%Y%m%d).tar.gz"
TEMP_DIR="$DOWNLOADS/cleanup_temp"

echo ""
echo "========================================="
echo "🗃️  Cleaning up Downloads"
echo "========================================="

# Create a temp directory
mkdir -p "$TEMP_DIR"

# Find any existing archives we made previously
if ls "$DOWNLOADS"/downloads-*.tar.gz 1> /dev/null 2>&1; then
  echo "📦 Found previous archive(s), extracting..."
  for archive in "$DOWNLOADS"/downloads-*.tar.gz; do
    tar -xzf "$archive" -C "$TEMP_DIR"
    rm "$archive"
  done
fi

# Move all files from Downloads (except temp dir itself) into temp
echo "📂 Moving files into temp directory..."
find "$DOWNLOADS" -mindepth 1 -maxdepth 1 ! -name "$(basename "$TEMP_DIR")" -exec mv {} "$TEMP_DIR/" \;

# Create a fresh archive
echo "🗜️  Creating new archive: $ARCHIVE_NAME"
tar -czf "$DOWNLOADS/$ARCHIVE_NAME" -C "$TEMP_DIR" .

# Clean up temp
rm -rf "$TEMP_DIR"

echo "✅ Downloads folder archived into $ARCHIVE_NAME"
echo "========================================="
echo ""

