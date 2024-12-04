jq '[
        [."@graph"[]."cdesc:hasInventory"[] 
            | {Author_Name: ."schema:creator"[]."foaf:givenName", Book_Title: ."dcterms:title"}
        ] 
        | group_by(."Author_Name").[]
        | select(length > 1) 
        | unique
        |.[]
]'