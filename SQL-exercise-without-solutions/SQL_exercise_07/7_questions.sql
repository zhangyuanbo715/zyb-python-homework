-- Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".

SELECT name FROM client WHERE accountnumber=(SELECT recipient FROM package WHERE weight=1.5);

-- 7.2 What is the total weight of all the packages that he sent?

SELECT sender,sum(weight) FROM package WHERE sender=(SELECT recipient FROM package WHERE weight=1.5) GROUP BY sender;

