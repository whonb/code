# nbcode

## 概述
本项目实践ai闭环工作流, 从定义ai任务开始, 到ai执行, 再到ai反馈, 循环往复, 直到任务完成，任务流转依赖github project或聊天软件完成。

## 参考

- [geminicli](https://geminicli.com)为例:
- [context7](https://context7.com/websites/geminicli)
- [deepwiki](https://deepwiki.com/google-gemini/gemini-cli)

### code agent cli

- cli
  - agent cli真正免费能打的就这几个：
    - geminicli 
    - codebuddy
    - qwen-code
  - 试用：
    - codex: 额度少
- 其他
  - [v0 by Vercel](https://v0.app)  


### tui lib

- [ink](https://github.com/vadimdemedes/ink)
- [opentui](https://github.com/anomalyco/opentui)
- [pi-tui](https://github.com/badlogic/pi-mono/tree/main/packages/tui)
- <https://github.com/RtlZeroMemory/Rezi>
  - c语言引擎，漂亮

### gen ui / agent ui


- **重要参考**
- [json-render](https://github.com/vercel-labs/json-render)  
- [Vercel AI SDK](https://vercel.com/docs/ai-sdk)  
- [CopilotKit](https://github.com/CopilotKit/CopilotKit)  
  - copilotkit generative-ui
    - <https://docs.copilotkit.ai/generative-ui>
    - <https://github.com/CopilotKit/generative-ui>
- [A2UI](https://github.com/google/A2UI)  
  - a2ui builder  <https://a2ui-composer.ag-ui.com/>  
- [LangChain Agent Chat UI](https://github.com/langchain-ai/agent-chat-ui)  


- **其他**
  - [Assistant UI](https://github.com/assistant-ui/assistant-ui)  
  - [Ant Design X](https://x.ant.design)  
  - [Stream Chat React AI SDK](https://getstream.io/chat/docs/sdk/react/guides/ai-integrations/stream-chat-ai-sdk)  
  - [Shadcn React AI 组件（AI Chat）](https://www.shadcn.io/ai)  


### 类似想法

- [ralph-tui](https://github.com/subsy/ralph-tui)
- <https://github.com/mikeyobrien/ralph-orchestrator>
  - 定位：改进版 Ralph Wiggum 技法的自主 AI 编排器，支持多 AI 后端，有交互式 TUI。


## bot-doc

下载同步: git clone依赖的原始项目
预处理：利用 Repomix 等工具将仓库“脱水”，剔除干扰，保留骨架。
符号化：利用 tree-sitter 等工具生成精确的符号表，作为 AI 的导航地图。
动态注入：不追求一次性处理所有代码，而是通过 LLM 编排，根据场景动态加载相关的代码片段。
标准化导航：在库中引入类似 llms.txt 的 AI 友好型说明文件，作为知识库的“高速缓存”。