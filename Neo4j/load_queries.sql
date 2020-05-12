create index on :User(id);

:auto USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///friends-000______.txt" as line FIELDTERMINATOR ":"
MERGE (u1:User {id:line[0]});

:auto USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///friends-000______.txt" as line FIELDTERMINATOR ":"
WITH line[1] as id2
WHERE id2 <> '' AND id2 <> 'private' AND id2 <> 'notfound'
UNWIND split(id2,",") as id
WITH distinct id
MERGE (:User {id:id});

:auto USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///friends-000______.txt" as line FIELDTERMINATOR ":"
WITH line[0] as id1, line[1] as id2
WHERE id2 <> '' AND id2 <> 'private' AND id2 <> 'notfound'
MATCH (u1:User {id:id1})
UNWIND split(id2,",") as id 
MATCH (u2:User {id:id})
CREATE (u1)-[:FRIEND_OF]-(u2);


MATCH (n)
RETURN count(n) as count_n;

MATCH ()-[r]-()
RETURN count(r) as count_r;


create index on :User(id);

:auto USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///result.csv" as line FIELDTERMINATOR ":"
MERGE (u1:User {id:line[0]});

:auto USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///result.csv" as line FIELDTERMINATOR ":"
WITH line[1] as id2
UNWIND split(id2,",") as id
WITH distinct id
MERGE (:User {id:id});

:auto USING PERIODIC COMMIT 1000
LOAD CSV FROM "file:///result.csv" as line FIELDTERMINATOR ":"
WITH line[0] as id1, line[1] as id2
MATCH (u1:User {id:id1})
UNWIND split(id2,",") as id 
MATCH (u2:User {id:id})
CREATE (u1)-[:FRIEND_OF]-(u2);
