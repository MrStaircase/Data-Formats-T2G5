//Get the number of libraries located on a specific street (e.g., streets with "Street" in their name).

MATCH (lib:Library)
WHERE lib.address CONTAINS "Street"
RETURN COUNT(lib) AS numLibrariesOnStreet;

