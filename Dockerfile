FROM ubuntu:22.04

# 设置非交互模式
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /root/pagermaid_pyro
ENV MYPATH /root/pagermaid_pyro
WORKDIR $MYPATH
RUN echo "Start Installing..." \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -y \
        init \
        git \
        wget \
        curl \
        screen \
        vim \
        cron \
        imagemagick \
        neofetch \
        libwebp-dev \
        libzbar-dev \
        libxml2-dev \
        libxslt-dev \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-chi-sim \
        tesseract-ocr-chi-sim-vert \
        tesseract-ocr-chi-tra \
        tesseract-ocr-chi-tra-vert \
        language-pack-zh-hans \
        python3-pip \
        sudo \
        openssl \
        ffmpeg \
        fortune-mod \
        figlet \
        libmagic1 \
        libzbar0 \
        iputils-ping \
    # && apt-get install --no-install-recommends -y tzdata \
    && apt-get install -y tzdata \
    # 设置时区为 Asia/Shanghai
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    # 清理缓存以减小镜像体积
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/*

## 升级pip
RUN python3 -m pip install --upgrade pip

## 克隆 「git仓库」到「docker 镜像中」
RUN cd $MYPATH \
    && git clone https://github.com/TeamPGM/PagerMaid-Pyro.git .

## 安装依赖
RUN cd $MYPATH && pip3 install -r requirements.txt

## 生成 `config.yml`
RUN cd $MYPATH && cp config.gen.yml config.yml

#### 进程守护
## COPY 「pagermaid-pyro.service」到 「docker 镜像中」
COPY ./pagermaid-pyro.service /etc/systemd/system/pagermaid-pyro.service

CMD ["/sbin/init"]
