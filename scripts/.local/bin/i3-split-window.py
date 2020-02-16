#!/usr/bin/env python3

"""
i3-split-window.py - Evenly split the current window either horizontally
                     or vertically, and launch the given command

This script provides functionality that is similar to tmux splitting of
terminals. This will split the current window either horizontally or vertically.
A new split container is only created in case the current window is contained in
a split container with a different layout.

Usage: i3-split-window.py (horizontal|vertical) COMMAND

Options:
    -h --help   Show this screen.
    horizontal  Splits the current terminal horizontally.
    vertical    Splits the current terminal vertically.
    COMMAND     The command to execute that will fill up the new window space.
"""

from docopt import docopt

import i3ipc
import subprocess
import sys

if __name__ == '__main__':
    arguments = docopt(__doc__)

    conn = i3ipc.Connection()

    parent_layout = conn.get_tree().find_focused().parent.layout

    if arguments['horizontal'] and parent_layout != 'splith':
        conn.command('split horizontal')
    elif arguments['vertical'] and parent_layout != 'splitv':
        conn.command('split vertical')

    subprocess.Popen(arguments['COMMAND'])
