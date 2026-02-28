# syntax=docker/dockerfile:1
FROM oven/bun

# 安装基础工具并创建 whonb 用户
RUN apt-get update && apt-get install -y \
    git \
    curl \
    sudo \
    && useradd -m -s /bin/bash whonb \
    && echo "whonb ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/whonb \
    && chmod 0440 /etc/sudoers.d/whonb

# 设置工作目录
WORKDIR /workspaces/main

# 切换到 whonb 用户
# USER whonb