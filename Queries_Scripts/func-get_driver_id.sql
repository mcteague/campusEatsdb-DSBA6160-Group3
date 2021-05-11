-- Function to return driver_id given a driver name

USE Campus_Eats_Fall2020;

DROP FUNCTION IF EXISTS get_driver_id;

DELIMITER //

CREATE FUNCTION get_driver_id
(
   driver_name_param VARCHAR(75)
)
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
  DECLARE driver_id_var INT;
  
  SELECT d.driver_id
  INTO driver_id_var
  From person as p
  Inner Join student as s
	On s.person_id = p.person_id
  Inner Join driver as d
	On d.student_id = s.student_id
  WHERE p.person_name = driver_name_param;
  
  RETURN(driver_id_var);
END//

DELIMITER ;

-- Test Function --
SELECT driver_id, license_number, rating
FROM driver
WHERE driver_id = get_driver_id('Stone Kshlerin');

