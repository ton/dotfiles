#!/bin/bash
git branch 2> /dev/null | grep '^*' | cut -d\  -f2-
