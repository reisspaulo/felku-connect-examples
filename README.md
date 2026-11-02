# Felku Connect: examples

Configuration examples for [Felku Connect](https://mcp.felku.com.br/), a hosted MCP connector that lets an AI agent
read and reply on WhatsApp and Telegram. This repository holds only client configs; the service itself is not open source.

## What it is

You pair a WhatsApp number once by QR code (a linked device, like WhatsApp Web) and/or a Telegram bot. The session runs
on Felku's server, so nothing stays running on your machine. Your agent talks to it over MCP (streamable HTTP) at
`https://mcp.felku.com.br/mcp`.

## Security

1. Limits live on the server, not in the agent: pacing, hourly and daily caps (low on a new connection), a cap on first messages to new contacts, and an automatic pause when connection drops pile up.
2. The agent only reads and replies to contacts on your allowlist; everyone else is dropped on arrival. The agent can read a WhatsApp group only after you enable it.
3. Keys can be read-only, or limited to specific permissions. Messages reach the agent marked as untrusted data, and risky actions need your approval in the dashboard; this lowers prompt-injection risk, it does not remove it.
4. You are responsible for the third-party data your agent reads (contacts and groups), including under LGPD/GDPR.

**Unofficial WhatsApp connection.** Felku connects to WhatsApp the way WhatsApp Web does, as a linked device, using the open-source Baileys library. It is not the official WhatsApp Business Platform, and Felku is not affiliated with or endorsed by WhatsApp, Meta or Telegram. Automated use of a personal account may go against WhatsApp's Terms of Service: WhatsApp can temporarily or permanently ban the number. The server-side limits lower that risk; they do not remove it. Use a dedicated number you can afford to lose. Telegram uses the official Bot API.

See the [Terms](https://mcp.felku.com.br/en/termos/) and the [Privacy Policy](https://mcp.felku.com.br/en/privacidade/).

## Connect

Create an account and pair a number in the dashboard first: https://mcp.felku.com.br/

**Claude.ai (OAuth).** Add a custom connector in Claude.ai with the URL `https://mcp.felku.com.br/mcp` and sign in
when asked; no key to copy. Tested with Claude.ai (OAuth): listing groups and communities and reading messages from an enabled group.

**Claude Code (API key).**
```sh
export FELKU_CONNECT_KEY="fkc_YOUR_KEY"
claude mcp add --transport http felku-connect https://mcp.felku.com.br/mcp \
  --header "Authorization: Bearer $FELKU_CONNECT_KEY"
```
Or commit [`examples/claude-code.mcp.json`](examples/claude-code.mcp.json) as `.mcp.json` (keep the real key out of git).

**Cursor.** Copy [`examples/cursor.mcp.json`](examples/cursor.mcp.json) to `~/.cursor/mcp.json` (or `.cursor/mcp.json` in a project).

**Any other MCP client.** Point it at `https://mcp.felku.com.br/mcp` over streamable HTTP with the header
`Authorization: Bearer <key>`. To check that the key works, run [`examples/tools-list.sh`](examples/tools-list.sh).

Keys start with `fkc_`, are shown once, and are created in the dashboard under Agents and keys.

## Docs

- Docs: https://mcp.felku.com.br/en/docs/
- Tools: https://mcp.felku.com.br/en/docs/ferramentas/

## License

MIT for the files in this repository.

WhatsApp is a trademark of WhatsApp LLC; Telegram is a trademark of Telegram FZ-LLC; Claude is a trademark of Anthropic; Cursor is a trademark of its owner. All other names belong to their owners.
