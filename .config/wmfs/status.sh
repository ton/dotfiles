#!/bin/sh

# Adapted from an original status bar script of AddiKT1ve <the.addikt1ve@gmail.com>

_volume()
{
	# volume
	if [ "`~/.config/wmfs/audio.sh --status | grep '\[off\]$'`" = "" ]; then
		volume=`~/.config/wmfs/audio.sh --status | sed -n 's|.*\[\([0-9]*\)\%.*|\1%|pg'`
	else
		volume="[off]"
	fi
}

_date()
{
	sys_date=`date '+%A %d %B'`
	date="$sys_date"
}

_hour()
{
	sys_hour=`date '+%H:%M:%S'`
	hour="$sys_hour"
}

_separator()
{
	separator="•"
}

statustext()
{
	# Concatenate arguments.
	for arg in $@; do
		_${arg}
		args="${args}  `eval echo '$'$arg`"
	done

	# Set status bar through wmfs.
	wmfs -s "$args"
}

# Set status text.
# add <variables> from the following list: volume, date,  hour
statustext volume separator date separator hour
