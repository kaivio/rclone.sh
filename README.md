# rclone.sh

通过 rclone 共享文件的便捷脚本


## 笔记
```
~/.config/rclone
  - rclone.conf     # 默认的配置文件，用于挂载本地设备
  - rclone.sh.conf  # 第二配置文件，用于挂载互联网服务，加密
  - data/           # alist数据库
```

通过 `rclone.sh` 驱动 rclone.sh.conf 和 alist 共享存储系统

```sh
rclone.sh dav
rclone.sh ftp
rclone.sh http
```

# 用法

在rclone.sh.conf添加webdav挂载alist

```conf
[alist]
type = webdav
url = http://localhost:5244/dav/
vendor = other
user = admin
pass = 123456
```

在rclone.sh.conf添加combine列出所有存储

```conf
[index]
type = combine
upstreams = alist=alist: s3=s3: remote=remote: 
```

启动共享（这时应该需要密码解密配置文件）

```sh
rclone.sh dav
```

在默认配置文件挂载此共享
```
[sh]
type = webdav
url = http://localhost:8021
vendor = other
```



