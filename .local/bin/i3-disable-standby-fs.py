#!/usr/bin/env python3

"""
i3-disable-standby-fs.py - Disable standby in case a window goes fullscreen.

This script was adapted from the 'disable-standby-fs.py' script from the
examples directory of i3ipc-python package. It properly supports Flash windows
going to/from fullscreen as well.

Usage: i3-disable-standby-fs.py [IGNORE]

Options:
    -h --help     Show this screen.
    IGNORE        Ignore containers going fullscreen containing with the given
                  string in their container name.
"""

from docopt import docopt
from subprocess import call

import i3ipc

class Monitor(object):

    FLASH_CONTAINER_NAME = 'plugin-container'

    def __init__(self, ignore_pattern):
        self._is_flash_fullscreen = False
        self._ignore_pattern = ignore_pattern

    def enable_standby(self):
        call(['xset', 's', 'on'])
        call(['xset', '+dpms'])

    def disable_standby(self):
        call(['xset', 's', 'off'])
        call(['xset', '-dpms'])

    def on_fullscreen_mode(self, i3, e):
        if self._ignore_pattern in e.container.name:
            return

        if e.container.props.fullscreen_mode:
            self._is_flash_fullscreen = e.container.name == Monitor.FLASH_CONTAINER_NAME
            self.disable_standby()
        else:
            self.enable_standby()

    def on_window_close(self, i3, e):
        if self._ignore_pattern in e.container.name:
            return

        if e.container.props.fullscreen_mode:
            self.enable_standby()

    def on_window_focus(self, i3, e):
        if self._is_flash_fullscreen and e.container.name != Monitor.FLASH_CONTAINER_NAME:
            self._is_flash_fullscreen = False
            self.enable_standby()

arguments = docopt(__doc__)

monitor = Monitor(arguments['IGNORE'] if arguments['IGNORE'] else '')

i3 = i3ipc.Connection()

i3.on('window::fullscreen_mode', monitor.on_fullscreen_mode)
i3.on('window::close', monitor.on_window_close)
i3.on('window::focus', monitor.on_window_focus)

i3.main()
