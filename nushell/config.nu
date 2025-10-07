# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
$env.config = ($env.config | upsert shell_integration.osc133 false)
def --env pr [] {
  let proxy = "socks5://127.0.0.1:10808"
  let green = (ansi green)
  let reset = (ansi reset)

  load-env {
    HTTP_PROXY: $proxy
    HTTPS_PROXY: $proxy
    ALL_PROXY: $proxy
    http_proxy: $proxy
    https_proxy: $proxy
    all_proxy: $proxy
  }

  let _ = (try { ^git config --global http.proxy $proxy } catch { null })
  let _ = (try { ^git config --global https.proxy $proxy } catch { null })

  print ([$green, "已启用 SOCKS5 代理 ($proxy)", $reset] | str join "")
  sleep 300ms
}

def --env npr [] {
  let red = (ansi red)
  let reset = (ansi reset)

  hide-env HTTP_PROXY
  hide-env HTTPS_PROXY
  hide-env ALL_PROXY
  hide-env http_proxy
  hide-env https_proxy
  hide-env all_proxy

  let _ = (try { ^git config --global --unset http.proxy } catch { null })
  let _ = (try { ^git config --global --unset https.proxy } catch { null })

  print ([$red, "已关闭 SOCKS5 代理", $reset] | str join "")
  sleep 300ms
}

def --env toggle-socks [] {
  let proxy = "socks5://127.0.0.1:10808"
  let current = (try { $env.ALL_PROXY } catch { "" })

  if $current == $proxy {
    npr
  } else {
    pr
  }
}

# Update configuration with keybindings
$env.config = ($env.config | upsert keybindings (
    (try { $env.config.keybindings } catch { [] })
    | append {
        name: "toggle_socks5_proxy"
        modifier: "control"
        keycode: char_s
        mode: "emacs"
        event: {
          send: executehostcommand
          cmd: "toggle-socks"
        }
      }
  )
)
# ============================
#  Conda / Mamba 集成 for Nushell
# ============================

# 设置 conda/mamba 路径（根据你的安装位置改一下）
if ($env.CONDA_EXE | is-empty) {
    let conda_path = "D:/miniforge/Scripts/conda.exe"
    let python_path = "D:/miniforge/python.exe"
    
    # 检查路径是否存在
    if ($conda_path | path exists) {
        $env.CONDA_EXE = $conda_path
        $env.CONDA_PYTHON_EXE = $python_path
    } else {
        print "警告: 未找到 conda 路径，请检查 D:/miniforge/Scripts/conda.exe 是否存在"
    }
}

# 定义一个函数：如果没有 hook 文件就生成，然后加载
def load-conda-hook [] {
    let hook_file = ($nu.data-dir | path join "conda_hook.nu")

    if not ($hook_file | path exists) {
        print "生成 conda/mamba hook..."
        
        # 检查 CONDA_EXE 是否存在
        if ($env.CONDA_EXE | is-empty) {
            print "错误: CONDA_EXE 未设置，无法生成 conda hook"
            return
        }
        
        # 尝试生成 hook 文件
        try {
            ^$env.CONDA_EXE "shell.nu" "hook" | save -f $hook_file
            print "conda hook 文件生成成功"
        } catch {
            print $"错误: 无法生成 conda hook 文件: ($in)"
            return
        }
    }

    print "conda hook 文件已准备就绪，请手动运行 'activate-conda' 来加载"
}

# 定义一个便捷函数来手动加载 conda hook
def activate-conda [] {
    let hook_file = ($nu.data-dir | path join "conda_hook.nu")
    if ($hook_file | path exists) {
        # 使用 nu 命令执行 hook 文件
        nu $hook_file
        print "conda 环境已激活"
    } else {
        print "conda hook 文件不存在，请先运行 load-conda-hook"
    }
}

# 定义一个函数来激活指定的 conda 环境
def activate-env [env_name: string] {
    if ($env.CONDA_EXE | is-empty) {
        print "错误: CONDA_EXE 未设置，请先运行 activate-conda"
        return
    }
    
    # 获取环境路径
    let env_path = if $env_name == "base" {
        $env.CONDA_PREFIX
    } else {
        ($env.CONDA_PREFIX | path dirname | path join "envs" $env_name)
    }
    
    # 检查环境是否存在
    if not ($env_path | path exists) {
        print $"错误: 环境 ($env_name) 不存在，路径: ($env_path)"
        return
    }
    
    # 设置环境变量
    $env.CONDA_DEFAULT_ENV = $env_name
    $env.CONDA_PREFIX = $env_path
    $env.PATH = ($env.PATH | prepend ($env_path | path join "Scripts"))
    $env.PATH = ($env.PATH | prepend ($env_path | path join "Library" "bin"))
    
    print $"已激活环境: ($env_name)"
    print $"环境路径: ($env_path)"
}

# 简化的环境切换函数
def switch-env [env_name: string] {
    let base_path = "D:/miniforge"
    let env_path = if $env_name == "base" {
        $base_path
    } else {
        ($base_path | path join "envs" $env_name)
    }
    
    if not ($env_path | path exists) {
        print $"错误: 环境 ($env_name) 不存在，路径: ($env_path)"
        return
    }
    
    # 设置环境变量
    $env.CONDA_DEFAULT_ENV = $env_name
    $env.CONDA_PREFIX = $env_path
    $env.CONDA_PROMPT_MODIFIER = $"($env_name) "
    
    # 更新 PATH - 将新环境的路径添加到最前面
    let new_paths = [
        ($env_path | path join "Scripts")
        ($env_path | path join "Library" "bin")
        ($env_path | path join "conda-meta")
    ]
    
    # 移除旧的 conda 路径，然后添加新的
    $env.PATH = ($env.PATH | where {|p| not ($p | str contains "miniforge")})
    $env.PATH = ($env.PATH | prepend $new_paths)
    
    print $"已切换到环境: ($env_name)"
    print $"环境路径: ($env_path)"
    print $"当前 CONDA_DEFAULT_ENV: ($env.CONDA_DEFAULT_ENV)"
}

# 检查当前环境状态的函数
def check-env [] {
    print $"CONDA_DEFAULT_ENV: ($env.CONDA_DEFAULT_ENV)"
    print $"CONDA_PREFIX: ($env.CONDA_PREFIX)"
    print $"Python 路径: (which python)"
    print $"Python 版本: (python --version)"
    print $"当前工作目录: (pwd)"
}

# 简化的环境切换 - 直接使用 conda 命令
def conda-activate [env_name: string] {
    if ($env.CONDA_EXE | is-empty) {
        print "错误: CONDA_EXE 未设置"
        return
    }
    
    # 直接调用 conda activate 命令
    try {
        ^$env.CONDA_EXE activate $env_name
        print $"已激活环境: ($env_name)"
    } catch {
        print $"激活环境失败: ($in)"
        print "请尝试: conda init nu 然后重启 Nushell"
    }
}

# 启动时只生成 hook 文件，不自动加载
load-conda-hook
