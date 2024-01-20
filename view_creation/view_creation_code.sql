USE airline;

SELECT user(); 

CREATE USER 'Fabian'@'localhost' IDENTIFIED BY 'cgs2545$%';

SELECT host, user, select_priv, insert_priv, update_priv, delete_priv, create_priv, drop_priv 
FROM mysql.user;

GRANT SELECT, INSERT, UPDATE ON airline.* TO 'Fabian'@'localhost';

SHOW GRANTS FOR 'Fabian'@'localhost';

system mysql -u Fabian -p

USE airline;

DROP TABLE passengerFlight;

system mysql -u root -p

USE airline;

CREATE USER 'Agent'@'localhost' IDENTIFIED BY 'cgs2545$%';

SELECT host, user, select_priv, insert_priv, update_priv, delete_priv, create_priv, drop_priv 
FROM mysql.user;

GRANT SELECT, SHOW VIEW ON airline.airlinemanifestview TO 'Agent'@'localhost';
GRANT SELECT, SHOW VIEW ON airline.employeeflightview TO 'Agent'@'localhost';
GRANT SELECT, SHOW VIEW ON airline.passengerflightview TO 'Agent'@'localhost';
GRANT SELECT, SHOW VIEW ON airline.timesheetview TO 'Agent'@'localhost';

SHOW GRANTS FOR 'Agent'@'localhost';

system mysql -u Agent -p

USE airline;

SHOW TABLES;

select * from timesheet;
