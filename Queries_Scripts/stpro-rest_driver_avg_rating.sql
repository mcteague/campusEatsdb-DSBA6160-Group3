-- Stored Procedure that returns Restaurant average ratings given a restaurant id--
USE Campus_Eats_Fall2020;

DROP PROCEDURE IF EXISTS get_avg_rating_for_rest_id;

DELIMITER //

CREATE PROCEDURE get_avg_rating_for_rest_id
(
   restaurant_id_param VARCHAR(75)
)
BEGIN
  
  SELECT restaurant_name, ROUND((avg_food_quality+avg_food_temperature+avg_order_correct)/3,2) AS avg_restaurant_rating  
  FROM restaurant_rating_view
  WHERE restaurant_id = restaurant_id_param;
  
END//

DELIMITER ;

CALL get_avg_rating_for_rest_id(49);

-- Stored Procedure that returns Driver average ratings given a driver id--
DROP PROCEDURE IF EXISTS get_avg_rating_for_driver_id;

DELIMITER //

CREATE PROCEDURE get_avg_rating_for_driver_id
(
   driver_id_param VARCHAR(75)
)
BEGIN
  SELECT driver_name, ROUND((avg_overall_experience+avg_driver_speed+avg_driver_courtesy)/3,2) AS avg_driver_rating  
  FROM driver_rating_view
  WHERE driver_id = driver_id_param;
  
END//

DELIMITER ;

CALL get_avg_rating_for_driver_id(4);