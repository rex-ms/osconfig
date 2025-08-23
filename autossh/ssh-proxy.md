##  端口转发

### 1.动态端口转发（SOCKS代理）

可以使用如下命令
			
```
ssh -Nf -D 1080 -J loongson@10.40.48.77:22 baolei@192.168.0.38 -p 22
```

进阶方法，使用autossh防止断连

```
#!/bin/bash
IP=$1
autossh -M 2000 -N -f -o "ProxyJump=loongson@$IP:22" -D 1080 baolei@192.168.0.38

```

### 2.本地端口转发

```
ssh -Nf -L 7890:127.0.0.1:18890 -J loongson@10.40.48.77:22 baolei@192.168.0.38 -p 22
```

上述的127.0.0.1:18890为baolei@192.168.0.38:22这台机器上通过clash搭建的代理。
如果192.168.0.38可以使用其它的代理，如在其它机器上搭建的代理（10.2.10.197:7890）

上面的命令可以写成：

```
ssh -Nf -L 7890:10.2.10.197:7890 -J loongson@10.40.48.77:22 baolei@192.168.0.38:22
```

## 将socket代理转化为http代理

上述使用动态端口转发生成的是socket代理，在使用时有些应用部支持socket代理，将其转化为http代理。

### install deb
```
apt-get install proxychains privoxy
```

### config proxychains

配置proxychains在本地开启http代理

```
➜  ~ cat /etc/proxychains.conf
# proxychains.conf  VER 3.1
#
#        HTTP, SOCKS4, SOCKS5 tunneling proxifier with DNS.
#	
#        Examples:
#
#            	socks5	192.168.67.78	1080	lamer	secret
#		http	192.168.89.3	8080	justu	hidden
#	 	socks4	192.168.1.49	1080
#	        http	192.168.39.93	8080	
#		
#
#       proxy types: http, socks4, socks5
#        ( auth types supported: "basic"-http  "user/pass"-socks )
#
[ProxyList]
# add proxy here ...
# meanwile
# defaults set to "tor"
#socks4 	127.0.0.1 9050
http 0.0.0.0 18118
https 0.0.0.0 18118
```
### config privoxy

配置privoxy，将1080 socket5端口上的流量转到http的18118上

修改/etc/privoxy/config配置文件

1.修改1388行
将
```
#        forward-socks5t   /               127.0.0.1:9050 .
```
改为
```
        forward-socks5t   /               127.0.0.1:1080 .
```
2.修改781行
将
```
listen-address  127.0.0.1:8118
```
改为
```
listen-address  127.0.0.1:18118
```

## 使用
上述配置好后，重启服务，可以配置代理使用。
```
export http_proxy=http://127.0.0.1:18118
export https_proxy=http://127.0.0.1:18118
```
