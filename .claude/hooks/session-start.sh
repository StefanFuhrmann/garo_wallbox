#!/bin/bash
set -euo pipefail

# Nur in Claude-Code-Cloud-Sessions ausführen.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Feste, vorab geprüfte Version von REA (https://github.com/morluto/rea).
REA_VERSION="6.7.0"

# Idempotent: nichts tun, wenn genau diese Version schon installiert ist.
if command -v rea >/dev/null 2>&1 && \
   [ "$(npm ls --global --depth=0 --json 2>/dev/null | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>{try{console.log(JSON.parse(s).dependencies["rea-agents"].version)}catch{console.log("")}})')" = "$REA_VERSION" ]; then
  exit 0
fi

npm install --global "rea-agents@${REA_VERSION}"
