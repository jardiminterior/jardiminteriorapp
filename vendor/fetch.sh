#!/usr/bin/env bash
# vendor/fetch.sh — baixa React 18 + ReactDOM 18 + Babel Standalone 7.23.10
# Rode UMA VEZ com internet. Depois o jardim-interior-prototipo.html
# funciona offline (inclusive em PWA).
#
# Uso:
#   cd vendor && bash fetch.sh
#
# Não precisa de npm, node ou build step. Requer apenas curl.

set -e

cd "$(dirname "$0")"

echo "→ baixando react.development.js …"
curl -fsSL "https://unpkg.com/react@18.2.0/umd/react.development.js" \
  -o react.development.js

echo "→ baixando react-dom.development.js …"
curl -fsSL "https://unpkg.com/react-dom@18.2.0/umd/react-dom.development.js" \
  -o react-dom.development.js

echo "→ baixando babel.min.js (standalone) …"
curl -fsSL "https://unpkg.com/@babel/standalone@7.23.10/babel.min.js" \
  -o babel.min.js

echo
echo "pronto. tamanhos:"
ls -lh react.development.js react-dom.development.js babel.min.js | awk '{print "  " $5 "  " $9}'
echo
echo "agora o jardim abre offline."
