jq  '."@graph"[] 
    | select(."cdesc:hasInventory" | length > 2)
    | ."foaf:name"
'