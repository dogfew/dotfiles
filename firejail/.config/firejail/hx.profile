# Firejail profile for neovim
# Description: Helix is open source and freely distributable
# This file is overwritten after every install/update
# Persistent local customizations
# Persistent global definitions
include globals.local
quiet
noblacklist ${HOME}/.config/helix
noblacklist ${HOME}/.cache/helix

# blacklist ${RUNUSER}

# include disable-common.inc
# include disable-devel.inc
# include disable-programs.inc
# include disable-xdg.inc

# include whitelist-runuser-common.inc

ipc-namespace
machine-id
net none
no3d
nodvd
nogroups
noinput
nonewprivs
noroot
notv
nou2f
novideo
protocol unix,inet,inet6
seccomp
seccomp.block-secondary
tracelog
x11 none
writable-etc
private-dev

dbus-user none
dbus-system none

restrict-namespaces
quiet
