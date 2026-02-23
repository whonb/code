# nbcode

ai agent code 闭环实践.

## 环境要求

- Node.js >= 20
- npm >= 10

## 快速开始

```bash
npm install
npm run dev -- --help
```

## 可用命令

- `npm run dev -- --name codex`：开发模式运行 CLI
- `npm run build`：构建到 `dist/`
- `npm run typecheck`：开发配置类型检查（bundler）
- `npm run typecheck:build`：构建配置类型检查（NodeNext）
- `npm run lint`：代码检查
- `npm run test`：运行测试

## 发布

构建后，CLI 可执行文件为：

- `dist/cli.js`

`package.json` 已定义：

- `bin.nbcode = ./dist/cli.js`
