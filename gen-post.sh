#!/bin/bash
set -euo pipefail

# -----------------------------------------------------------------------------
# Script : generate-posts.sh
# Usage  : Updates posts.json with all .md files in /public
#          - Shows diff with ++ for added, and -- for removed
# -----------------------------------------------------------------------------

POSTS_FILE="posts.json"
TMP_FILE="posts.tmp.json"

# sorted list of .md in /public > tmp file.
find public -maxdepth 1 -type f -name '*.md' \
  -exec basename {} \; | sort -u | jq -R . | jq -s . > "$TMP_FILE"

# post.json ? '' : '[] > post.js'
[ -f "$POSTS_FILE" ] || echo "[]" > "$POSTS_FILE"

# log diff
echo "Diff Changes:"
comm -23 <(jq -r '.[]' "$TMP_FILE") <(jq -r '.[]' "$POSTS_FILE") \
  | sed $'s/^/\033[0;32m++ /' \
  | sed $'s/$/\033[0m/'
comm -13 <(jq -r '.[]' "$TMP_FILE") <(jq -r '.[]' "$POSTS_FILE") \
  | sed $'s/^/\033[0;31m-- /' \
  | sed $'s/$/\033[0m/'

mv "$TMP_FILE" "$POSTS_FILE"

# sum up
echo "posts.json > len : $(jq length "$POSTS_FILE")"
bat ./posts.json
