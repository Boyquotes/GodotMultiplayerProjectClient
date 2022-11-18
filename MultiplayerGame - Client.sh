#!/bin/sh
echo -ne '\033c\033]0;MultiplayerGame - Client\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/MultiplayerGame - Client.x86_64" "$@"
