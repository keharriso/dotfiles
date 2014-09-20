# Prompt
function redroot() echo -n "%B%(!.%F{red}.%F{blue})$1%f%b"
function autoindent() echo -n "%(3_.        .%(2_.    .))"
PS1="`redroot %#` "
RPS1="%(?.%~.%B%F{red}%?%f%b)"
PS2="  `autoindent`"
PS3="  `autoindent`    "
PS4="`redroot .` "

# Environment
export EDITOR=vim
export LD_LIBRARY_PATH=/usr/local/lib:/opt/java/jre/lib/amd64
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export PATH="$PATH:$HOME/.cabal/bin:/opt/java/bin:/opt/metasploit:/opt/flex-sdk/bin:/opt/android-sdk/platform-tools"
export PYTHONSTARTUP="$HOME/.python_profile"
export TERMINAL='urxvtc'
export HOSTNAME=`hostname`

# Aliases
#alias startx='exec startx &>~/.xlog'
alias ls='ls --color=auto --classify'
alias rm='rm -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias mgrep='lsmod | grep'
alias frotz='frotz -w $COLUMNS -h $LINES'
alias pacman='yaourt'
alias less='less -R'
alias ps="ps --forest -f"
alias psu="ps -u$USER"
alias pgrep="/bin/ps -ef | grep"
alias pugrep="/bin/ps -fu$USER | grep"
function asdis() (as -o /tmp/ash.tmp $* && objdump --disassemble /tmp/ash.tmp | tail -n +8; rm -f /tmp/ash.tmp)
function asraw() (as -o /tmp/asr.tmp $* && objcopy -j .text -O binary /tmp/asr.tmp /dev/stdout; rm -f /tmp/asr.tmp)
function asesc() asraw $* | ruby -e 'while c = STDIN.getbyte do print "\\x%02x" % c end'

# The following lines were added by compinstall
zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%S%p%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original false
zstyle ':completion:*' select-prompt '%S%p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose false
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify listpacked
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

case "$TERM" in
xterm*|rxvt*) function precmd() {
	echo -ne "\033]0;${USER}@${HOSTNAME} - ${PWD}\007"
} ;;
esac

[ "$TTY" = "/dev/tty1" ] && exec startx || [ "$TTY" "=~" "tty" ] && archey3 || true
