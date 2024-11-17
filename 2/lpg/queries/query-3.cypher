//Find members who have not borrowed any books.

MATCH (m:Member)
WHERE NOT (m)-[:BORROWED]->()
RETURN m.name;
