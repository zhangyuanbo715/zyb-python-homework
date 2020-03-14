-- Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.

SELECT s.name,p.name,hours FROM scientists s INNER JOIN assignedto ON ssn=scientist INNER JOIN projects p ON project=code ORDER BY p.name,s.name;

-- 6.2 Select the project names which are not assigned yet

SELECT name FROM projects where code NOT IN (SELECT project FROM assignedto);

