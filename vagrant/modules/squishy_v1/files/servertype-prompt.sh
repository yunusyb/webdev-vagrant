# squishy detect server type environment and modify prompt

# git prompt settings
export GIT_PS1=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# Set the initial prompt.  Red prompt if user is root
if [[ ${EUID} == 0 ]] ; then
  PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
  PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$ '
fi

# We guess server type in phases. The zeroth phase is a SERVERTYPE environment
# variable defined elsewhere.
#
# Phase 1: detect based on presence of certain magic files.
if [ -z "$SERVERTYPE" ]; then
  # Vagrant boxes always have /vagrant directory. Others don't, I hope.
  if [ -d /vagrant ]; then
    SERVERTYPE="LOCAL"
  fi
fi

# Phase 2: detect based on hostname
if [ -z "$SERVERTYPE" ]; then
  case `hostname` in
    *.local)
      SERVERTYPE="LOCAL"
      ;;
    *-dev*|*.private|dev-*)
      SERVERTYPE="DEV"
      ;;
    *-stg*|stg-*|*stag*)
      SERVERTYPE="STAGING"
      ;;
    *-web*|*-db*|*prod*)
      SERVERTYPE="PRODUCTION"
      ;;
    *)
      SERVERTYPE="PRODUCTION"
      ;;
  esac
fi

# set the prompt colors. Red for prod, yellow for staging, green for laptop/dev
PROMPT_COLOR=""
case "$SERVERTYPE" in
  PROD*)
    PROMPT_COLOR="\[\033[01;31m\]"
    ;;
  LOC*)
    PROMPT_COLOR="\[\033[01;32m\]"
    ;;
  DEV*)
    PROMPT_COLOR="\[\033[01;32m\]"
    ;;
  *)
    PROMPT_COLOR="\[\033[01;33m\]"
    ;;
esac

# generate the tag with servertype text
export SERVER_TYPE_PROMPT="$PROMPT_COLOR[$SERVERTYPE]\[\033[00m\] "

# Insert into the PS1 prompt
PS1="${SERVER_TYPE_PROMPT}${PS1}\[\033]0;\u@\h:$PWD\007\]"

# git fancy-ness
if [ -f /usr/local/bin/git-prompt.sh ]; then
  if [ ${EUID} == 0 ] ; then
    . /usr/local/bin/git-prompt.sh
    PROMPT_COMMAND='__git_ps1 "${SERVER_TYPE_PROMPT}\[\033[01;31m\]\u@\h\[\033[01;34m\]:\W\[\033[00m\]\[\033]0;\u@\h:$PWD\007\]" "\\\$ "'
  else
    . /usr/local/bin/git-prompt.sh
    PROMPT_COMMAND='__git_ps1 "${SERVER_TYPE_PROMPT}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\[\033]0;\u@\h:$PWD\007\]" "\\\$ "'
  fi
fi
