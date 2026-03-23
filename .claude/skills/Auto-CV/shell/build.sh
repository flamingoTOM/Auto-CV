#!/bin/bash
# 编译简历 LaTeX 为 PDF
# 依赖：XeTeX（MiKTeX / TeX Live）
# 用法：bash build.sh

cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"

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

# ============ MiKTeX 自动安装配置（不弹确认框）============
# initexmf 是 MiKTeX 官方配置工具，AutoInstall=1 禁止弹框
initexmf --set-config-value "[MPM]AutoInstall=1" 2>/dev/null || true

# ============ 预安装常用宏包（首次编译加速）============
if command -v mpm &> /dev/null; then
    mpm --install=xltxtra --install=realscripts --install=metalogo \
        --install=xifthen --install=ifmtarg --install=geometry \
        --install=titlesec --install=nth --install=xecjk \
        --install=ctex --install=cite --install=setspace \
        --install=hyperref --install=fontspec --install=etoolbox \
        --install=oberdiek --install=helvetic 2>/dev/null || true
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
