USE airline;

DELIMITER $$
DROP PROCEDURE IF EXISTS payDeposit$$

CREATE PROCEDURE payDeposit (IN employeeNum int, INOUT deposit varchar(4000))
BEGIN
DECLARE v_finished INTEGER DEFAULT 0;
DECLARE v_lines varchar(100) DEFAULT "--------------------------------------------------------------------------------";
DECLARE v_empFirst VARCHAR(100) DEFAULT "";
DECLARE v_empLast VARCHAR(100) DEFAULT "";
DECLARE v_empAddress VARCHAR(100) DEFAULT "";
DECLARE v_empCity VARCHAR(100) DEFAULT "";
DECLARE v_empState VARCHAR(100) DEFAULT "";
DECLARE v_empZip VARCHAR(100) DEFAULT "";
DECLARE v_tHours INT DEFAULT 0;
DECLARE v_pHourly DECIMAL(5,2) DEFAULT 0.0;
DECLARE v_overtime INT DEFAULT 0;
DECLARE v_count INT DEFAULT 0;
DECLARE v_deposit DECIMAL(8,2) DEFAULT 0.0;

DECLARE employee_cursor CURSOR FOR
SELECT e.firstName, e.lastName, e.address, c.city, c.state, c.zipCode,
 (t.sun + t.mon + t.tues + t.wed + t.thurs + t.fri + t.sat) AS "Hours", p.hourly
 FROM employee e, cityState c, timesheet t, position p, employeeposition ep
 WHERE e.Id = t.employeeId
 AND e.zipCode = c.zipCode
 AND ep.employeeid = e.id
 AND ep.positionid = p.id
 AND t.employeeId = employeeNum
 AND e.Id = employeeNum
 AND ep.employeeid = employeeNum;
 
DECLARE CONTINUE HANDLER
FOR NOT FOUND SET v_finished = 1;

OPEN employee_cursor;

get_employee: LOOP

FETCH employee_cursor INTO v_empFirst, v_empLast, v_empAddress, v_empCity, v_empState, v_empZip, v_tHours, v_pHourly;

IF v_finished = 1 THEN
LEAVE get_employee;
END IF;

SET v_count = v_count + 1;
IF v_count = 1 THEN

IF v_tHours <= 40 THEN
SET v_deposit = v_tHours * v_pHourly;
ELSE
SET v_overtime = (v_tHours - 40) * (v_pHourly * 1.5);
SET v_deposit = (40 * v_pHourly) + v_overtime;
END IF;

SET deposit = CONCAT(deposit, '\n', v_lines, '\n'); 
SET deposit = CONCAT(deposit, '\From:\n');
SET deposit = CONCAT(deposit, '\CGS 2545 Regional Airlines \n');
SET deposit = CONCAT(deposit, '\UCF \n');
SET deposit = CONCAT(deposit, '\MSB 260\n\n');
SET deposit = CONCAT(deposit, 'Pay to the order of:\n\n');
SET deposit = CONCAT(deposit, v_empFirst,' ', v_empLast,'\n');
SET deposit = CONCAT(deposit, v_empAddress, '\n');
SET deposit = CONCAT(deposit, v_empCity, ', ', v_empState,' ',v_empZip,'\n');
SET deposit = CONCAT(deposit, 'In the amount of :\n\n');
SET deposit = CONCAT(deposit, '$',v_deposit,'\n');
SET deposit = CONCAT(deposit, '\n\n**Pay will be deposited into account number provided**\n');
SET deposit = CONCAT(deposit, '\n', v_lines, '\n');

END IF;
END LOOP get_employee;
CLOSE employee_cursor;
END$$

DELIMITER ;

SET @deposit = '';
CALL payDeposit(39, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(29, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(19, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(24, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(14, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(13, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(3, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(30, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(34, @deposit);
SELECT @deposit;

SET @deposit = '';
CALL payDeposit(38, @deposit);
SELECT @deposit;
