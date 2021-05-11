USE `Campus_Eats_Fall2020`;

DROP FUNCTION IF EXISTS get_avg_driver_rating_func;
DROP TRIGGER IF EXISTS update_driver_rating_on_driver;

DELIMITER //

-- Creating a function to mimic the Stored procedure get_avg_rating_for_driver_id --
-- This is because we cannot use Stored Procedures in Triggers --
-- Function accepts driver id as parameter and returns driver rating from View "driver_rating_view" --
CREATE FUNCTION get_avg_driver_rating_func
(
   driver_id_param INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE driver_rating_var DECIMAL(10,2);
  -- Calculate driver rating and assign to driver_rating_var --
  SELECT ROUND((avg_overall_experience+avg_driver_speed+avg_driver_courtesy)/3,2) INTO driver_rating_var
  FROM Campus_Eats_Fall2020.driver_rating_view
  WHERE driver_id = driver_id_param;
  
  RETURN(driver_rating_var);
END//

DELIMITER ;

-- test the function -- 
select get_avg_driver_rating_func(1) ;

DELIMITER //

-- TRIGGER 7 : Update the rating attribute in driver table every time a driver rating record is inserted --

CREATE TRIGGER update_driver_rating_on_driver
AFTER INSERT ON driver_rating
FOR EACH ROW
BEGIN
	DECLARE order_id_var INT;
	DECLARE driver_id_var INT;
    
    -- get order id and driver id values from the rating and order tables respectively --
	SELECT `order_id` INTO order_id_var FROM `Campus_Eats_Fall2020`.`rating` WHERE rating_id=NEW.rating_id;
    SELECT `driver_id` INTO driver_id_var FROM `Campus_Eats_Fall2020`.`order` WHERE order_id=order_id_var;
    
    UPDATE `Campus_Eats_Fall2020`.`driver`
    SET rating = get_avg_driver_rating_func(driver_id_var)
    WHERE driver_id=driver_id_var;
END//

DELIMITER ;

-- test cases --

-- check previous rating for driver --
select * from driver where driver_id=1;
CALL get_avg_rating_for_driver_id(1);

-- Insert data --
INSERT INTO `Campus_Eats_Fall2020`.`order` VALUES (1001,1,1,1,1,1,15.63,8);
INSERT INTO `Campus_Eats_Fall2020`.`rating` VALUES (1001,1001,5);
INSERT INTO `Campus_Eats_Fall2020`.`driver_rating` VALUES (1001,5,5,'Good driver');

-- verify updated rating --
select * from driver where driver_id=1;