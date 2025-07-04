#!/bin/bash
set -e

CONF="/etc/yggdrasil/yggdrasil.conf"

# Wenn keine Konfig existiert, eine neue erzeugen
if [ ! -f "$CONF" ]; then
    echo "No config found – generating fresh config..."
    yggdrasil -genconf > "$CONF"
fi

# Start im Vordergrund – Container bleibt dadurch aktiv
exec yggdrasil --useconffile "$CONF"
