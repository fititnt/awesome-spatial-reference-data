#!/bin/bash
#===============================================================================
#
#          FILE:  cod_ab.sh
#                 ./scripts/etc/cod_ab.sh
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
#       VERSION:  v1.0
#       CREATED:  2022-09-08 16:22 UTC
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
fetch_cod_ab__fieldmaps() {
  source_url="https://data.fieldmaps.io/cod.csv"
  temporarium_csv="$BUILDTEMPDIR/cod_ab.csv"
  temporarium_hxl="$BUILDTEMPDIR/cod_ab.hxl.csv"
  # objective_no1="$ROOTDIR/data/1603_16_1_0.no1.tm.hxl.csv"
  objective_csv="$ROOTDIR/data/cod-ab.csv"
  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  set -x
  curl "$source_url" --output "$temporarium_csv"
  frictionless validate "$temporarium_csv"
  set +x
  archivum_copiae_simplici "$temporarium_csv" "$objective_csv"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#### main ______________________________________________________________________

fetch_cod_ab__fieldmaps
