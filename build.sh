#!/bin/bash
# 编译简历 LaTeX 为 PDF
# 依赖：XeTeX（MiKTeX / TeX Live）
# 用法：bash build.sh

set -e
cd "$(dirname "$0")"

echo "编译 resume.tex ..."
xelatex -interaction=nonstopmode resume.tex 2>&1 | tail -3
echo ""
echo "再次编译以解决交叉引用 ..."
xelatex -interaction=nonstopmode resume.tex 2>&1 | tail -3

if [ -f resume.pdf ]; then
    echo ""
    echo "✓ PDF 生成成功: resume.pdf"
    ls -lh resume.pdf
else
    echo ""
    echo "✗ 编译失败，请检查上方错误信息"
    exit 1
fi
