#!/bin/bash
# dconf.ini hash: {{ include "dconf.ini" | sha256sum }}
# {{ include ".chezmoiscripts/.common" }}

# dconf load / < {{ joinPath .chezmoi.sourceDir "dconf.ini" | quote }}
