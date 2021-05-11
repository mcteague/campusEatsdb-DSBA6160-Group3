USE campus_eats_fall2020;

DROP FUNCTION IF EXISTS get_avg_restaurant_ratings;

DELIMITER //

CREATE FUNCTION get_avg_restaurant_ratings
(
   restaurant_name_param VARCHAR(75)
)
RETURNS DECIMAL(4,2)
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE avg_restaurant_rating_var DECIMAL(4,2);
  
  SELECT avg_restaurant_rating
  INTO avg_restaurant_rating_var
  FROM restaurant_and_driver_stats
  WHERE restaurant_name = restaurant_name_param;
  
  RETURN avg_restaurant_rating_var;
END//

DELIMITER ;

-- Test Function --
SELECT restaurant_name, get_avg_restaurant_ratings(restaurant_name) AS avg_rating
FROM restaurant_and_driver_stats
WHERE restaurant_name IN ('Mertz Ltd', 'Mayert LLC', 'Ratke LLC');