USE `Campus_Eats_Fall2020`;

-- Creating Audit Table which is a common table to store all audit logs --
-- Table attributes are --
-- audit_id : auto increment PK --
-- audit_action : this is the database action INSERT/UPDATE/DELETE --
-- audit_details : more details on the database action --
-- audit_table : This is the table name eg. restaurant, driver, person, student etc --
-- audit_record_id : Stores the record id of the record that has been inserted/updated/deleted --
CREATE TABLE IF NOT EXISTS `Campus_Eats_Fall2020`.`audit_log` (
  `audit_id` INT NOT NULL AUTO_INCREMENT,
  `audit_action` VARCHAR(100) NOT NULL,
  `audit_details` VARCHAR(200) NOT NULL,
  `audit_table` VARCHAR(150) NOT NULL,
  `audit_record_id` INT NOT NULL,
  PRIMARY KEY (`audit_id`))
ENGINE = InnoDB;

DROP TRIGGER IF EXISTS restaurant_after_insert;
DROP TRIGGER IF EXISTS restaurant_after_update;
DROP TRIGGER IF EXISTS restaurant_after_delete;
DROP TRIGGER IF EXISTS driver_after_insert;
DROP TRIGGER IF EXISTS driver_after_update;
DROP TRIGGER IF EXISTS driver_after_delete;

DELIMITER //

-- TRIGGER 1 : Add audit log record when restaurant is inserted --

CREATE TRIGGER restaurant_after_insert
AFTER INSERT ON restaurant
FOR EACH ROW
BEGIN
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('INSERT',CONCAT('1 row(s) inserted with Restaurant name - ', NEW.restaurant_name),'restaurant', NEW.restaurant_id);
END//

-- TRIGGER 2 : Add audit log record when restaurant is updated --

CREATE TRIGGER restaurant_after_update
AFTER UPDATE ON restaurant
FOR EACH ROW
BEGIN
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('UPDATE',CONCAT('1 row(s) updated with Restaurant name - ', NEW.restaurant_name),'restaurant', NEW.restaurant_id);
END//

-- TRIGGER 3 : Add audit log record when restaurant is deleted --

CREATE TRIGGER restaurant_after_delete
AFTER DELETE ON restaurant
FOR EACH ROW
BEGIN
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('DELETE',CONCAT('1 row(s) deleted with Restaurant name - ', OLD.restaurant_name),'restaurant', OLD.restaurant_id);
END//

-- TRIGGER 4 : Add audit log record when driver is inserted --

CREATE TRIGGER driver_after_insert
AFTER INSERT ON driver
FOR EACH ROW
BEGIN
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('INSERT',CONCAT('1 row(s) inserted with License Number - ', NEW.license_number),'driver', NEW.driver_id);
END//

-- TRIGGER 5 : Add audit log record when driver is updated --

CREATE TRIGGER driver_after_update
AFTER UPDATE ON driver
FOR EACH ROW
BEGIN
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('UPDATE',CONCAT('1 row(s) updated with License Number - ', NEW.license_number),'driver', NEW.driver_id);
END//

-- TRIGGER 6 : Add audit log record when driver is deleted --

CREATE TRIGGER driver_after_delete
AFTER DELETE ON driver
FOR EACH ROW
BEGIN
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('DELETE',CONCAT('1 row(s) deleted with License Number - ', OLD.license_number),'driver', OLD.driver_id);
END//

DELIMITER ;

-- test insert --
CALL insert_restaurant(105, 'Catawba', 'Thompson\'s Toastery', '08AM-11PM', 'HTTPS://WWW.ThomToast.COM');
INSERT INTO driver VALUES(9,52,'us6794',NOW(),NULL);

SELECT * FROM restaurant
WHERE restaurant_id = 105;

SELECT * FROM driver
WHERE driver_id = 9;

-- test update --
UPDATE restaurant
SET schedule = '12PM-02AM'
WHERE restaurant_id = 105;

SELECT * FROM restaurant
WHERE restaurant_id = 105;

-- test delete --
DELETE FROM restaurant WHERE restaurant_id = 105;
DELETE FROM driver WHERE license_number='us6794';

-- view audit logs
select * from audit_log;