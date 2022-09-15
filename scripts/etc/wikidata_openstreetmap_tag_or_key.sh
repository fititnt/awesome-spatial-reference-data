#!/bin/bash
#===============================================================================
#
#          FILE:  wikidata_openstreetmap_tag_or_key.sh
#                 ./scripts/etc/wikidata_openstreetmap_tag_or_key.sh
#
#         USAGE:
#
#   DESCRIPTION:  P1282 OpenStreetMap tag or key
#
#  REQUIREMENTS:  - bash
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <rocha[at]ieee.org>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication
#                 SPDX-License-Identifier: Unlicense
#       VERSION:  v1.1
#       CREATED:  2022-09-14 22:03 UTC
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
wikidata_openstreetmap_tag_or_key() {
  slug="wikidata_osm_keys_or_tags"

  temporarium_hxltm="$BUILDTEMPDIR/${slug}.tm.hxl.csv"
  objective_hxltm="$ROOTDIR/data/${slug}.no1.tm.hxl.csv"

  set -x
  printf "P1282\n" |
    NUMERORDINATIO_BASIM="${LSF_OFFICINA}" \
      "$LSF_OFFICINA/999999999/0/1603_3_12.py" \
      --actionem-sparql --de=P --query --ex-interlinguis \
      --identitas-ex-wikiq-et-wikip --cum-interlinguis=P1282 |
    NUMERORDINATIO_BASIM="${LSF_OFFICINA}" \
      "$LSF_OFFICINA/999999999/0/1603_3_12.py" \
      --actionem-sparql --identitas-ex-wikiq-et-wikip \
      --csv --hxltm --optimum \
      >"${temporarium_hxltm}"

  # printf "P1282\n" | ./999999999/0/1603_3_12.py --actionem-sparql --de=P --query --ex-interlinguis --identitas-ex-wikiq-et-wikip --cum-interlinguis=P1282 | ./999999999/0/1603_3_12.py --actionem-sparql --identitas-ex-wikiq-et-wikip --csv --hxltm --optimum > 999999/0/P1282_3.tm.hxl.csv

  # printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  # set -x
  # curl "$source_url" --output "$temporarium_no1"
  frictionless validate "$temporarium_hxltm"
  set +x
  archivum_copiae_simplici "$temporarium_hxltm" "$objective_hxltm"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#### main ______________________________________________________________________

wikidata_openstreetmap_tag_or_key
