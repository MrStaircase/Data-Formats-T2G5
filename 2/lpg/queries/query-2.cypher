//List the number of books published per decade:

MATCH (b:Book)
RETURN (b.publishYear / 10) * 10 AS decade, COUNT(b) AS numBooks
ORDER BY decade;
