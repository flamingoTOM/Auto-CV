# ACV:Auto-Curriculum-Vitae

一个基于 LaTeX 的中文简历模板，配合 Claude Code 的 `/Auto-CV` 对话式技能，实现**自然语言描述、生成简历 PDF**。

---

## 功能特点

- **中文排版**：基于 XeLaTeX + Adobe 字体，支持宋体正文与粗体标题
- **照片支持**：可选头像，自动布局不遮挡内容
- **结构化模板**：教育背景、实习经历、项目经历、学生工作、个人评价，层次清晰
- **STAR 原则**：工作内容自动按 Situation→Action→Result 三段式展开
- **`/Auto-CV` 技能**：Claude Code 对话引导，分 7 步完成简历填写并实时更新 `.tex` 文件

---

## 目录结构

```
Auto-CV/
├── resume.tex              # 简历主文件（编辑此文件）
├── resume.cls              # 自定义文档类（排版逻辑）
├── build.sh                # 本地一键编译脚本
├── images/
│   └── you.jpg             # 简历照片（替换为本人照片）
├── fonts/                  # 内嵌字体（XeLaTeX 使用）
├── fontawesome.sty         # 图标支持
├── linespacing_fix.sty     # 行距修正
├── zh_CN-Adobefonts_*.sty  # 中文字体配置
└── .claude/
    └── skills/
        └── Auto-CV/
            └── SKILL.md    # /Auto-CV 技能定义
```

---

## 快速开始

### 本地编译

**依赖：** MiKTeX 或 TeX Live（需包含 XeLaTeX）

```bash
bash build.sh
```

编译成功后生成 `resume.pdf`。

---

## 使用 `/Auto-CV` 技能

在 [Claude Code](https://github.com/anthropics/claude-code) 项目目录下运行：

```
/Auto-CV
```

技能将分 **7 个步骤**引导填写简历：

| 步骤 | 内容 |
|------|------|
| 第一步 | 个人信息（姓名、籍贯、邮箱、电话、政治面貌、通讯地址）|
| 第二步 | 教育背景（学校、专业、学历、时间）|
| 第三步 | 照片（是否添加）|
| 第四步 | 实习经历（STAR 原则，时间倒序）|
| 第五步 | 项目经历（支持奖项，时间倒序）|
| 第六步 | 学生工作（1-3 段）|
| 第七步 | 个人评价（英文水平、技术栈、爱好，3-8 条）|

每步填写完毕后自动更新 `resume.tex`，全部完成后可直接编译输出 PDF。

> 也可将原始信息写入 `.txt` 文件，通过 `/Auto-CV 参考 xxx.txt` 的方式批量导入。

---

## 主要 LaTeX 命令

| 命令 | 说明 |
|------|------|
| `\MyName{姓名}` | 简历大标题 |
| `\SimpleEntry{内容}` | 个人信息单行条目 |
| `\section{节名}` | 大节标题（教育背景、实习经历等）|
| `\datedsubsection{左对齐内容}{右对齐时间}` | 带时间的子节标题 |
| `\Content{条目1}{条目2}{条目3}` | 三点式内容列表 |
| `\Contenttwo{条目1}{条目2}` | 两点式内容列表 |
| `\yourphoto{0.14}` | 插入照片（数值为页面宽度比例）|

---

## 注意事项

- 照片文件名必须为 `you.jpg`，放入 `images/` 文件夹
- 不需要照片时，在 `\yourphoto{0.14}` 行前加 `%` 注释掉
- 个人信息类 `.txt` 文件建议加入 `.gitignore`，避免隐私数据上传

---

## License

MIT
