-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
    -- i.e., the joined table should have the same number of rows as table PEOPLE

SELECT * FROM people LEFT JOIN (SELECT id,min(address) address from address group by id) a USING(id);


-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
    -- i.e., the joined table should have the same number of rows as table PEOPLE

SELECT * FROM people LEFT JOIN (SELECT id,address FROM address WHERE updatedate IN (SELECT max(updatedate) FROM address GROUP BY id)) a USING(id);

