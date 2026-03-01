# whonb nbcode devcontainer Dockerfile


# syntax=docker/dockerfile:1
FROM node:24-bookworm

############################ 重要的sys配置 ################################

# 基本环境配置
RUN mkdir -p /etc/sudoers.d
RUN install -dm 755 /etc/apt/keyrings

# 创建 whonb 用户
RUN useradd -m -s /bin/bash whonb \
  && echo "whonb ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/whonb \
  && chmod 0440 /etc/sudoers.d/whonb

############################ system app ################################

# 安装基础工具（补充 Homebrew 所需依赖 build-essential, procps, file）
RUN apt update -y
RUN apt install -y git curl sudo locales
RUN apt install -y procps file ca-certificates bash

############################ npm ################################

# sudo npm install -g 需要 root 也要配置mirror
RUN npm config set registry https://registry.npmmirror.com/

RUN npm install -g -d bun
RUN npm install -g -d @qwen-code/qwen-code
RUN npm install -g -d @google/gemini-cli
RUN npm install -g -d @tencent-ai/codebuddy-code
RUN npm install -g -d opencode-ai
# RUN npm install -g -d @openai/codex

############################ 琐碎的sys配置 ################################

# 设置语言环境变量
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
  && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8


############################ use config ################################

# 准备 whonb 用户的环境
USER whonb


# 设置工作目录
WORKDIR /workspace
