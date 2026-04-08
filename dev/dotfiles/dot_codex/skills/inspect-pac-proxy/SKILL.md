---
name: inspect-pac-proxy
description: Inspect PAC files and trace where a configured proxy actually goes. Use when Codex needs to answer questions such as "how do I see the proxy used by this .pac file", "what address/port does this PAC point to", "which local process is listening on the PAC proxy port", or "what upstream proxy/server is this local listener currently connected to" on macOS or Unix-like systems.
---

# Inspect Pac Proxy

## Overview

Trace a PAC file in three layers: PAC rule, local listener, and current upstream connection. Favor quick shell inspection with `rg`, `sed`, `lsof`, and `ps`, then explain the result in plain language.

## Workflow

1. Locate the PAC file and inspect the return rules.
2. Extract the proxy protocol, host, and port from `FindProxyForURL`.
3. If the PAC points to localhost, identify which process is listening on that port.
4. Inspect that process's executable path and active outbound connections.
5. Report the proxy chain clearly: client -> PAC target -> local process -> upstream address.

## Step 1: Inspect The PAC Rule

Use `rg --files` to find the PAC file when the exact path is unknown. Use `rg -n` and `sed -n` to inspect `FindProxyForURL` and the `return` statements.

Prioritize rules that return strings such as:

- `"SOCKS5 127.0.0.1:13659; SOCKS 127.0.0.1:13659; DIRECT"`
- `"PROXY host:port"`
- `"HTTPS host:port"`

Explain that:

- `127.0.0.1` or `localhost` is the current machine, not the final remote server
- PAC files often reveal only the local handoff, not the ultimate upstream endpoint
- multiple rules may exist for different host patterns, so cite the relevant line and condition

## Step 2: Resolve Local Listener

If the PAC returns a localhost address, run:

```bash
lsof -nP -iTCP:<port> -sTCP:LISTEN
```

This identifies the listening process. If needed, inspect the process with:

```bash
lsof -nP -p <pid>
lsof -nP -i -a -p <pid>
ps -p <pid> -o pid,ppid,etime,command
```

Use the executable path from `lsof -p <pid>` to name the owning application when possible.

## Step 3: Identify Upstream Endpoint

Inspect outbound connections from the listener process. Active lines like:

```text
TCP 30.48.147.194:62435->116.62.134.182:443 (ESTABLISHED)
```

indicate the current upstream address and port. Report this as an observed live connection, not necessarily the only possible upstream.

If no outbound connection exists yet, say so directly and explain that the process may be idle or waiting for traffic.

## Step 4: Communicate Clearly

When summarizing, separate these facts:

- PAC-declared proxy target
- local listening process
- executable path or owning app
- currently observed upstream remote IP and port

Prefer wording like:

- "The PAC points browsers to `127.0.0.1:13659`."
- "That port is listened to by process `AliMgrSoc`."
- "That process currently has established outbound connections to `116.62.134.182:443`."

Do not overclaim that the upstream IP is a permanent configuration unless it is visible in a config file.

## Sandboxing And Permissions

Read-only inspection usually works without escalation, but some `ps` invocations or writes outside the workspace may fail under sandboxing. If a command needed to complete the inspection fails with a sandbox denial, rerun it with escalated permissions using the standard approval flow.

## Validation

Run the built-in fallback validator when the shared `quick_validate.py` script cannot run because `PyYAML` is unavailable:

```bash
python3 scripts/validate_skill.py .
```

## References

Load [references/command-recipes.md](references/command-recipes.md) when you need concrete command templates or a compact decision tree.
