USE airline;

CREATE TABLE cityState (
    city varchar(90) NOT NULL,
    state char(2) NOT NULL,
    zipCode char(5) NOT NULL UNIQUE,
    PRIMARY KEY (zipCode)
);

INSERT INTO cityState (city, state, zipCode)
SELECT DISTINCT city, state, zipCode
    FROM employee
        WHERE zipCode NOT IN (SELECT DISTINCT zipCode FROM cityState);

INSERT INTO cityState (city, state, zipCode)
SELECT DISTINCT city, state, zipCode
    FROM passenger
        WHERE zipCode NOT IN (SELECT DISTINCT zipCode FROM cityState);

ALTER TABLE employee
ADD FOREIGN KEY (zipCode) REFERENCES cityState(zipCode);

ALTER TABLE employee
DROP COLUMN city;

ALTER TABLE employee
DROP COLUMN state;

ALTER TABLE passenger
ADD FOREIGN KEY (zipCode) REFERENCES cityState(zipCode);

ALTER TABLE passenger
DROP COLUMN city;

ALTER TABLE passenger
DROP COLUMN state;

CREATE TABLE employeePosition (
    employeeId INT NOT NULL UNIQUE,
    positionId INT NOT NULL,
    PRIMARY KEY(employeeId, positionId),
    FOREIGN KEY (employeeId) REFERENCES employee (Id),
    FOREIGN KEY (positionId) REFERENCES position (Id)
);

INSERT INTO employeePosition VALUES (1, 1);
INSERT INTO employeePosition VALUES (2, 2);
INSERT INTO employeePosition VALUES (3, 3);
INSERT INTO employeePosition VALUES (4, 6);
INSERT INTO employeePosition VALUES (5, 7);
INSERT INTO employeePosition VALUES (6, 11);
INSERT INTO employeePosition VALUES (7, 14);
INSERT INTO employeePosition VALUES (8, 15);
INSERT INTO employeePosition VALUES (9, 15);
INSERT INTO employeePosition VALUES (10, 16);
