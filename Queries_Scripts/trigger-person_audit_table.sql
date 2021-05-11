-- Triggers to store detailed data in audit table when 'person' table record is deleted or a new record is inserted or updated. 
-- These also update an audit log table with every action. 

Use Campus_Eats_Fall2020;

-- Create Audit Log Table For Use With All Tables if not existing
CREATE TABLE IF NOT EXISTS audit_log 
(
  `audit_id` INT NOT NULL AUTO_INCREMENT,
  `audit_action` VARCHAR(100) NOT NULL,
  `audit_details` VARCHAR(200) NOT NULL,
  `audit_table` VARCHAR(150) NOT NULL,
  `audit_record_id` INT NOT NULL,
  PRIMARY KEY (`audit_id`)
)
ENGINE = InnoDB;


-- Create Audit table for person if not existing
Create Table IF NOT EXISTS person_audit
(
	`person_audit_id` int NOT NULL AUTO_INCREMENT,
    `person_id` int NOT NULL,
    `person_name` varchar(300) NOT NULL,
    `person_email` varchar(150) NOT NULL,
    `op_action` varchar(15) NOT NULL,
    `op_timestamp` datetime NOT NULL,
    PRIMARY KEY (`person_audit_id`)
)
ENGINE = InnoDB;



-- Drop Triggers if they already exist
Drop Trigger If Exists insert_person_audit;
Drop Trigger If Exists delete_person_audit;
Drop Trigger If Exists update_person_audit;


DELIMITER //

Create Trigger insert_person_audit
	After Insert On person
    For Each Row
Begin
	Insert Into `Campus_Eats_Fall2020`.`person_audit` (person_id, person_name, person_email, op_action, op_timestamp) Values (new.person_id, new.person_name, new.person_email,'Insert Record', NOW());
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('INSERT',CONCAT('1 row(s) inserted with Person name - ', NEW.person_name),'person', NEW.person_id);
End//

Create Trigger delete_person_audit
	After Delete On person
    For Each Row
Begin
Insert Into `Campus_Eats_Fall2020`.`person_audit` (person_id, person_name, person_email, op_action, op_timestamp) Values (old.person_id, old.person_name, old.person_email, 'Delete Record', NOW());
INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('DELETE',CONCAT('1 row(s) deleted with Person name - ', OLD.person_name),'person', OLd.person_id);
End//

Create Trigger update_person_audit
	After Update On person
    For Each Row
Begin
	Insert Into `Campus_Eats_Fall2020`.`person_audit` (person_id, person_name, person_email, op_action, op_timestamp) Values (old.person_id, old.person_name, old.person_email, 'Update Record', NOW());
    INSERT INTO `Campus_Eats_Fall2020`.`audit_log` (`audit_action`, `audit_details`, `audit_table`, `audit_record_id`) VALUES
    ('UPDATE',CONCAT('1 row(s) updated with Person name - ', NEW.person_name),'person', NEW.person_id);
End//



-- Insert And View Test Values
Insert Into `person`(person_name, person_email, cell) Values ('Jane Doe', 'Jane@test.net', 5555241234),('Joe Doe', 'Joe@test.net', 5555241234), ('Sarah Smith', 'sarahs@test.net', 5555241234), ('John Smith', 'johns@test.net', 5555241234),('Miguel Rodriguez', 'miguelr@test.net', 5555249834);

Select * from person
Order By person_id DESC
Limit 10;

-- Test Deletion of a record
DELETE FROM `campus_eats_fall2020`.`person` WHERE (`person_name` = 'Joe Doe');

-- Test Update of a record
Update `campus_eats_fall2020`.`person` 
SET person_email = 'sarah.smith@stmail.com', cell = 5558792254
WHERE person_name = 'Sarah Smith';

-- Check and verify actions were recorded in the person_audit and audit_log tables
Select * From person_audit;

Select * From audit_log;
