#!/bin/bash

# emba - EMBEDDED LINUX ANALYZER
#
# Copyright 2020-2021 Siemens AG
#
# emba comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
# welcome to redistribute it under the terms of the GNU General Public License.
# See LICENSE file for usage of this software.
#
# emba is licensed under GPLv3
#
# Author(s): Michael Messner, Pascal Eckmann

# Description:  Check for history files
#               Access:
#                 firmware root path via $FIRMWARE_PATH
#                 binary array via ${BINARIES[@]}


S55_history_file_check()
{
  module_log_init "${FUNCNAME[0]}"
  module_title "Search history files"

  local HIST_FILES
  HIST_FILES="$(config_find "$CONFIG_DIR""/history_files.cfg")"

  if [[ "$HIST_FILES" == "C_N_F" ]] ; then print_output "[!] Config not found"
  elif [[ -n "$HIST_FILES" ]] ; then
      CONTENT_AVAILABLE=1
      print_output "[+] Found history files:"
      for LINE in $HIST_FILES ; do
        print_output "$(indent "$(orange "$(print_path "$LINE")")")"
      done
  else
    print_output "[-] No history files found"
  fi
}

