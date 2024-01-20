USE airline;

CREATE VIEW airlineManifestView AS    
SELECT 
    CONCAT(employee.firstName, ' ', employee.lastName) AS Name,
    employee.phone AS PhoneNumber,
    position.description AS Role,
    flight.origin AS Origin,
    flight.departure AS Departure,
    flight.destination AS Destination,
    flight.arrival AS Arrival
FROM 
    employee
JOIN 
    employeeFlight ON employee.ID = employeeFlight.employeeID
JOIN 
    flight ON employeeFlight.flightID = flight.ID
JOIN 
    employeePosition ON employee.ID = employeePosition.employeeID
JOIN 
    position ON employeePosition.positionID = position.ID
    
UNION

SELECT 
    CONCAT(passenger.firstName, ' ', passenger.lastName) AS Name,
    passenger.phone AS PhoneNumber,
    'Passenger' AS Role,
    flight.origin AS Origin,
    flight.departure AS Departure,
    flight.destination AS Destination,
    flight.arrival AS Arrival
FROM 
    passenger
JOIN 
    passengerFlight ON passenger.ID = passengerFlight.passengerID
JOIN 
    flight ON passengerFlight.flightID = flight.ID;
