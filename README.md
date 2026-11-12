# Felku Connect: examples

Configuration examples for [Felku Connect](https://mcp.felku.com.br/), a hosted MCP server that connects your AI agent
to WhatsApp and Telegram, so it can read and reply in the chats you allow. This repository holds only client configs;
the service itself is not open source.

Also in [Português](https://mcp.felku.com.br/pt/) and [Español](https://mcp.felku.com.br/es/).

## What it is

You pair a WhatsApp number once by QR code (a linked device, like WhatsApp Web) and/or connect a Telegram bot. The
session runs on Felku's server, so nothing stays running on your machine. Your agent talks to it over MCP
(Streamable HTTP) at `https://mcp.felku.com.br/mcp`.

Works with Claude.ai, Claude Code, Codex, Cursor, Hermes and any MCP client that speaks HTTP.

## Security

1. Limits live on the server, not in the agent: pacing, hourly and daily caps (lower on a new connection), a cap of up to 3 first messages a day to people who never wrote to the number, and an automatic pause when drops, send failures or restriction warnings pile up. Only a person resumes a paused connection.
2. The agent only reads and replies to the contacts on your list; messages from anyone else are dropped on arrival and every send outside the list is denied. A WhatsApp group is not on that list: the agent can read it only after you approve it in the dashboard.
3. Keys can be read-only or limited to specific permissions (new keys start with read only). High-risk actions come switched off and need a specific key permission; every send or action in a WhatsApp group, community or channel also needs your approval in the dashboard. Ordinary sends to contacts on your list go out directly, within the limits.
4. Messages reach the agent marked as untrusted data. That lowers prompt-injection risk, it does not remove it: set your agent to treat messages as content, never as instructions.
5. When your agent reads a chat, the text goes to the AI provider the agent uses (Anthropic, OpenAI, Google...), under that provider's rules.
6. You are responsible for the third-party data your agent reads (contacts and groups), including under LGPD/GDPR.

**Unofficial WhatsApp connection.** Felku connects to WhatsApp the way WhatsApp Web does, as a linked device, using the open-source Baileys library. It is not the official WhatsApp Business Platform, and Felku is not affiliated with, sponsored or endorsed by WhatsApp, Meta, Telegram, Anthropic, OpenAI or Cursor. Automated use of a personal account may go against WhatsApp's Terms of Service: WhatsApp can temporarily or permanently ban the number. The server-side limits lower that risk; they do not remove it. Use a dedicated number you can afford to lose. More in [Will my WhatsApp number get banned?](https://mcp.felku.com.br/guides/will-my-whatsapp-number-get-banned/). Telegram uses the official Bot API.

See [Security and risks](https://mcp.felku.com.br/en/seguranca/), the [Terms](https://mcp.felku.com.br/en/termos/) and the [Privacy Policy](https://mcp.felku.com.br/en/privacidade/).

## Connect

Create an account and connect WhatsApp or Telegram in the dashboard first: https://mcp.felku.com.br/
Until a channel is connected, every request returns `connection_required` (the key is fine; connect a channel and try again).

Keys start with `fkc_`, are shown once, and are created in the dashboard under **Agents and keys**. Never put a real
key in a file that goes to Git.

**Claude.ai (OAuth).** Add a custom connector with the URL `https://mcp.felku.com.br/mcp` and sign in when asked; no
key to copy. Step by step: [Connect WhatsApp to Claude.ai](https://mcp.felku.com.br/guides/connect-whatsapp-to-claude-ai-connector/).

**Claude Code.**
```sh
export FELKU_CONNECT_KEY="fkc_YOUR_KEY"
claude mcp add --transport http felku-connect https://mcp.felku.com.br/mcp \
  --header "Authorization: Bearer $FELKU_CONNECT_KEY"
```
The shell expands `$FELKU_CONNECT_KEY`, so the key is stored in `~/.claude.json` (this project's entry), not in the
project. Never use `--scope user`: every agent in every project would get your WhatsApp. If you prefer a config file, [`examples/claude-code.mcp.json`](examples/claude-code.mcp.json)
reads the key from the `FELKU_CONNECT_KEY` environment variable.

**Codex.**
```sh
codex mcp add felku-connect --url https://mcp.felku.com.br/mcp \
  --bearer-token-env-var FELKU_CONNECT_KEY
```

**Cursor.** Copy [`examples/cursor.mcp.json`](examples/cursor.mcp.json) to `~/.cursor/mcp.json` (or to
`.cursor/mcp.json` in a project, kept out of Git). It reads the key from the `FELKU_CONNECT_KEY` environment variable.

**Any other MCP client.** Point it at `https://mcp.felku.com.br/mcp` over Streamable HTTP with the header
`Authorization: Bearer <key>`. To check that the key works, run [`examples/tools-list.sh`](examples/tools-list.sh).

All clients, including Hermes: [Connect your agent](https://mcp.felku.com.br/en/docs/agentes/).

## Chat history (optional)

Off by default. You turn it on per connection in the dashboard, after reading a short notice:

- **Turned on before you pair:** WhatsApp sends a first batch of recent one-to-one chats right after pairing.
- **Turned on later:** history starts from that moment; older messages don't come.
- **Contact added later** (with history on since pairing): Felku fetches that chat's recent messages, up to your account's limit, while your phone is online.

Only one-to-one chats with contacts on your list; groups are not included. History is kept for your plan's retention
period, like any received message. Turning it off, or removing a contact from the list, deletes it right away.
See the [Privacy Policy](PRIVACY_LINK_TBD).

## Not available yet

Fetching received media (images or documents) and transcribing audio.

## Docs

- Docs: https://mcp.felku.com.br/en/docs/ ([Português](https://mcp.felku.com.br/docs/), [Español](https://mcp.felku.com.br/es/docs/))
- Tools: https://mcp.felku.com.br/en/docs/ferramentas/
- Limits and ban risk: https://mcp.felku.com.br/en/docs/limites/

## License

MIT for the files in this repository.

WhatsApp, Telegram, Claude, Codex and Cursor are trademarks of their respective owners.
