USE campus_eats_fall2020;


DROP TRIGGER IF EXISTS person_insert;
DROP TRIGGER IF EXISTS person_update;

-- TRIGGER 1 

CREATE TRIGGER person_insert
BEFORE INSERT ON person
FOR EACH ROW
SET NEW.person_name = LOWER(NEW.person_name); 

-- TRIGGER 2
CREATE TRIGGER person_update
BEFORE UPDATE ON person
FOR EACH ROW
	SET NEW.person_name = UPPER(NEW.person_name); 
    
 --    TEST -with insert
 
 INSERT INTO person (person_name, person_email, cell)
 VALUES ('Bhomik', 'bhomik@gmail.com', '1111111111');
 
  --    TEST -with update
  
UPDATE person 
	SET person_name = 'Keith Turner'
    WHERE person_id = 1; 
    
--     Result

SELECT *
FROM person
WHERE person_id = 1 OR person_name = 'Bhomik';