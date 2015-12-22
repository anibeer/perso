# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH
http_proxy=http://w3p1.atos-infogerance.fr:8080
export no_proxy=localhost,127.0.0.1,192.168.0.34
export http_proxy
