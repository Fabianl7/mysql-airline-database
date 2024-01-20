USE airline;

CREATE TABLE flight (
	Id INT NOT NULL AUTO_INCREMENT,
	origin char(3) NOT NULL,
	destination char(3) NOT NULL UNIQUE,
	aircraft INT NOT NULL,
	departure TIMESTAMP NOT NULL,
	arrival TIMESTAMP NOT NULL,
	PRIMARY KEY(Id),
	FOREIGN KEY(origin) REFERENCES airport(faa),
	FOREIGN KEY(destination) REFERENCES airport(faa),
	FOREIGN KEY(aircraft) REFERENCES aircraft(Id)
);

ALTER TABLE flight AUTO_INCREMENT = 100;

INSERT INTO flight (origin, destination, aircraft, departure, arrival) VALUES
('DAB','FLL','1','2023-11-01 07:00:00','2023-11-01 08:00:00'),
('FLL','RSW','9','2023-11-01 08:00:00','2023-11-01 09:00:00'),
('RSW','VPS','2','2023-11-01 09:00:00','2023-11-01 10:00:00'),    
('VPS','GNV','8','2023-11-01 10:00:00','2023-11-01 11:00:00'),
('GNV','JAX','3','2023-11-11 11:00:00','2023-11-11 12:00:00'),    
('JAX','EYW','7','2023-11-11 12:00:00','2023-11-11 13:00:00'),
('EYW','MLB','4','2023-11-04 13:00:00','2023-11-04 14:00:00'),
('MLB','MIA','6','2023-11-04 14:00:00','2023-11-04 15:00:00'),
('MIA','MCO','5','2023-11-05 15:00:00','2023-11-05 16:00:00'),
('MCO','ECP','5','2023-11-05 16:00:00','2023-11-05 17:00:00'),    
('ECP','PNS','6','2023-11-06 17:00:00','2023-11-06 18:00:00'),
('PNS','PGD','4','2023-11-06 19:00:00','2023-11-06 20:00:00'),
('PGD','SFB','7','2023-11-07 07:00:00','2023-11-07 08:00:00'),
('SFB','SRQ','3','2023-11-07 09:00:00','2023-11-07 10:00:00'),    
('SRQ','PIE','8','2023-11-08 07:00:00','2023-11-08 08:00:00'),
('PIE','TLH','2','2023-11-08 09:00:00','2023-11-08 10:00:00'),
('TLH','TPA','9','2023-11-09 07:00:00','2023-11-09 08:00:00'),    
('TPA','PBI','1','2023-11-09 10:00:00','2023-11-09 11:00:00'),
('PBI','DAB','10','2023-11-10 11:00:00','2023-11-10 12:00:00');

SELECT
    f.Id AS "Flight Number",
    f.origin AS "Origin",
    f.departure AS "Departure",
    f.destination AS "Destination",
    f.arrival AS "Arrival",
    a.model AS "Aircraft"
FROM
    flight AS f
JOIN
    aircraft AS a
ON
    f.aircraft = a.Id
ORDER BY
    f.departure;
