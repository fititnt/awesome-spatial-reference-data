# ontology/README.md


## Temp
- administrative territorial entity (Q56061)
- hierarchy of administrative territorial entities (Q4057633)



## Internal use, ignore this part
```
wdtaxonomy Q6256 -P P131

rdfpipe --input-format=turtle --output-format=longturtle ontology/dcohea~protege.owl.ttl > ontology/dcohea.owl.ttl
rdfpipe --output-format=longturtle ontology/dcohea.owl > ontology/dcohea~temp.owl.ttl
```
