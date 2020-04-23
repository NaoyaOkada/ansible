export LANG=ja_JP.UTF-8
export PATH=$PATH:$HOME/bin

# emacs 風キーバインドにする
bindkey -e

# 色を使用出来るようにする
autoload -Uz colors
colors
export TERM=xterm-256color

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

function history-all { history -E 1 }

autoload -Uz compinit
compinit

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
########################################

# git branch表示
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats "%F{green}[%b]%f"
precmd () { vcs_info }
########################################

local current_dir='%B%F{blue}[%~]%f%b'
local prompt_info='[%n@%F{green}%m%f %1~$vcs_info_msg_0_]'
local user_mark='%B%(?,%F{green},%F{red})%(!,#,$)%f%b '

PROMPT="$prompt_info$user_mark"
RPROMPT="$current_dir"
