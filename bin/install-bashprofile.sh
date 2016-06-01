#!/usr/bin/env bash
export APP_NAME="IntegrateMe"
export APP_ROOT="/vagrant"

cat <<- EOF >> ~/.bash_profile
  export PS1='\u@\h \W\$(__git_ps1) \\$ '
  export PATH="\$PATH:./node_modules/.bin"

  alias tm='tmux attach || tmux new'

  cd $APP_ROOT
EOF
