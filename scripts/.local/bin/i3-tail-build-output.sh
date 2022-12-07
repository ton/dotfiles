#!/bin/sh

# Arguments: <build log> <pgid>
trap "kill -s TERM -$2" INT
tail -f "$1" && sleep 3600
