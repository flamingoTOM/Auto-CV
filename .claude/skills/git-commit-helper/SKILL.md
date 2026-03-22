---
name: git-commit-helper
description: 根据 git diff 生成符合规范的 commit message。当用户需要提交代码、生成中文 commit message 或查看代码变更时使用。
---

# Git Commit Helper



## 认证
Github 平台的 api key: `<GITHUB_TOKEN>`

## Instructions

### 步骤 1: 检查当前状态
运行 `git status` 查看当前仓库状态，了解有哪些文件被修改。

### 步骤 2: 查看变更内容
运行 `git diff --staged` 查看已暂存的更改（如果有的话）。
如果没有暂存的更改，运行 `git diff` 查看工作区的更改。

### 步骤 3: 分析变更类型
根据变更内容，确定 commit 类型：
- **feat**: 新功能（feature）
- **fix**: 修复 bug
- **docs**: 仅文档更改
- **style**: 不影响代码含义的更改（空格、格式化等）
- **refactor**: 既不修复 bug 也不添加功能的代码重构
- **perf**: 提升性能的代码更改
- **test**: 添加或修改测试
- **chore**: 构建过程或辅助工具的变动

### 步骤 4: 生成 Commit Message
使用中文按照 Conventional Commits 规范生成消息：

**格式：**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**规则：**
- subject: 简短描述，不超过 50 字符，使用祈使句
- body: 详细描述，说明为什么做这个更改（可选）
- footer: 关联的 issue 或 breaking changes（可选）

## Examples

### 示例 1: 新增功能
**变更：** 添加了用户登录功能，包含 JWT token 验证

**生成的 Commit Message：**
```
feat(auth): add JWT-based user authentication

- Implement login endpoint at /api/auth/login
- Add JWT token generation and verification
- Create authentication middleware for protected routes
- Add user session management

Related: #123
```

### 示例 2: 修复 Bug
**变更：** 修复了日期格式在时区转换时的错误

**生成的 Commit Message：**
```
fix(utils): correct date formatting in timezone conversion

The previous implementation didn't handle daylight saving time
correctly. Now using moment-timezone library for consistent
UTC timestamp conversion.

Fixes: #456
```

### 示例 3: 文档更新
**变更：** 更新了 README 中的安装说明

**生成的 Commit Message：**
```
docs(readme): update installation instructions

Add detailed steps for Docker-based setup and
troubleshooting section for common installation issues.
```

### 示例 4: 代码重构
**变更：** 重构了数据库查询逻辑，提取公共方法

**生成的 Commit Message：**
```
refactor(db): extract common query patterns into helper functions

Move repeated query logic into reusable helper functions
to improve code maintainability and reduce duplication.

No functional changes.
```

## Best Practices

1. **简短而精确**: subject 应该简明扼要，一眼就能看出做了什么
2. **使用祈使句**: 使用 "add" 而不是 "added" 或 "adds"
3. **解释原因**: 在 body 中说明为什么做这个更改，而不是重复 subject
4. **一个 commit 一个目的**: 如果有多个不相关的更改，建议拆分成多个 commits
5. **关联 issue**: 如果有相关的 issue，在 footer 中引用

## Quick Reference

| Type | 使用场景 |
|------|---------|
| feat | 添加新功能 |
| fix | 修复 bug |
| docs | 仅文档更改 |
| style | 代码格式调整（不影响逻辑）|
| refactor | 代码重构（不修复 bug，不添加功能）|
| perf | 性能优化 |
| test | 添加或修改测试 |
| chore | 构建工具或依赖更新 |

