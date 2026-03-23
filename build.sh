#!/bin/bash
# 编译简历 LaTeX 为 PDF
# 依赖：XeTeX（MiKTeX / TeX Live）
# 用法：bash build.sh

cd "$(dirname "$0")"

# ============ 检查 xelatex 是否存在 ============
if ! command -v xelatex &> /dev/null; then
    echo "错误: 未检测到 LaTeX 编译环境 (xelatex)"
    echo ""
    echo "请先安装 MiKTeX:"
    echo "  winget install MiKTeX.MiKTeX"
    echo ""
    echo "或访问: https://miktex.org/download"
    echo ""
    exit 1
fi

# ============ MiKTeX 自动安装配置 ============
# 方法1: 通过环境变量启用自动安装（最可靠）
export MINSTYLES_AUTOMATICINSTALL=1
export MIKTEX_AUTOINSTALL=1

# 方法2: 使用 MiKTeX Console 命令行配置（如果可用）
if command -v mpm &> /dev/null; then
    # 尝试设置自动安装
    mpm --set-option --auto-install=1 2>/dev/null || true
fi

# 方法3: 直接修改用户配置文件
MIKTEX_CONFIG_DIR="$HOME/AppData/Local/MiKTeX/miktex/config"
if [ -d "$MIKTEX_CONFIG_DIR" ]; then
    # 创建/更新配置文件启用自动安装
    mkdir -p "$MIKTEX_CONFIG_DIR"
    if ! grep -q "auto-install=1" "$MIKTEX_CONFIG_DIR/mpm.ini" 2>/dev/null; then
        echo "[mpm]" >> "$MIKTEX_CONFIG_DIR/mpm.ini"
        echo "auto-install=1" >> "$MIKTEX_CONFIG_DIR/mpm.ini"
    fi
fi

# ============ 预安装常用宏包 ============
if command -v mpm &> /dev/null; then
    echo "预安装所需 LaTeX 宏包..."
    # titlesec 是最常用的，优先安装
    mpm --install --titlesec 2>/dev/null || true
    mpm --install --etoolbox 2>/dev/null || true
    mpm --install --cite 2>/dev/null || true
    mpm --install --hyperref 2>/dev/null || true
    mpm --install --geometry 2>/dev/null || true
    mpm --install --fontspec 2>/dev/null || true
fi

# ============ 编译简历 ============
echo "编译 resume.tex ..."
xelatex -interaction=nonstopmode -halt-on-error resume.tex 2>&1 | tail -15
echo ""
echo "再次编译以解决交叉引用 ..."
xelatex -interaction=nonstopmode -halt-on-error resume.tex 2>&1 | tail -15

if [ -f resume.pdf ]; then
    echo ""
    echo "✓ PDF 生成成功: resume.pdf"
    ls -lh resume.pdf
else
    echo ""
    echo "✗ 编译失败，请检查上方错误信息"
    exit 1
fi
