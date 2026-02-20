# agentnotify

Send OTP/authorization challenges via [ntfy](https://ntfy.sh).

## Usage

```bash
./notify.sh <topic> <message> [title] [priority]
```

**Examples:**

```bash
# Send an OTP challenge
./notify.sh my-topic "Code: 141414" "Login Request" high

# With a self-hosted ntfy server
NTFY_SERVER=https://ntfy.example.com ./notify.sh my-topic "Authorize login?"
```

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `NTFY_SERVER` | `https://ntfy.sh` | ntfy server URL |
| `NTFY_TOKEN` | _(none)_ | Bearer token for authenticated topics |

## Requirements

- `curl`
- `jq`

## License

MIT
