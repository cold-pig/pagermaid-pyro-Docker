# PagerMaid-Pyro 的搭建

PagerMaid-Pyro 是一个开源的 Telegram 人形自走 Bot 方案，功能强大而丰富，可以帮助你打造专属的便利功能。

## 版本：

| 名称                   | 版本   | 说明  |
| ---------------------- | ------ | ----- |
| coldpig/pagermaid_pyro | latest | amd64 |

## 使用方法

### 方法1: docker 运行容器
```docker
docker run -tid --name PGP --privileged=true coldpig/pagermaid_pyro:latest /sbin/init
```

### 方法2: Docker-Compose 部署参考
```docker
---
version: '3.3'
services:
  pagermaid_pyro:
    container_name: PGP
    hostname: PGP
    privileged: true
    image: coldpig/pagermaid_pyro:latest
    restart: unless-stopped
```

## 配置 PagerMaid-Pyro

> 说明：配置 PagerMaid-Pyro 过程中使用的命令，都是在宿主机上执行。不需要进入容器(`Container`)内的 shell。

在宿主机，使用 `vim` 编辑配置文件 `config.yml` 中的2个值(`api_id` 和 `api_hash`)以后，即可使用 `python3 -m pagermaid` 尝试跑起来了。
```bash
docker exec -it PGP vim config.yml
docker exec -it PGP python3 -m pagermaid
```

![根据提示填写信息](https://m.360buyimg.com/babel/jfs/t1/57205/35/21507/60368/62ffbadeE55c6f200/834bff5188efe9ed.jpg)



如果出现了这样的提示，那就说明没啥特别大的问题了，根据提示填写信息后，会提示你在 TG 客户端内输入 `,help` 指令，根据提示输入后，如果能看到消息被编辑，`Ctrl+C` 结束掉即可。



> **请注意保护好您已登录的 `pagermaid.session` 。此文件可以进行账号所有操作，请不要分享给他人使用。**



进程守护：此步骤可以方便 `pagermaid-pyro` 的自动运行，您无需在 `pagermaid-pyro` 意外退出后重新登录主机进行操作。

```bash
docker exec -it PGP systemctl daemon-reload
docker exec -it PGP systemctl start pagermaid-pyro.service
docker exec -it PGP systemctl enable pagermaid-pyro.service
```

查看进程

```bash
docker exec -it PGP ps -ef | grep pager | grep -v grep 
```

> 若 PagerMaid-Pyro 在长期运行后遇到未知原因而无法正常运行的情况，需要手动重启。命令如下：
>
> ```bash
> docker exec -it PGP systemctl restart pagermaid-pyro.service
> ```

![进程守护和查看进程](https://m.360buyimg.com/babel/jfs/t1/194309/23/27332/57334/62ffc31cEf3340139/4d4e5bb1fc940f7f.jpg)

------
项目地址：[TeamPGM/PagerMaid-Pyro](https://github.com/TeamPGM/PagerMaid-Pyro)

PagerMaid-Pyro 用户文档：[PagerMaid-Pyro](https://xtaolabs.com/)