import requests as req
import os

def send(message,title="Log",status="success"):

    discord_webhook=os.getenv("DISCORD_WEBHOOK_URL")
    if discord_webhook:
        color = 3066993 if status.lower() == "success" else 15158332
        payload = {
                "username": "Vicuna Bot",
                "embeds": [{
                    "title": title,
                    "color": color,
                    "fields": [
                        {"name": status, "value": f"`{message}`", "inline": True}
                    #  {"name": "Commit", "value": f"[`{commit_sha[:7]}`](https://github.com/repo/commit/{commit_sha})", "inline": True}
                    ],
                    "footer": {"text": "CI/CD Automation • 2026"}
                }]
            }
        req.post(discord_webhook,json=payload)
    else:
        print("[x] could not find DISCORD_WEBHOOK_URL in the environment.")