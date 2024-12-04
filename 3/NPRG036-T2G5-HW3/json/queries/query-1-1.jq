jq  '[."@graph"[] 
  | {Librarian: ."ptop:hasEmployee"[]."foaf:givenName",
        Books: [."cdesc:hasInventory"[]
            | {Title: (."dcterms:title"),
                Author_Contact: [."schema:creator"[]."dcat:contactPoint" | del(."@id") | del(."@type")]}
        ]
    }
]'