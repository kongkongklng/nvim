# 告诉 starship 当前是 nushell
$env.STARSHIP_SHELL = "nu" 
# config.nu
# 设置语言为中文
$env.LC_ALL = "zh_CN.UTF-8"
$env.LANG = "zh_CN.UTF-8"


# 设置提示符生成命令
$env.PROMPT_COMMAND = {|| starship prompt } 

# 避免 locale 问题 (比如 emoji 或特殊字符乱码)
$env.LC_ALL = "en_US.UTF-8" 
$env.LANG = "en_US.UTF-8" 

# 禁用 Nushell 默认右侧和多行提示符
$env.PROMPT_COMMAND_RIGHT = "" 
$env.PROMPT_INDICATOR = "" 
$env.PROMPT_MULTILINE_INDICATOR = "" 

# 禁用 osc133，避免 WezTerm + Nu 出现光标跳行问题
$env.config = ($env.config | upsert shell_integration.osc133 false) 
