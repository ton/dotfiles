#!/usr/bin/env python3

"""
i3_switch_tab.py - Switch to a tab in case the current window is in a tabbed
                   container

Usage: i3_switch_tab.py NUM

Options:
    -h --help   Show this screen.
    NUM         Number of the tab to switch to.
"""

from docopt import docopt

import i3ipc
import sys

if __name__ == '__main__':
    arguments = docopt(__doc__)

    conn = i3ipc.Connection()

    # Retrieve the tab index from the command line argument.
    tab_index = int(arguments['NUM']) if arguments['NUM'].isdigit() else -1

    # Search for a parent tab container.
    parent = conn.get_tree().find_focused().parent
    while parent and parent.layout != 'tabbed':
        parent = parent.parent

    # In case a parent tab container is found, switch to the given tab index.
    if parent and parent.layout == 'tabbed':
        if 0 <= tab_index < len(parent.nodes):
            conn.command('[con_id="%s"] focus' % parent.nodes[tab_index].id)
            conn.command('focus child')
            sys.exit(0)

    # Unable to switch to the given tab index, return an error code.
    sys.exit(1)
