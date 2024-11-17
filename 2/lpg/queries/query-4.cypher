//Find the most recent book in the dataset:

MATCH (b:Book)
RETURN b.title, b.publishYear
ORDER BY b.publishYear DESC
LIMIT 1;
