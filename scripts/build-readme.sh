#!/bin/bash
#===============================================================================
#
#          FILE:  build-readme.sh
#
#         USAGE:  ./scripts/build-readme.sh
#
#   DESCRIPTION:  ---
#
#       OPTIONS:  ---
#
#  REQUIREMENTS:  - bash
#                 - python3 (used by readme-from-csv.py)
#                 - jq
#                 - github cli
#                 - inotify-tools (github.com/inotify-tools/inotify-tools/wiki)
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <rocha[at]ieee.org>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication
#                 SPDX-License-Identifier: Unlicense
#       VERSION:  v2.0
#       CREATED:  2022-08-31 03:08 UTC
#      REVISION:  2022-09-03 14:40 UTC v1.1 functons moved to common.lib.sh
#                 2022-09-07 20:27 UTC fititnt/awesome-spatial-reference-data
#===============================================================================
set -e

__ROOTDIR="$(pwd)"
ROOTDIR="${ROOTDIR:-$__ROOTDIR}"

#### TODOs _____________________________________________________________________
# - Definelly create this dataset https://en.wikipedia.org/wiki/List_of_administrative_divisions_by_country
# - Maybe create a dataset with https://www.wikidata.org/wiki/Property:P3896
# - Maybe add as generic terminology 
#   - https://www.wikidata.org/wiki/Property:P6512
#   - https://unece.org/trade/uncefact/cl-recommendations

#### Functions _________________________________________________________________

# shellcheck source=common.lib.sh
. "$ROOTDIR"/scripts/common.lib.sh

#### Main ______________________________________________________________________
# Some scripts will need this
gh_clone_lsf_to_scripts

# OPERATION=watch_changes ./scripts/build-readme.sh
if [ "$OPERATION" = "watch_changes" ]; then
  # @see https://superuser.com/questions/181517
  #      /how-to-execute-a-command-whenever-a-file-changes
  # @see https://github.com/inotify-tools/inotify-tools/wiki
  # inotifywait -q -m -e close_write myfile.py |
  # shellcheck disable=SC2034
  inotifywait -q -m -e close_write _layouts/index.template.html |
    while read -r filename event; do
      # ./myfile.py         # or "./$filename"
      # echo "file changed $filename event"

      pwd

      ./scripts/readme-from-csv.py \
        --method=compile-readme \
        --natural-language-objective=en \
        "$ROOTDIR/_layouts/index.template.html" \
        >"$ROOTDIR/index.html"
    done

  exit 0
else
  ./scripts/readme-from-csv.py \
    --method=compile-readme \
    --natural-language-objective=en \
    "$ROOTDIR/_layouts/index.template.html" \
    >"$ROOTDIR/index.html"
  exit 0
fi

set -x

./scripts/readme-from-csv.py \
  --method=compile-readme \
  --natural-language-objective=en \
  _layouts/index.template.html \
  >index.html

# ./scripts/readme-from-csv.py \
#   --method=compile-readme \
#   --natural-language-objective=pt \
#   README.template.md \
#   >README.pt.md

set +x

# frictionless describe --json data/github-topics.hxl.csv
# frictionless describe --json data/general-concepts.hxl.csv
# frictionless describe --json data/software.hxl.csv

# frictionless validate datapackage.json

# pip install csvw
csvwdescribe data/geospatial_data_formats.tm.hxl.csv
# @TODO - https://github.com/sindresorhus/awesome/issues/2242
#       - https://github.com/danielecook/Awesome-Bioinformatics/blob/master/.github/workflows/url-check.yml
#       - https://github.com/peter-evans/link-checker

exit 0
