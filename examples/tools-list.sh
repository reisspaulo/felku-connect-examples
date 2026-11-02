#!/bin/sh
# Lists the tools your key can see. Set FELKU_CONNECT_KEY first (placeholder: fkc_YOUR_KEY).
curl -sS --fail-with-body https://mcp.felku.com.br/mcp \
  -H "Authorization: Bearer ${FELKU_CONNECT_KEY:?set FELKU_CONNECT_KEY, e.g. fkc_YOUR_KEY}" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'
