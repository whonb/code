# Dev Container 配置

本项目包含 VS Code Dev Container 配置，用于提供一致的开发环境。

## 快速开始

### 使用 VS Code

1. 安装 [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 扩展
2. 打开项目文件夹
3. 当提示 "Reopen in Container" 时，点击该按钮
4. 等待容器构建完成（首次构建可能需要几分钟）

### 使用 GitHub Codespaces

1. 在 GitHub 仓库页面点击 "Code" 按钮
2. 选择 "Codespaces" 选项卡
3. 点击 "Create codespace on main"

## 配置说明

### `devcontainer.json`

主要配置文件，包含：

- **镜像**: 使用 Node.js 20 + TypeScript 的官方开发容器镜像
- **功能**: 包含 GitHub CLI 和 Git
- **VS Code 扩展**:
  - TypeScript 语言支持
  - ESLint 代码检查
  - Prettier 代码格式化
  - Tailwind CSS 支持（如需要）
  - JSON 支持
- **容器创建后命令**: 启用 pnpm 并安装依赖
- **端口转发**: 可根据需要配置

### `Dockerfile`

自定义 Dockerfile，提供：

- 基于官方 TypeScript-Node 镜像
- 预装 pnpm 包管理器
- 使用非 root 用户 (`node`) 运行

### `.env`

开发环境变量配置模板。

## 开发环境特性

- **Node.js 20**: 符合项目要求的 Node 版本
- **pnpm**: 项目指定的包管理器
- **TypeScript**: 完整的 TypeScript 开发环境
- **ESLint**: 代码规范和检查
- **Git**: 版本控制工具
- **GitHub CLI**: GitHub 命令行工具

## 常见问题

### 容器构建失败

检查网络连接，确保可以访问 Docker 镜像仓库。

### pnpm 命令找不到

确保 `postCreateCommand` 已成功执行，或手动运行：

```bash
sudo corepack enable
corepack prepare pnpm@10.30.2 --activate
pnpm install
```

### Git 权限问题

容器已配置 Git 安全目录，如果仍有问题，可手动运行：

```bash
git config --global --add safe.directory /workspaces/whonb/code
```

## 自定义配置

可根据需要修改以下文件：

- `.devcontainer/devcontainer.json`: 主配置文件
- `.devcontainer/Dockerfile`: 自定义 Docker 镜像
- `.devcontainer/.env`: 环境变量

## 相关文档

- [VS Code Dev Containers 文档](https://code.visualstudio.com/docs/devcontainers/containers)
- [开发容器规范](https://containers.dev/)
