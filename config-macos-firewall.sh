#!/bin/sh

alias alf='sudo /usr/libexec/ApplicationFirewall/socketfilterfw'
BLUE='\033[0;34m'
GRAY='\033[0;37m'

echo "${BLUE}Temporarily turning off firewall...${GRAY}"
alf --setglobalstate off

echo "${BLUE}Adding 'mosh-server' to allowed apps...${GRAY}"
# add symlink
alf --add $(which mosh-server)
alf --unblockapp $(which mosh-server)

# add brew cellar
alf --add $(brew --prefix)/bin/$(readlink -n $(which mosh-server))
alf --unblockapp $(brew --prefix)/bin/$(readlink -n $(which mosh-server))

echo "${BLUE}Turning firewall on...${GRAY}"
alf --setglobalstate on
