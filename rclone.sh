#!/usr/bin/env bash

base_dir="$HOME/.config/rclone"
mkdir -p "$base_dir"

function alist_start(){
  alist start --data "$base_dir/data"
}

function alist_stop(){
  alist stop
}


function sh_dav(){
  alist_start
  rclone --config "$base_dir/rclone.sh.conf" serve webdav @index: --addr :8021
  alist_stop
}

function sh_ftp(){
  alist_start
  rclone --config "$base_dir/rclone.sh.conf" serve ftp @index: --addr :2121
  alist_stop
}

function sh_http(){
  alist_start
  rclone --config "$base_dir/rclone.sh.conf" serve http @index: --addr :8000
  alist_stop
}

rclone --config "$base_dir/rclone.sh.conf" config touch
if [ -z "$1" ]; then
    echo "alive"
elif [ "$1" = "dav" ]; then
    sh_dav
elif [ "$1" = "webdav" ]; then
    sh_dav
elif [ "$1" = "ftp" ]; then
    sh_ftp
elif [ "$1" = "http" ]; then
    sh_http
else
    rclone --config "$base_dir/rclone.sh.conf" "$@"
fi
