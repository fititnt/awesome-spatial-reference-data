#!/bin/bash
#===============================================================================
#
#          FILE:  wikipedia_administrative_divisions.sh
#                 ./scripts/etc/wikipedia_administrative_divisions.sh
#
#         USAGE:
#
#   DESCRIPTION:  https://en.wikipedia.org/wiki/List_of_administrative_divisions_by_country
#
#  REQUIREMENTS:  - bash
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <rocha[at]ieee.org>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication
#                 SPDX-License-Identifier: Unlicense
#       VERSION:  v1.0
#       CREATED:  2022-09-08 20:28 UTC
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
# Download and parse Wikipedia page
# https://en.wikipedia.org/wiki/List_of_administrative_divisions_by_country
#
# Globals:
#   ROOTDIR
#   BUILDTEMPDIR
# Arguments:
#   repo        Repository to fetch the data
#   savepath    (optional) Path to store the metadata
# Returns
#   None
#######################################
crawler_wikipedia_administrative_divisions() {
  # whoccregion="$1"
  # output="$2"
  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  echo "TODO: this wikipedia table is not as trivial to parse;"
  echo "NOTE: maybe we will leave as it is"
  echo ""
  echo "NOTE: okay, maybe we just strip the additional columns created"
  echo "      by pandas (is just used by Australia (as 2022-09-08)"
  echo "      and have repeated content"

  slug="wikipedia_administrative_divisions"
  # exit 1

  source_url="https://en.wikipedia.org/wiki/List_of_administrative_divisions_by_country"
  temporarium_csv="$BUILDTEMPDIR/${slug}.csv"
  temporarium_hxl="$BUILDTEMPDIR/${slug}.csv"
  # temporarium_hxl="$BUILDTEMPDIR/cod_ab.hxl.csv"
  # temporarium_csv="$ROOTDIR/partials/raw/wikipedia-table/biosafety-level-4-laboratories.csv"
  # temporarium_hxl="$BUILDTEMPDIR/biosafety-level-4-laboratories.hxl.csv"
  # frictionless_tempdir="$ROOTDIR/partials/raw/wikipedia-table/"
  # frictionless_tempdir_datapackage="biosafety-level-4-laboratories.datapackage.json"
  # frictionless_tempdir_datapackage="biosafety-level-4-laboratories.datapackage.json"
  # temporarium_hxltm_data="$ROOTDIR/partials/raw/wikipedia-table/biosafety-level-4-laboratories.csv"

  # _data_published="$ROOTDIR/data/biosafety-level-4-laboratories.hxl.csv"

  set -x

  PANDAS_READ_HTML__INDEXTABLE=0 ./scripts/readme-from-csv.py \
    --method='extract-remote-html-table' \
    "$source_url" >"$temporarium_csv"

  head -n 2 "$temporarium_csv"
  frictionless validate "$temporarium_csv"

  # cd "$frictionless_tempdir"

  # # If something goes wrong, frictionless will warn us already at this point
  # frictionless validate "$frictionless_tempdir_datapackage"

  # cd "$ROOTDIR"

  # ./scripts/readme-from-csv.py \
  #   --method=table-rename \
  #   --table-meta=i18n/zxx/biosafety-level-4-facilities.meta.yml \
  #   "$temporarium_csv" \
  #   >"$temporarium_hxl"

  # head -n 2 "$temporarium_hxl"

  # frictionless validate "$temporarium_hxl"

  # set +x
  # if [ -f "$_data_published" ]; then
  #   echo "deleting old [$_data_published]"
  #   rm "$_data_published"
  # fi

  # cp "$temporarium_hxl" "$_data_published"
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#### main ______________________________________________________________________

crawler_wikipedia_administrative_divisions
