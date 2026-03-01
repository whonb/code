# syntax=docker/dockerfile:1
FROM oven/bun

# 基本环境配置
RUN mkdir -p /etc/sudoers.d
RUN install -dm 755 /etc/apt/keyrings

# 创建 whonb 用户
RUN useradd -m -s /bin/bash whonb \ 
  && echo "whonb ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/whonb \
  && chmod 0440 /etc/sudoers.d/whonb

# 安装基础工具（补充 Homebrew 所需依赖 build-essential, procps, file）
RUN apt update -y \
  && apt install -y git curl sudo locales 
# 安装 Homebrew 所需依赖
RUN apt install -y build-essential procps file

# 安装指定版本的 Node.js (例如 20.4.0)
ENV NODE_VERSION=20.4.0
RUN curl -fsSL "https://npmmirror.com/mirrors/node/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" -o node.tar.xz \
    && mkdir -p /usr/local/lib/nodejs \
    && tar -xJf node.tar.xz -C /usr/local/lib/nodejs --strip-components=1 \
    && rm node.tar.xz

# 将 Node 和全局安装路径加入 PATH
ENV PATH="/usr/local/lib/nodejs/bin:${PATH}"

# 准备 whonb 用户的环境
COPY --chown=whonb:whonb sync-home/.npmrc /home/whonb/.npmrc
USER whonb

# 配置非root用户工具
RUN npm install -g @qwen-code/qwen-code
# RUN npm install -g @google/gemini-cli
# RUN npm install -g @tencent-ai/codebuddy-code
# RUN npm install -g @openai/codex
# RUN npm install -g opencode-ai


# 安装 Homebrew 并配置国内镜像 (清华大学 TUNA 镜像)
# RUN --mount=type=bind,source=sync-home/.npmrc,target=/home/whonb/.npmrc \
#     --mount=type=cache,target=/home/node/.npm,uid=1000,gid=1000 \
#     npm install --loglevel=verbose -g \
#     @google/gemini-cli \
#     @qwen-code/qwen-code \
#     @tencent-ai/codebuddy-code \
#     @openai/codex \
#     opencode-ai

# ENV HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api" \
#     HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git" \
#     HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git" \
#     HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew/homebrew-bottles"
# aliyun的安装
# RUN git clone https://mirrors.aliyun.com/homebrew/install.git brew-install
# RUN git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git /tmp/brew-install 
# RUN NONINTERACTIVE=1 /bin/bash /tmp/brew-install/install.sh \
#   && rm -rf /tmp/brew-install
# ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# RUN --mount=type=bind,source=.cache/home/whonb,target=/home/whonb \
#   mise use -g node@20



# 设置工作目录
WORKDIR /workspace

