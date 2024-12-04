jq  '[
    ."@graph"[] 
        | {
            Member: ."schema:member"[]."foaf:givenName",
            Book: ."cdesc:hasInventory"[]."dcterms:title", 
            Library_Name: ."foaf:name"
        }
]'