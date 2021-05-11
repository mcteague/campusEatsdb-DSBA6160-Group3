-- Team 3: Bhomik Rudani, Naomi Thammadi, Dustin Ballentine, Mike Teague

-- a)  two roles:  ce_user and ce_admin.     ce_user has select privileges to all tables,    ce_admin has full privileges to all tables 

DROP USER IF EXISTS ce_user;
DROP USER IF EXISTS ce_admin;

CREATE ROLE ce_user;
CREATE ROLE ce_admin;

GRANT ALL ON campus_eats_fall2020.* TO ce_admin;
GRANT SELECT ON campus_eats_fall2020.* TO ce_user;

-- b)  two user accounts:  haps_user with password pa55word and jay_admin with password pa55word (both @localhost if appropriate) 

DROP USER IF EXISTS haps_user;
DROP USER IF EXISTS jay_admin@localhost;

CREATE USER IF NOT EXISTS haps_user IDENTIFIED BY 'pa55word';
CREATE USER IF NOT EXISTS jay_admin@localhost IDENTIFIED BY 'pa55word';

-- c)  assign the ce_user role to haps_user and the ce_admin role to jay_admin 
GRANT ce_admin TO jay_admin@localhost;
GRANT ce_user TO haps_user;

-- d)  create a view to the restaurant table that is named view_haps and only shows restaurant id 1

DROP VIEW IF EXISTS view_haps;

CREATE 
VIEW view_haps AS
    SELECT 
        restaurant_id AS restaurant_id,
        restaurant_name AS restaurant_name
    FROM
        restaurant
    WHERE  restaurant_id = 1;
    
--  e)  grant haps_user both select and update privileges to the view

GRANT SELECT, UPDATE
ON view_haps
TO haps_user WITH GRANT OPTION;

-- DELETE command denied to user haps_user
USE campus_eats_fall2020;
DELETE FROM view_haps
WHERE restaurant_id = 1;

-- UPDATE allowed
UPDATE view_haps
SET restaurant_name = 'Rath Limestone, Inc.'
WHERE restaurant_id = 1;

SELECT * FROM view_haps;




















