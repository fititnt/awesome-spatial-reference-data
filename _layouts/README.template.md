# {{ 'project_title' | t }}
[![Frictionless](https://github.com/fititnt/awesome-spatial-epidemiology-and-public-health-surveillance/actions/workflows/frictionless.yml/badge.svg)](https://repository.frictionlessdata.io/pages/dashboard.html?user=fititnt&repo=awesome-spatial-epidemiology-and-public-health-surveillance&flow=frictionless)
[![License: CC0-1.0](https://img.shields.io/badge/License-CC0_1.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)

<!--
![{{ 'project_title' | t }} Banner](partials/awesome-spatial-epidemiology.jpg)
-->

**{{ 'project_summary' | t }}**


## {{ 'section_github_topics_title' | t }}
> **Resoning behind 3 tiers**: Tier 1 is directly related to main topic of our list of recommendations.
> Tier 2 is is related to the scientific area (but not strictly the tooling).
> Tier 3 are related to the tooling (but not restricted to the scientific application).

- **Tier 1**:
{% include_relative partials/github-topics_1.md %}
- **Tier 2**:
{% include_relative partials/github-topics_2.md %}
- **Tier 3**:
{% include_relative partials/github-topics_3.md %}

<!--

{% for item in site.i18n.mul.featured_compilations %}
  {{ item | json }}
  {{ item.name | t }}
  {% for item2 in item.resources %}
    {{ item2.name | t }}
  {% endfor %}
{% endfor %}

{{ datapackage.name }}
{{ datapackage.resource.biosafety_levels }}


-->


## License

[![Public Domain](partials/public-domain.png)](UNLICENSE)

To the extent possible under law, [Emerson Rocha](https://github.com/fititnt)
has waived all copyright and related or neighboring rights to this work to
[Public Domain](UNLICENSE).


<!--
TODOs
- Maybe also add this to the wiki fields https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#attr-fe-autocomplete-country
- Maybe P-Codes are based on FIPS?? https://en.wikipedia.org/wiki/List_of_FIPS_region_codes_(M%E2%80%93O)
- Wikidata SPARQL query equivalent https://www.wikidata.org/wiki/Property:P3921
- Maybe https://www.wikidata.org/wiki/Property:P1921
  - Example: https://www.wikidata.org/wiki/Property:P402

Good interfaces for inspiration:
- https://angryloki.github.io/mreid-resolver/

Etc
- https://www.wikidata.org/wiki/Q36524
- https://wiki.openstreetmap.org/wiki/Category:Properties
- model item (P5869) | specimen | example : https://www.wikidata.org/wiki/Property:P5869
- http://www.statoids.com/umz.html
-->