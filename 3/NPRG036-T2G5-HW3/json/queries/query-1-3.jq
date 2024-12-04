jq  '[
    ."@graph"[] 
        | {
            Library_Name: ."foaf:name", 
            Book: ."cdesc:hasInventory"[]."dcterms:title", 
            Member: ."schema:member"[]."foaf:givenName"
        }
]'