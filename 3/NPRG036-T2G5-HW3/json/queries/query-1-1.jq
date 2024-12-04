jq  '."@graph"[] 
  | [."ptop:hasEmployee"[]."foaf:givenName",
        [(."cdesc:hasInventory"[] | ."dcterms:title",
            [(."schema:creator"[]."dcat:contactPoint" | del(."@id") | del(."@type"))])
        ]
    ]'