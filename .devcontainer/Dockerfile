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

# 安装 Homebrew 并配置国内镜像 (清华大学 TUNA 镜像)
ENV HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git" \
    HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git" \
    HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles" \
    HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

RUN echo "--- BUILDING IN: $(pwd) ---"

USER whonb
RUN git clone https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git /tmp/brew-install 
RUN NONINTERACTIVE=1 /bin/bash /tmp/brew-install/install.sh \
  && rm -rf /tmp/brew-install

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# RUN --mount=type=bind,source=.cache/home/whonb,target=/home/whonb \
#   curl https://mise.run | sh
# RUN ~/.local/bin/mise --version

# RUN --mount=type=bind,source=.cache/home/whonb,target=/home/whonb \
#   mise use -g node@20

# # 安装所有 AI 工具并利用缓存加速
# # RUN --mount=type=cache,target=/home/node/.npm,uid=1000,gid=1000 \
# #     npm install --loglevel=verbose -g \
# #     @google/gemini-cli \
# #     @qwen-code/qwen-code \
# #     @tencent-ai/codebuddy-code \
# #     @openai/codex \
# #     opencode-ai
# RUN --mount=type=bind,source=sync-home/.npmrc,target=/home/whonb/.npmrc \
#     --mount=type=cache,target=/home/node/.npm,uid=1000,gid=1000 \
#     npm install --loglevel=verbose -g \
#     @google/gemini-cli \
#     @qwen-code/qwen-code \
#     @tencent-ai/codebuddy-code \
#     @openai/codex \
#     opencode-ai


# # 配置 locale
# RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen
# RUN locale-gen en_US.UTF-8
# # 设置 locale 环境变量
# ENV LANG=en_US.UTF-8
# ENV LC_ALL=en_US.UTF-8

# 设置工作目录
WORKDIR /workspace/main

