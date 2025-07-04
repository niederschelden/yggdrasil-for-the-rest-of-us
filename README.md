# Yggdrasil for the Rest of Us

A simple Docker setup for running [Yggdrasil](https://yggdrasil-network.github.io/) – the decentralized IPv6 networking protocol – with minimal hassle. This project is aimed at beginners or anyone who wants to get a working Yggdrasil node up and running quickly in a containerized environment.

This project was inspired and based in part on:

- [Ravenstine's Yggdrasil Docker Gist](https://gist.github.com/Ravenstine/707180ef29e9d37a8f816e019ca32dbf)

Thank you for making your work publicly available!

This repository provides:
- A Dockerfile to build an Alpine-based image with Yggdrasil and basic tools.
- An `entrypoint.sh` script that auto-generates config if missing.
- A `docker-compose.yml` to start Yggdrasil in a ready-to-use container.
- Basic instructions for setting up public peers and verifying connectivity.

This repository demands:
- A Linux or Mac OS system with Docker installed.
- Windows is untested but should work with minimal changes - I guess :-/

---

## Getting Started

### 1. Clone this repository

```bash
git clone https://github.com/niederschelden/yggdrasil-for-the-rest-of-us.git
cd yggdrasil-for-the-rest-of-us
```

### 2. Create necessary folders and files

Yggdrasil needs a place to store its configuration. Create the `yggdrasil/` folder:

```bash
mkdir yggdrasil
```
You might want to specify a MAC address (optional):

```bash
cat <<EOF > .env
YGG_MAC=02:42:ac:11:00:02
EOF
```

### 3. Build and start the container

```bash
docker-compose up --build -d
```

This will:
- Build the Docker imag
- Generate a fresh config if one doesn’t exist
- Start the Yggdrasil in foreground (this will keep the container alive)

---

## Add Public Peers

To connect your node to the wider Yggdrasil network, edit the generated config file (`yggdrasil/yggdrasil.conf`) and add some public peers.

[You can find up-to-date public peers here](https://publicpeers.neilalexander.dev/)

Example snippet to add under the `Peers` section:

```json
"Peers": [
    "tls://[sometingfromthelinkabove]:443",
    "tcp://[sometingfromthelinkabove]:80"
]
```

**After editing the config, restart the container:**

```bash
docker-compose restart
```

---

## Test if it works

Once the container is running, enter it:

```bash
docker exec -it yggdrasil /bin/bash
```

Then run:

```bash
yggdrasilctl getSelf
```

This will output information about your node, such as your IPv6 address and current peer connections.

You can also test network connectivity via IPv6:

```bash
curl -g -6 "http://[Your_Yggdrasil_IP]/"
```

Or try:

```bash
lynx http://[Another_Yggdrasil_Node_IP]/
```

---

## Troubleshooting

- Make sure `/dev/net/tun` exists on your host (required for TUN support).
- Ensure `docker-compose` and Docker are installed and functional.
- Firewall issues? Try running with elevated privileges or check that UDP and TCP traffic can reach your peers.

---

## Why "For the Rest of Us"?

Because networking doesn't have to be painful.

---


