#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16_1_0.sh
#                 ./scripts/etc/1603_16_1_0.sh
#
#         USAGE:
#
#   DESCRIPTION:  Generic utility helper for shell
#
#  REQUIREMENTS:  - bash
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <rocha[at]ieee.org>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication
#                 SPDX-License-Identifier: Unlicense
#       VERSION:  v1.1
#       CREATED:  2022-09-07 20:12 UTC
#      REVISION:  ---
#===============================================================================
set -e

__ROOTDIR="$(pwd)"
ROOTDIR="${ROOTDIR:-$__ROOTDIR}"

#### Functions _________________________________________________________________

# shellcheck source=../common.lib.sh
. "$ROOTDIR"/scripts/common.lib.sh
# shellcheck source=../lexicographi-sine-finibus/officina/999999999/999999999.lib.sh
. "$LSF_OFFICINA"/999999999/999999999.lib.sh

#### Configurable variables  - - - - - - - - - - - - - - - - - - - - - - - - - -

#######################################
# Compile HTML pages only
#
# Globals:
#   ROOTDIR
#   BUILDTEMPDIR
# Arguments:
#
# Returns
#   None
#######################################
fetch_1603_16_1_0() {
  source_url="https://raw.githubusercontent.com/MDCIII/1603_16_1/main/1603/16/1/0/1603_16_1_0.no1.tm.hxl.csv"
  temporarium_no1="$BUILDTEMPDIR/1603_16_1_0.no1.tm.hxl.csv"
  objective_no1="$ROOTDIR/data/1603_16_1_0.no1.tm.hxl.csv"
  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  set -x
  curl "$source_url" --output "$temporarium_no1"
  frictionless validate "$temporarium_no1"
  set +x
  archivum_copiae_simplici "$temporarium_no1" "$objective_no1"
  
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#### main ______________________________________________________________________

fetch_1603_16_1_0
