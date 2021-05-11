USE campus_eats_fall2020;

DROP PROCEDURE IF EXISTS insert_restaurant;

DELIMITER //

CREATE PROCEDURE insert_restaurant
(
  restaurant_id_param     INT,
  location_param          VARCHAR(75),
  restaurant_name_param   VARCHAR(75),
  restaurant_schedule_param     VARCHAR(75),
  website_param           VARCHAR(75)
)
BEGIN
  DECLARE location_var           VARCHAR(75);

  -- Validate paramater values
  IF length(restaurant_name_param) > 75 THEN
    SIGNAL SQLSTATE '22001'
      SET MESSAGE_TEXT = "Data too long for column 'restaurant_name_param' at row 1", 
      MYSQL_ERRNO = 1406;
  ELSEIF length(location_param) > 75 THEN
    SIGNAL SQLSTATE '22001'
      SET MESSAGE_TEXT = "Data too long for column 'location_param' at row 1", 
      MYSQL_ERRNO = 1406;
  ELSEIF NOT REGEXP_LIKE(restaurant_schedule_param,'^[0-9]am-|^[0-9]pm-|[0-9]am$|[0-9]pm$','i') = 1 
	OR length(restaurant_schedule_param) > 9 THEN 
    SIGNAL SQLSTATE '22023'
      SET MESSAGE_TEXT = 'Schedule should be of the format 10am-11pm', 
      MYSQL_ERRNO = 1644;
  END IF;
  

  -- Set default values for parameters
  IF location_param IS NULL THEN
	SET location_var = "No location specified";
  ELSE
    SET location_var = location_param;
  END IF;
  
  
  INSERT INTO restaurant
         (restaurant_id, location, restaurant_name, 
          restaurant.schedule, website)
  VALUES (restaurant_id_param, location_var, restaurant_name_param, 
          restaurant_schedule_param, website_param);
END//

DELIMITER ;

-- Good Data --
CALL insert_restaurant(101, 'Raleigh', 'Bhomiks Bagels', '08AM-09PM', 'Bagels.com');
CALL insert_restaurant(102, 'Charlotte', 'Dustins Doughnuts', '08AM-09PM', 'DusDoughnuts.com');
CALL insert_restaurant(103, 'Charlotte', 'Mikes Macaroni', '08AM-09PM', 'MikesMac.com');
CALL insert_restaurant(104, 'Greensboro', 'Naomis Noodles', '08AM-11pm', 'NaoNoodles.com');

-- Bad Data --
CALL insert_restaurant(110, 'Greensboro', 'Review of Dustins Doughnuts - They served the best doughnuts i have ever had. They are the best at making Noodles.', '08AM-11pm', 'NaoNoodles.com');
CALL insert_restaurant(112, 'Apartment 2144A Utrich van der Waalenhaimer Strasse, Richmond, Virginia 51554-2883', 'Naomis Noodles', '08AM-11pm', 'NaoNoodles.com');
CALL insert_restaurant(110, 'Raleigh', 'Bhomiks Bagels', '08:30AM to 11:00PM', 'Bagels.com');
CALL insert_restaurant(111, 'Roanoke', 'Bhomiks Bagels', 'Nine in the morning til noon', 'Bagels.com');


