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

# Description:  Search for mail related files
#               Access:
#                 firmware root path via $FIRMWARE_PATH
#                 binary array via ${BINARIES[@]}


S90_mail_check()
{
  module_log_init "${FUNCNAME[0]}"
  module_title "Search Mail files"

  local MAILS
  local MAILS_PATH
  MAILS_PATH="$(mod_path "$FIRMWARE_PATH""/var/mail")"
  for ELEM in $MAILS_PATH ; do
    if [[ -e "$ELEM" ]] ; then
      MAILS="$MAILS""\\n""$(ls -la "$ELEM" 2>/dev/null)"
    fi
  done
  MAILS=$(ls -la "$MAILS_PATH" 2>/dev/null)
  local MAILS_ROOT
  local MAILS_PATH_ROOT
  MAILS_PATH_ROOT="$(mod_path "$FIRMWARE_PATH""/var/mail/root")"
  for ELEM in $MAILS_PATH_ROOT ; do
    if [[ -e "$ELEM" ]] ; then
      MAILS_ROOT="$MAILS_ROOT""\\n""$(head "$ELEM" 2>/dev/null)"
    fi
  done

  if [[ -n "$MAILS" ]] || [[ "$MAILS_ROOT" ]] ; then
    if [[ -n "$MAILS" ]] ; then
      print_output "[+] Content of ""$(print_path "$ELEM")"":"
      print_output "$(indent "$(orange "$MAILS")")"
    elif [[ -n "$MAILS_ROOT" ]] ; then
      print_output "[+] Content of ""$(print_path "$MAILS_PATH_ROOT")"":"
      print_output "$(indent "$(orange "$MAILS_ROOT")")"
    fi
    CONTENT_AVAILABLE=1
  else
    print_output "[-] No mail files found!"
  fi
}

