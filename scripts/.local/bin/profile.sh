#!/bin/sh

exit_with_usage() {
  cat <<USAGE
Usage: profile.sh [--pdf <path to PDF viewer] <command to execute>"

Profile the given command, and shows the PDF profile result using the given PDF
viewer.

Note; code has to be built with profiling enabled as follows, from the src/
directory.
USAGE
  exit 1
}

if [ $# -lt 1 ]; then
  exit_with_usage
fi

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  exit_with_usage
fi

if [ "$1" = "--pdf" ]; then
  shift 1
  pdf_viewer=$(command -v "$1")
  shift 1
fi

# In case no PDF viewer is configured, try some default options.
if [ ! -x "$pdf_viewer" ]; then
  for option in evince zathura; do
    pdf_viewer=$(command -v $option)
    if [ -x "$pdf_viewer" ]; then
      echo "Using '$pdf_viewer' to open the generated profile PDF..."
      break
    fi
  done
  if [ ! -x "$pdf_viewer" ]; then
    echo "No valid pdf reader found, specify one on the command line."
    exit 1
  fi
fi

binary=$(command -v $1)
shift 1

set -e

prof_output=/tmp/profile-$$.prof
pprof_output=/tmp/profile-$$.pdf

CPUPROFILE=$prof_output $binary "$@" && echo "Profile generated for '$binary' at: $prof_output..."
pprof "$binary" "$prof_output" --pdf > "$pprof_output" && echo "Generated PDF with profile results at: $pprof_output..."

LD_LIBRARY_PATH=/lib:/usr/lib:/lib64:/usr/lib64 exec "$pdf_viewer" "$pprof_output" &
