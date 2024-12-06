// Node creation

// Creating Library nodes
CREATE (library1:Library {name: "City Library", address: "Italska 70"});
CREATE (library2:Library {name: "Central Library", address: "Main Street 123"});
CREATE (library3:Library {name: "Eastern Library", address: "East Street 321"});

// Creating Librarian nodes
CREATE (librarian1:Librarian {employeeID: 165, name: "Natalie"});
CREATE (librarian2:Librarian {employeeID: 167, name: "John"});
CREATE (librarian3:Librarian {employeeID: 169, name: "Ben"});

// Creating Book nodes
CREATE (book1:Book {bookID: 64, ISBN: "147257", title: "Hard to Be a God", publishYear: 1964});
CREATE (book2:Book {bookID: 65, ISBN: "147258", title: "Forth Wing", publishYear: 2022});
CREATE (book3:Book {bookID: 66, ISBN: "147259", title: "East of Eden", publishYear: 1952});

// Creating Member nodes
CREATE (member1:Member {memberID: 514986, name: "George"});
CREATE (member2:Member {memberID: 514987, name: "Jane"});
CREATE (member3:Member {memberID: 514988, name: "Michael"});

// Creating Author nodes
CREATE (author1:Author {authorID: 8455, name: "Boris"});
CREATE (author2:Author {authorID: 8456, name: "Dwayne"});
CREATE (author3:Author {authorID: 8457, name: "John"});

// Creating Contact Information nodes
CREATE (contact1:ContactInformation {phoneNumber: "+123456789", email: "natalie@def.com"});
CREATE (contact2:ContactInformation {phoneNumber: "+987654321", email: "jane.doe@library.com"});
CREATE (contact3:ContactInformation {phoneNumber: "+987654322", email: "john.doe@library.com"});
CREATE (contact4:ContactInformation {phoneNumber: "+987654323", email: "george.doe@library.com"});
CREATE (contact5:ContactInformation {address: "777 Brockton Avenue, Abington MA 2351", phoneNumber: "+987654324", email: "john_2.doe@library.com"});
CREATE (contact6:ContactInformation {address: "30 Memorial Drive, Avon MA 2322", phoneNumber: "+987654325", email: "mailto:dwayne.doe@library.com"});
CREATE (contact7:ContactInformation {address: "250 Hartford Avenue, Bellingham MA 2019", phoneNumber: "+987654326", email: "ben.doe@library.com"});
CREATE (contact8:ContactInformation {address: "700 Oak Street, Brockton MA 2301", phoneNumber: "+987654327", email: "michael.doe@library.com"});
CREATE (contact9:ContactInformation {address: "591 Memorial Dr, Chicopee MA 1020", phoneNumber: "+987654328", email: "boris.doe@library.com"});

// Relationship creation

// Connecting Libraries to Librarians (MANAGED_BY)
MATCH (library1:Library {name: "City Library"}), (librarian1:Librarian {name: "Natalie"})
CREATE (library1)-[:MANAGED_BY]->(librarian1);

MATCH (library2:Library {name: "Central Library"}), (librarian2:Librarian {name: "John"})
CREATE (library2)-[:MANAGED_BY]->(librarian2);

MATCH (library3:Library {name: "Eastern Library"}), (librarian3:Librarian {name: "Ben"})
CREATE (library3)-[:MANAGED_BY]->(librarian3);

// Connecting Libraries to Books (HOLDS)
MATCH (library1:Library {name: "City Library"}), (book2:Book {title: "Forth Wing"})
CREATE (library1)-[:HOLDS]->(book2);

MATCH (library2:Library {name: "Central Library"}), (book3:Book {title: "East of Eden"})
CREATE (library2)-[:HOLDS]->(book3);

MATCH (library3:Library {name: "Eastern Library"}), (book1:Book {title: "Hard to Be a God"})
CREATE (library3)-[:HOLDS]->(book1);

MATCH (library3:Library {name: "Eastern Library"}), (book2:Book {title: "Forth Wing"})
CREATE (library3)-[:HOLDS]->(book2);

MATCH (library3:Library {name: "Eastern Library"}), (book3:Book {title: "East of Eden"})
CREATE (library3)-[:HOLDS]->(book3);

// Connecting Libraries to Members (HAS_MEMBER {since date "YYYY-MM-DD"})
MATCH (library1:Library {name: "City Library"}), (member1:Member {name: "George"})
CREATE (library1)-[:HAS_MEMBER {since: "2017-5-17"}]->(member1);

MATCH (library2:Library {name: "Central Library"}), (member2:Member {name: "Jane"})
CREATE (library2)-[:HAS_MEMBER {since: "2024-1-1"}]->(member2);

MATCH (library3:Library {name: "Eastern Library"}), (member2:Member {name: "Jane"})
CREATE (library3)-[:HAS_MEMBER {since: "2018-6-7"}]->(member2);

MATCH (library3:Library {name: "Eastern Library"}), (member3:Member {name: "Michael"})
CREATE (library3)-[:HAS_MEMBER {since: "2020-12-24"}]->(member3);

// Connecting Books to Authors (WRITTEN_BY {writing period in months})
MATCH (book1:Book {title: "Hard to Be a God"}), (author1:Author {name: "Boris"})
CREATE (book1)-[:WRITTEN_BY {writing_period: 13}]->(author1);

MATCH (book2:Book {title: "Forth Wing"}), (author2:Author {name: "Dwayne"})
CREATE (book2)-[:WRITTEN_BY {writing_period: 97}]->(author2);

MATCH (book3:Book {title: "East of Eden"}), (author3:Author {name: "John"})
CREATE (book3)-[:WRITTEN_BY {writing_period: 25}]->(author3);

// Connecting Libranians, Authors and Members to Contact Information (HAS_CONTACT_INFORMATION)

MATCH (librarian1:Librarian {name: "Natalie"}), (contact1:ContactInformation {phoneNumber: "+123456789"})
CREATE (librarian1)-[:HAS_CONTACT_INFORMATION]->(contact1);

MATCH (librarian2:Librarian {name: "John"}), (contact3:ContactInformation {phoneNumber: "+987654322"})
CREATE (librarian2)-[:HAS_CONTACT_INFORMATION]->(contact3);

MATCH (librarian3:Librarian {name: "Ben"}), (contact7:ContactInformation {phoneNumber: "+987654326"})
CREATE (librarian3)-[:HAS_CONTACT_INFORMATION]->(contact7);

MATCH (member1:Member {name: "George"}), (contact4:ContactInformation {phoneNumber: "+987654323"})
CREATE (member1)-[:HAS_CONTACT_INFORMATION]->(contact4);

MATCH (member2:Member {name: "Jane"}), (contact2:ContactInformation {phoneNumber: "+987654321"})
CREATE (member2)-[:HAS_CONTACT_INFORMATION]->(contact2);

MATCH (member3:Member {name: "Michael"}), (contact8:ContactInformation {phoneNumber: "+987654327"})
CREATE (member3)-[:HAS_CONTACT_INFORMATION]->(contact8);

MATCH (author1:Author {name: "Boris"}), (contact9:ContactInformation {phoneNumber: "+987654328"})
CREATE (author1)-[:HAS_CONTACT_INFORMATION]->(contact9);

MATCH (author2:Author {name: "Dwayne"}), (contact6:ContactInformation {phoneNumber: "+987654325"})
CREATE (author2)-[:HAS_CONTACT_INFORMATION]->(contact6);

MATCH (author3:Author {name: "John"}), (contact5:ContactInformation {phoneNumber: "+987654324"})
CREATE (author3)-[:HAS_CONTACT_INFORMATION]->(contact5);
