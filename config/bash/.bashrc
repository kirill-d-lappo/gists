# Disabling Touch Screen - I don't need it
xinput disable $(xinput list --id-only "USBest Technology SiS HID Touch Controller")

# https://docs.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete#bash
_dotnet_bash_complete()
{
  local word=${COMP_WORDS[COMP_CWORD]}

  local completions
  completions="$(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)"
  if [ $? -ne 0 ]; then
    completions=""
  fi

  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

complete -f -F _dotnet_bash_complete

alias clip="xclip -sel clip"
alias ls="ls --color=auto -h"
alias bat=batcat
alias yank=yank-cli
alias clb='git branch --merged | egrep -v "(^\*|master|dev|release|main|UDE1.1)" |  xargs --no-run-if-empty git branch -d'
alias banner=figlet