#!/usr/bin/env bash

set -o errtrace  # -E trap inherited in sub script
set -o errexit   # -e
set -o functrace # -T If set, any trap on DEBUG and RETURN are inherited by shell functions
set -o pipefail  # default pipeline status==last command status, If set, status=any command fail

## 开启globstar模式，允许使用**匹配所有子目录,bash4特性，默认是关闭的
shopt -s globstar
## 开启后可用排除语法：workspaces=(~ ~/git/chen56/!(applab)/ ~/git/botsay/*/ )
shopt -s extglob

# Get the real path of the script directory
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT_DIR/sha_common.sh"

# 全局命令不要进入到_c目录
# cd "$ROOT_DIR"

workspaces=(packages/*/)

_ws_run() {
  for ws in "${workspaces[@]}"; do
    (
      cd "$ws"
      _run "$@"
    )
  done
}


ws() {
  pwd() (
    _ws_run pwd
  )
}

####################################################################################
# app script
# 应用项目补充的公共脚本，不在bake维护范围
# 此位置以上的全都是bake工具脚本，copy走可以直接用，之下的为项目特定cmd，自己弄
####################################################################################
dev() {
  build() {
    # --progress=plain
    _run docker-compose --project-directory .devcontainer/ build "$@"
  }
  up() {
    mkdir -p .devcontainer/.cache/home/whonb
    _run docker-compose --project-directory .devcontainer/ up -d --build --remove-orphans  --force-recreate  "$@"
  }
  down() {
    _run docker-compose --project-directory .devcontainer/ down  "$@"
  }
  clean() {
    _run rm -rf ./.devcontainer/.cache
  }
  run() {
    _run tsx src/cli.ts
  }
}
info() {
  ip() {
    _run curl cip.cc
  }

  basic() {
    echo "## me"
    echo "ROOT_DIR  : $ROOT_DIR";
  }
}

update() { 
  self() {
    _install_sha
  }
}

clean() {
  _run rm -rf ./build
  _run rm -rf ./dist
}

####################################################
# 构建与检查
####################################################

check() {
  dev() {
    _run npx tsc -p tsconfig.json
    _run docker run --rm -i hadolint/hadolint < .devcontainer/Dockerfile
  }
  build() {
    _run npx tsc -p tsconfig.build.json
  }
  all() {
    dev
    build
  }
}


lint() {
  _run eslint .
}

test() {
  _run vitest run
}

completion() {
  bash() {
    cat <<'EOF'
# bash completion for sha.sh
_sha_completion() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local cmd_line=("${COMP_WORDS[@]:0:COMP_CWORD}")
    # 获取子命令列表：执行当前命令链，捕获帮助信息中的命令列表
    local subcmds=$("${cmd_line[@]}" 2>/dev/null | sed -n '/Available Commands:/,/^$/p' | grep "^  " | awk '{print $1}')
    COMPREPLY=( $(compgen -W "$subcmds" -- "$cur") )
}
complete -F _sha_completion ./sha.sh
complete -F _sha_completion sha
EOF
  }
}
# ... 在 sha "$@" 之前添加 ...

proxy() {
  up() (
    # 使用 up -d。如果配置有变（比如密码更新了），docker 会自动重新创建容器
    # Use --force-recreate to ensure containers are recreated if config changed
    cd "$ROOT_DIR/_self"
    _run docker compose up -d --force-recreate
    echo "${c_info}✅ 完成！代理容器已在后台运行（带自动重启策略）,运行'c proxy chrom'浏览器 。${c_reset}"
  )
  down() (
    cd "$ROOT_DIR/_self"
    _run docker compose down
  )
  chrome() {
    # --user-data-dir="$HOME/.chrome-outline" \
    _run open -na "Google Chrome" --args \
      --proxy-server="socks5://127.0.0.1:1081" \
      --no-first-run
  }
  doubao() {
    _run open -na "Doubao" --args \
      --proxy-server="socks5://127.0.0.1:1081" \
      --no-first-run
  }
  code() {
    _run open -na "Visual Studio Code" --args \
      --proxy-server="socks5://127.0.0.1:1081" \
      --no-first-run
  }
  pycharm() {
    _run open -na "PyCharm.app" --args \
      -Dhttp.proxyHost=127.0.0.1 \
      -Dhttp.proxyPort=1080 \
      -Dhttps.proxyHost=127.0.0.1 \
      -Dhttps.proxyPort=1080 \
      -DsocksProxyHost=127.0.0.1 \
      -DsocksProxyPort=1081

  }
  py() {    
    # 设置 HTTP/HTTPS 代理 (指向你的 1081 端口)
    export http_proxy="http://127.0.0.1:1080"
    export https_proxy="http://127.0.0.1:1080"
    # 设置 SOCKS5 代理 (指向你的 1080 端口，常用于 all_proxy)
    export all_proxy="socks5://127.0.0.1:1081"
    # 设置不走代理的地址
    export no_proxy="*.local,localhost,127.0.0.1,localaddress,.localdomain.com,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12"

    _run open -na "PyCharm.app"
  }
  bash() {    
    # 设置 HTTP/HTTPS 代理 (指向你的 1081 端口)
    export http_proxy="http://127.0.0.1:1080"
    export https_proxy="http://127.0.0.1:1080"
    # 设置 SOCKS5 代理 (指向你的 1080 端口，常用于 all_proxy)
    export all_proxy="socks5://127.0.0.1:1081"
    # 设置不走代理的地址
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

    command bash
  }
  test() {
    _run curl google.com
  }
  info() {
    export | grep -E "http_proxy|https_proxy|all_proxy|no_proxy" || true
  }
}
p() {
  proxy "$@"
}

####################################################
# app entry script & _root cmd
####################################################

sha "$@"

