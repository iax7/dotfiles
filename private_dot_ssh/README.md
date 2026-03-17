# SSH Configuration

## Arch

for ssh-agent autoload key on login you need:

```bash
sudo pacman -S gcr-4
systemctl --user enable --now gcr-ssh-agent.socket
```

```config
Include config.lan.conf
Include config.cloud.conf

Host *
  # force ipv4. nvim in arch: had Could not resolve host: github.com
  AddressFamily inet
  SendEnv LANG LC_*
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
  PreferredAuthentications publickey
  PubkeyAuthentication yes
  AddKeysToAgent yes
  ServerAliveInterval 60
  ServerAliveCountMax 3
  HashKnownHosts yes
  UpdateHostKeys yes
```

## MacOS

```bash
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Use this config file as reference:

```config
Host *
  # Don't install brew openssh in order to use these:
  UseKeychain yes
  AddKeysToAgent yes

  # Connection settings
  ServerAliveInterval 60
  ServerAliveCountMax 3
  TCPKeepAlive yes

  # Connection multiplexing (speeds up multiple connections to same host)
  ControlMaster auto
  ControlPath ~/.ssh/sockets/%r@%h:%p
  ControlPersist 10m

  # Security settings
  HashKnownHosts yes
  StrictHostKeyChecking ask
  VerifyHostKeyDNS yes

  # Compression (useful for slow connections)
  Compression yes

  # Forward agent (be careful with untrusted hosts)
  ForwardAgent no

  # Prefer IPv4 (can be changed to 'inet6' or removed)
  AddressFamily inet
```
