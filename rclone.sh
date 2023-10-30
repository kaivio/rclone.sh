#!/usr/bin/env bash

base_dir="$HOME/.config/rclone"
mkdir -p "$base_dir"

function alist_start(){
  alist server --data "$base_dir/data" &
  pid=$!
}

function alist_stop(){
  kill $pid
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

if ! [ -f "$base_dir/rclone.sh.conf" ]; then
    cat <<EOF > "$base_dir/rclone.sh.conf"
[@cwd]      
type = local

[@index]
type = combine
upstreams = @cwd=@cwd:
EOF
fi


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
