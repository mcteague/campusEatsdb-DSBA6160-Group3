USE Campus_Eats_Fall2020;

DROP FUNCTION IF EXISTS get_restaurant_id;

DELIMITER //

CREATE FUNCTION get_restaurant_id
(
   restaurant_name_param VARCHAR(75)
)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE restaurant_id_var INT;
  
  SELECT r.restaurant_id
  INTO restaurant_id_var
  From restaurant as r
  WHERE r.restaurant_name = restaurant_name_param ;
  RETURN(restaurant_id_var);
END//

DELIMITER ;

SELECT restaurant_name, get_restaurant_id(restaurant_name)
FROM restaurant
WHERE restaurant_name IN ('Ratke LLC', 'Berge Inc', 'Mayert LLC', 'Abbott-Schmitt' );