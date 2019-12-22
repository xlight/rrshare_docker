# rrshare
 rrshare for docker（基于alpine+最新版人人影视客户端）

### 人人影视web下载器（rrshare for docker）

### 手动执行
```
docker run -d -p 3001:3001 -v /opt/rrdata:/opt/work/store  -v /opt/rrconf:/opt/work/conf --name rrshare xlight/rrshare   #仅16MB
```

访问http://ip:3001 打开后台 解锁密码默认为123456，可在设置里面修改
参数说明：
- －ｐ　3001端口可自定义，比如想改成80端口，可以改为-p 80:3001
- －ｖ　用于宿主机挂载下载后文件目录，可通过根目录/opt/rrdata查看


建议配合 jellyfin 使用

### 关于停止、启动、删除
```
docker stop rrshare     # 停止运行人人影视
docker start rrshare    # 启动
docker rm rrshare       # 删除容器
```
