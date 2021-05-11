USE campus_eats_fall2020;

DROP TRIGGER IF EXISTS restaurant_before_update;
DROP TRIGGER IF EXISTS restaurant_before_insert;

DELIMITER //

CREATE TRIGGER restaurant_before_update
  BEFORE UPDATE ON restaurant
  FOR EACH ROW
BEGIN
    SET NEW.schedule = LOWER(NEW.schedule), NEW.website = LOWER(NEW.website);
END//

CREATE TRIGGER restaurant_before_insert
  BEFORE INSERT ON restaurant
  FOR EACH ROW
BEGIN
    SET NEW.schedule = LOWER(NEW.schedule), NEW.website = LOWER(NEW.website);
END//

DELIMITER ;

-- test cases
CALL insert_restaurant(105, 'Catawba', "Thompson's Toastery", '08AM-11PM', 'HTTPS://WWW.ThomToast.COM');

UPDATE restaurant
SET schedule = '12PM-02AM'
WHERE restaurant_id = 103;

-- test functionality
SELECT *
FROM restaurant
WHERE restaurant_id IN (103, 105);