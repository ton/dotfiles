python
import sys, glob
sys.path.insert(0, glob.glob('/cad-builds/centos6/master/gcc/share/gcc-*/python')[0])
from libstdcxx.v6 import register_libstdcxx_printers
register_libstdcxx_printers(gdb.current_objfile())

def import_libpython_2():
  print('Importing GDB library for Python 2 debugging support...')
  import sys
  sys.path.insert(0, '/cad-builds/centos6/master/gcc/share/python-debug/')
  import libpython

def import_libpython_3():
  print('Importing GDB library for Python 3 debugging support...')
  import sys
  sys.path.insert(0, '/cad-builds/centos6/master/gcc/share/python3-debug/')
  import libpython

def new_objfile_handler(event):
  import os
  executable_name = os.path.basename(event.new_objfile.filename)
  if executable_name.startswith('python3'):
    import_libpython_3()
  elif executable_name.startswith('python'):
    import_libpython_2()

gdb.events.new_objfile.connect(new_objfile_handler)
end

set pagination off
