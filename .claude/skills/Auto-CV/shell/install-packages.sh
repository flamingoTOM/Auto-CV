#!/bin/bash
# 一键安装 Auto-CV 所需的所有 LaTeX 宏包（MiKTeX）
# 首次使用时运行此脚本，之后直接运行 bash build.sh 即可
# 用法：bash install-packages.sh

echo "======================================"
echo " Auto-CV 宏包初始化脚本"
echo "======================================"
echo ""

# 检查 MiKTeX 是否安装
if ! command -v mpm &> /dev/null; then
    echo "✗ 未检测到 MiKTeX，请先安装："
    echo "  winget install --id MiKTeX.MiKTeX -e --accept-source-agreements --accept-package-agreements"
    exit 1
fi

# ============ 关键：禁止弹出确认框 ============
echo "配置 MiKTeX 静默自动安装模式（不弹确认框）..."
initexmf --set-config-value "[MPM]AutoInstall=1" 2>/dev/null || true
initexmf --update-fndb 2>/dev/null || true
echo "✓ 配置完成"
echo ""

# ============ 批量安装所有必需宏包 ============
echo "开始安装所有必需宏包..."
echo ""

PACKAGES=(
    # 字体与编码
    xltxtra
    realscripts
    metalogo
    fontspec
    xunicode
    helvetic

    # 中文支持
    xecjk
    ctex
    cjk

    # 布局与格式
    geometry
    titlesec
    setspace
    fancyhdr
    enumitem

    # 工具包
    xifthen
    ifmtarg
    nth
    etoolbox
    cite
    hyperref

    # oberdiek 工具包（含 kvsetkeys/kvoptions/pdfescape 等）
    oberdiek
    kvsetkeys
    kvoptions
    pdfescape
    ltxcmds
    infwarerr
    hycolor
    refcount
    gettitlestring
    stringenc
    intcalc
    bitset
    bigintcalc
    rerunfilecheck
    uniquecounter
    eso-pic
)

SUCCESS=0
FAIL=0

for pkg in "${PACKAGES[@]}"; do
    if mpm --install="$pkg" 2>/dev/null; then
        echo "  ✓ $pkg"
        ((SUCCESS++))
    else
        echo "  - $pkg (已安装或跳过)"
        ((FAIL++))
    fi
done

echo ""
echo "======================================"
echo " 完成！成功: $SUCCESS，跳过: $FAIL"
echo "======================================"
echo ""
echo "现在可以运行 bash build.sh 编译简历了。"
