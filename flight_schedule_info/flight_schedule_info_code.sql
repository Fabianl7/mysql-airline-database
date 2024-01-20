USE airline;

CREATE TABLE timesheet (
	Id INT NOT NULL AUTO_INCREMENT,
	employeeId INT NOT NULL,
	sun INT NOT NULL DEFAULT 0,
	mon INT NOT NULL DEFAULT 0,
	tues INT NOT NULL DEFAULT 0,
	wed INT NOT NULL DEFAULT 0,
	thurs INT NOT NULL DEFAULT 0,
	fri INT NOT NULL DEFAULT 0,
	sat INT NOT NULL DEFAULT 0,
	PRIMARY KEY(Id),
	FOREIGN KEY(employeeId) REFERENCES employee(ID)
);

INSERT INTO timesheet (employeeId, sun, mon, tues, wed, thurs, fri, sat) VALUES
(25, 7, 4, 9, 0, 0, 10, 3),
(13, 0, 12, 6, 10, 6, 8, 0),
(27, 10, 8, 0, 0, 8, 10, 10),
(36, 12, 0, 12, 0, 4, 12, 0),
(12, 6, 6, 6, 6, 6, 5, 0),
(29, 12, 0, 12, 0, 4, 12, 0),
(32, 12, 0, 12, 0, 4, 12, 0),
(6, 12, 0, 12, 0, 4, 12, 0),
(20, 7, 4, 9, 0, 0, 10, 3),
(14, 0, 12, 6, 10, 6, 8, 0),
(21, 6, 6, 6, 6, 6, 5, 0),
(16, 0, 8, 8, 8, 8, 8, 0),
(34, 6, 6, 6, 6, 6, 5, 0),
(9, 10, 8, 0, 0, 8, 10, 10),
(39, 0, 8, 8, 8, 8, 8, 0),
(30, 0, 12, 6, 10, 6, 8, 0),
(38, 6, 6, 6, 6, 6, 5, 0),
(37, 0, 8, 8, 8, 8, 8, 0),
(7, 8, 8, 0, 0, 8, 10, 6),
(1, 10, 8, 0, 0, 8, 10, 10),
(40, 10, 8, 0, 0, 8, 10, 10),
(15, 12, 0, 12, 0, 4, 12, 0),
(2, 8, 8, 0, 0, 8, 10, 6),
(31, 10, 8, 0, 0, 8, 10, 10),
(11, 0, 8, 8, 8, 8, 8, 0),
(24, 6, 6, 6, 6, 6, 5, 0),
(35, 7, 4, 9, 0, 0, 10, 3),
(28, 0, 12, 6, 10, 6, 8, 0),
(8, 0, 8, 8, 8, 8, 8, 0),
(17, 0, 8, 8, 8, 8, 8, 0),
(18, 8, 8, 0, 0, 8, 10, 6),
(23, 0, 12, 6, 10, 6, 8, 0),
(3, 6, 6, 6, 6, 6, 5, 0),
(4, 7, 4, 9, 0, 0, 10, 3),
(10, 10, 8, 0, 0, 8, 10, 10),
(26, 0, 12, 6, 10, 6, 8, 0),
(22, 8, 8, 0, 0, 8, 10, 6),
(33, 8, 8, 0, 0, 8, 10, 6),
(5, 0, 8, 8, 8, 8, 8, 0),
(19, 12, 0, 12, 0, 4, 12, 0);

CREATE VIEW timesheetView AS
SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS Employee,
    p.description AS Position,
    (t.sun + t.mon + t.tues + t.wed + t.thurs + t.fri + t.sat) AS Hours
FROM employee AS e
JOIN employeePosition AS ep ON e.ID = ep.employeeId
JOIN position AS p ON ep.positionId = p.ID
JOIN timesheet AS t ON e.ID = t.employeeId
ORDER BY e.lastName;


CREATE TABLE employeeFlight (
    employeeId INT NOT NULL,
    flightId INT NOT NULL,
    PRIMARY KEY (employeeId, flightId),
    FOREIGN KEY (employeeId) REFERENCES employee(Id),
    FOREIGN KEY (flightId) REFERENCES flight(Id)
);

INSERT INTO employeeFlight (employeeId, flightId) VALUES
(2, 100),
(3, 100),
(34, 100),
(24, 100),
(36, 100),
(38, 106),
(12, 106),
(26, 106),
(28, 106),
(32, 106),
(1, 113),
(3, 113),
(14, 113),
(26, 113),
(36, 113),
(34, 116),
(12, 116),
(24, 116),
(28, 116),
(32, 116);

CREATE VIEW employeeFlightView AS
SELECT
    CONCAT(e.firstName, ' ', e.lastName) AS Employee,
    f.origin AS Origin,
    f.departure AS Departure,
    f.destination AS Destination,
    f.arrival AS Arrival
FROM employee AS e
JOIN employeeFlight AS ef ON e.ID = ef.employeeId
JOIN flight AS f ON ef.flightId = f.ID
ORDER BY f.departure, e.lastName;

CREATE TABLE passengerFlight (
	PassengerId INT NOT NULL,
	flightId INT NOT NULL,
	PRIMARY KEY(passengerId, flightId),
	FOREIGN KEY(passengerId) REFERENCES passenger(Id),
	FOREIGN KEY(flightId) REFERENCES flight(Id)
);

INSERT INTO passengerFlight (passengerId, flightId) VALUES
(2, 100),
(3, 100),
(13, 100),
(19, 100),
(35, 100),
(14, 106),
(30, 106),
(5, 106),
(25, 106),
(33, 106),
(6, 113),
(10, 113),
(20, 113),
(11, 113),
(31, 113),
(8, 116),
(14, 116),
(18, 116),
(1, 116),
(29, 116);

CREATE VIEW passengerFlightView AS
SELECT
    CONCAT(p.firstName, ' ', p.lastName) AS Passenger,
    f.origin AS Origin,
    f.departure AS Departure,
    f.destination AS Destination,
    f.arrival AS Arrival
FROM passenger AS p
JOIN passengerFlight AS pf ON p.ID = pf.passengerId
JOIN flight AS f ON pf.flightId = f.ID
ORDER BY f.departure, p.lastName;
