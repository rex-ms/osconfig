## default密码：

```
password
```

## lan口推送DNS服务

用 LuCI 界面,进入 网络 → 接口 → LAN → DHCP 服务器 → 高级设置
在 DHCP 选项 里加上：
```
6,172.17.103.5,172.17.103.2,172.17.103.1
15,loongson.cn
```

解释：
6 → DNS 服务器
15 → Domain Name（会改 domain lan → domain loongson.cn）
