# Command Recipes

## Quick path

1. Find the PAC file:

```bash
rg --files -g '*.pac'
rg --files -g '<name>.pac'
```

2. Inspect relevant rules:

```bash
rg -n "FindProxyForURL|return|PROXY|SOCKS|HTTPS|DIRECT" /path/to/file.pac
sed -n '1,220p' /path/to/file.pac
```

3. Resolve the local listener:

```bash
lsof -nP -iTCP:<port> -sTCP:LISTEN
```

4. Inspect the owning process:

```bash
lsof -nP -p <pid>
lsof -nP -i -a -p <pid>
ps -p <pid> -o pid,ppid,etime,command
```

## Interpretation notes

- `SOCKS5 127.0.0.1:13659` means the browser hands traffic to a local SOCKS5 proxy on port `13659`.
- `PROXY host:port` usually means an HTTP proxy.
- `DIRECT` means bypass the proxy for that match branch.
- `127.0.0.1` is not the final server. It is only the local hop.

## Reporting template

Use a compact chain:

```text
PAC rule: SOCKS5 127.0.0.1:13659
Local listener: <process-name> (PID <pid>)
Executable: <path>
Observed upstream: <remote-ip>:<remote-port>
```

## When The Process Shows No Upstream

If `lsof -nP -i -a -p <pid>` shows only local loopback connections or just the listener socket:

- say the local proxy process is confirmed
- say no active upstream endpoint is visible right now
- explain that the process may open upstream connections only when traffic flows
