# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/devcontainers/typescript-node:20

# 拷贝 home 目录配置并设置权限
# COPY --chown=node:node ./sync-home/ /home/node/

# 安装所有 AI 工具并利用缓存加速
# RUN --mount=type=cache,target=/home/node/.npm,uid=1000,gid=1000 \
#     npm install --loglevel=verbose -g \
#     @google/gemini-cli \
#     @qwen-code/qwen-code \
#     @tencent-ai/codebuddy-code \
#     @openai/codex \
#     opencode-ai
# RUN --mount=type=bind,source=.devcontainer/sync-home,target=/home/node \
#     --mount=type=cache,target=/home/node/.npm,uid=1000,gid=1000 \
#     npm install --loglevel=verbose -g \
#     @qwen-code/qwen-code 
RUN --mount=type=bind,source=sync-home/.npmrc,target=/home/node/.npmrc \
    --mount=type=cache,target=/home/node/.npm,uid=1000,gid=1000 \
    npm install --loglevel=verbose -g \
    @qwen-code/qwen-code 

# WORKDIR /workspace