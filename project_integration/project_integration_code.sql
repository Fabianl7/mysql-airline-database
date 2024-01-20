USE airline;

DELIMITER $$

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employee 
FOR EACH ROW
BEGIN
    INSERT INTO timesheet (employeeId, sun, mon, tues, wed, thurs, fri, sat) VALUES 
    (NEW.ID, 0, 0, 0, 0, 0, 0, 0);
END$$

DELIMITER ;

INSERT INTO employee (firstName, lastName, address, zipCode, phone, email) VALUES
('Fatima','Robles','2519 Bottom Lane','33900','5126024452','frobles@airline.com'),
('Angelita','Turner','3447 Valley Lane','33109','8574960348','aturner@airline.com'),
('Robert','Johnson','526 Metz Lane','32401','5306942786','rjohnson@airline.com'),
('Francisca','Spence','1253 Coulter Lane','32547','8043389754','fspence@airline.com'),
('Matthew','Lee','756 Long Street','32601','3522635642','mlee@airline.com');

CREATE TABLE employeeAudit (
    ID INT NOT NULL AUTO_INCREMENT,
    employeeNumber INT NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(90) NOT NULL UNIQUE,
    changeDate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (ID)
);

DELIMITER $$

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employeeAudit (action, employeeNumber, firstName, lastName, email, changeDate) VALUES
    ('UPDATE', OLD.ID, OLD.firstName, OLD.lastName, OLD.email, NOW());
END$$

DELIMITER ;

UPDATE employee
SET email = CONCAT(
    SUBSTRING_INDEX(email, '@', 1), 
    '@',
    CASE 
        WHEN SUBSTRING_INDEX(email, '@', -1) = 'cruise.com' THEN 'airline.com'
        WHEN SUBSTRING_INDEX(email, '@', -1) = 'isp.com' THEN 'airline.com'
        ELSE SUBSTRING_INDEX(email, '@', -1)
    END
)
WHERE email LIKE '%@cruise.com' OR email LIKE '%@isp.com';
