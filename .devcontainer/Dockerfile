FROM mcr.microsoft.com/devcontainers/typescript-node:20

# 切换到 root 用户安装工具
USER root

# 安装 GitHub CLI (gh)
RUN type -p curl >/dev/null || (apt-get update && apt-get install curl -y) \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install gh -y

# 设置 pnpm
# RUN corepack enable && corepack prepare pnpm@10.30.2 --activate

# 设置工作目录
WORKDIR /workspaces/nbcode

# 为系统设置 git 安全目录（对所有用户生效）
RUN git config --system --add safe.directory /workspaces/nbcode

# 设置非 root 用户
USER node

# 默认命令
CMD ["bash"]
