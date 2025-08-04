"""
Modify v2ray config to add a outbound to chain the original outbound
"""

import json
import argparse


def main():
    parser = argparse.ArgumentParser(
        description="Add a us-proxy outbound to a config file."
    )
    parser.add_argument(
        "config_path",
        type=str,
        help="Path to the input config file (default: downloads/config.json)",
    )
    parser.add_argument(
        "--output-path",
        type=str,
        default="config_modified.json",
        help="Path to save the modified config file (default: downloads/config_modified.json)",
    )
    args = parser.parse_args()

    config_path = args.config_path
    output_path = args.output_path

    with open(config_path, "r", encoding="utf-8") as f:
        config = json.load(f)

    # 1. Find the original outbound tag (e.g., "proxy")
    original_outbound_tag = None
    for outbound in config.get("outbounds", []):
        if "tag" in outbound:
            original_outbound_tag = outbound["tag"]
            break

    if not original_outbound_tag:
        print("No outbound tag found in config.")
        return

    print(f"Original outbound tag: {original_outbound_tag}")

    # 2. Prompt user for new SOCKS outbound info
    print("You can input the SOCKS outbound info in two ways:")
    print("1. Enter all info in one line, format: <ip>:<port>:<username>:<password>")
    print("2. Enter each field one by one (press Enter to choose this mode)")

    combo_input = input("Input (or press Enter to input fields one by one): ").strip()
    if combo_input:
        try:
            address, port, user, password = combo_input.split(":")
            port = int(port)
        except Exception as e:
            print("Invalid format. Please use <ip>:<port>:<username>:<password>")
            return
    else:
        address = input("Server IP address: ").strip()
        port = int(input("Server port: ").strip())
        user = input("Username: ").strip()
        password = input("Password: ").strip()

    # 3. Create new outbound dict (like the us-proxy example)
    new_outbound = {
        "tag": "us-proxy",
        "protocol": "socks",
        "settings": {
            "servers": [
                {
                    "address": address,
                    "port": port,
                    "users": [{"user": user, "pass": password}],
                }
            ]
        },
        "proxySettings": {"tag": original_outbound_tag},
    }

    # 4. Add new outbound to outbounds list
    config["outbounds"].append(new_outbound)

    # 5. Update routing rules: change outboundTag from original to "us-proxy"
    for rule in config.get("routing", {}).get("rules", []):
        if rule.get("outboundTag") == original_outbound_tag:
            rule["outboundTag"] = "us-proxy"

    # 6. Save the updated config
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(config, f, indent=2, ensure_ascii=False)

    print(f"Updated config saved to {output_path}")


if __name__ == "__main__":
    main()
