#!/bin/zsh
# 装 gbc：拷到 ~/bin、加执行权限、~/bin 不在 PATH 就加进 ~/.zshrc，最后跑 gbc doctor。
# 两种用法：
#   解压后：zsh install.sh                 用同目录的 gbc
#   一行装：curl -fsSL <仓库 raw 地址>/install.sh | zsh   从仓库下载 gbc
GBC_RAW=${GBC_RAW:-https://raw.githubusercontent.com/chennian080403/gbc/main}

mkdir -p ~/bin
# 管道运行时 $0 是「zsh」不是文件，这时走下载
src=${0:A:h}/gbc
if [[ -f $0 && -f $src ]]; then
  cp "$src" ~/bin/gbc.tmp
else
  echo "从 $GBC_RAW 下载 gbc…"
  curl -fsSL "$GBC_RAW/gbc" -o ~/bin/gbc.tmp || { echo "下载失败，检查网络或手动下载 gbc 放到 ~/bin"; exit 1 }
fi
# 先写临时文件再整体换上，正在跑的旧 gbc 不会被改坏
chmod +x ~/bin/gbc.tmp && mv -f ~/bin/gbc.tmp ~/bin/gbc
echo "已装：~/bin/gbc（$(~/bin/gbc version)）"

if [[ :$PATH: != *:$HOME/bin:* ]]; then
  grep -q 'HOME/bin' ~/.zshrc 2>/dev/null || echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc
  echo "已把 ~/bin 加进 ~/.zshrc 的 PATH；新开的终端生效"
fi

~/bin/gbc doctor
