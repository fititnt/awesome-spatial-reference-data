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

# ./scripts/readme-from-csv.py \
#   --method=extract-github-url 'data/*.csv' \
#   >partials/raw/github-projects-list.txt

# ./scripts/readme-from-csv.py \
#   --method=extract-github-topic-url 'data/*.csv' \
#   >partials/raw/github-topic-list.txt

# ./scripts/readme-from-csv.py \
#   --method=extract-generic-url 'data/*.csv' \
#   >partials/raw/generic-url-list.txt

# ./scripts/readme-from-csv.py \
#   --method=extract-wikidata-q 'data/*.csv' \
#   >partials/raw/wikidata-q-list.txt

# set +x
# gh_repo_statistics_list "partials/raw/github-projects-list.txt"
# gh_topics_statistics_list "partials/raw/github-topic-list.txt"
# # exit 1
# set -x

# liquid_template_1="### [{{raw_line[1]}} ({{raw_line[0]}})](https://www.wikidata.org/wiki/{{raw_line[0]}})
# {{raw_line[2]}}
# "
# # ./scripts/readme-from-csv.py \
# #   data/general-concepts.hxl.csv \
# #   --line-formatter='### [{{raw_line[1]}} ({{raw_line[0]}})](https://www.wikidata.org/wiki/{{raw_line[0]}})\n{{raw_line[2]}}\n' \
# #   >partials/general-concepts.md
# ./scripts/readme-from-csv.py \
#   data/general-concepts.hxl.csv \
#   --line-formatter="$liquid_template_1" \
#   >partials/general-concepts.md

# # ./scripts/readme-from-csv.py \
# #   data/github-topics.hxl.csv \
# #   --line-formatter='==== {{raw_line[1]}}\n`{raw_line}`\n' \
# #   --line-select='{{raw_line[0]}}==1' \
# #   >partials/github-topics_1.md

# # @TODO implement checking how many repos are in a topic
# #       https://docs.github.com/en/rest/search#search-topics
# # @TODO https://gist.github.com/usametov/af8f13a351a66fb05a9895f11417dd9d

# liquid_template_2='  - [{{raw_line[1]}}](https://github.com/topics/{{raw_line[1]}}): {{total_count}} repositories'

# ./scripts/readme-from-csv.py \
#   data/github-topics.hxl.csv \
#   --line-formatter="$liquid_template_2" \
#   --line-select='{{raw_line[0]}}==1' \
#   --data-merge-file-2='partials/raw/github-topic.tsv' \
#   --data-merge-key-2='#item+github_topic' \
#   --data-merge-foreignkey-2='topic' \
#   >partials/github-topics_1.md

# # ./scripts/readme-from-csv.py data/github-topics.hxl.csv --data-merge-file-2='partials/raw/github-topic.tsv' --data-merge-key-2='#item+github_topic' --data-merge-foreignkey-2='topic'

# ./scripts/readme-from-csv.py \
#   data/github-topics.hxl.csv \
#   --line-formatter="$liquid_template_2" \
#   --line-select='{{raw_line[0]}}==2' \
#   --data-merge-file-2='partials/raw/github-topic.tsv' \
#   --data-merge-key-2='#item+github_topic' \
#   --data-merge-foreignkey-2='topic' \
#   >partials/github-topics_2.md

# ./scripts/readme-from-csv.py \
#   data/github-topics.hxl.csv \
#   --line-formatter="$liquid_template_2" \
#   --line-select='{{raw_line[0]}}==3' \
#   --data-merge-file-2='partials/raw/github-topic.tsv' \
#   --data-merge-key-2='#item+github_topic' \
#   --data-merge-foreignkey-2='topic' \
#   >partials/github-topics_3.md

# liquid_template_3='#### [{{ raw_line[1] }} ({{ raw_line[2] }})]({{ raw_line[3] }})
# {{ description }}
# ```
# {{ raw_line[4] }}
# ```'

# ./scripts/readme-from-csv.py \
#   data/software.hxl.csv \
#   --line-formatter="$liquid_template_3" \
#   --line-select='{{raw_line[0]}}=="synthetic-data"' \
#   --data-merge-file-2='partials/raw/github-projects.tsv' \
#   --data-merge-key-2='#item+repository+url' \
#   --data-merge-foreignkey-2='repo' \
#   >partials/software_synthetic-data.md
# # ./scripts/readme-from-csv.py \
# #   data/software.hxl.csv \
# #   --line-formatter='#### [{{raw_line[1]}} ({{raw_line[2]}})]({{raw_line[3]}})\n{{description}}\n```\n{{raw_line[4]}}\n```' \
# #   --line-select='{{raw_line[0]}}=="synthetic-data"' \
# #   --data-merge-file-2='partials/raw/github-projects.tsv' \
# #   --data-merge-key-2='#item+repository+url' \
# #   --data-merge-foreignkey-2='repo' \
# #   >partials/software_synthetic-data.md

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

# @TODO - https://github.com/sindresorhus/awesome/issues/2242
#       - https://github.com/danielecook/Awesome-Bioinformatics/blob/master/.github/workflows/url-check.yml
#       - https://github.com/peter-evans/link-checker

exit 0
