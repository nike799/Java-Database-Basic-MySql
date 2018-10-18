CREATE DATABASE airport_management_system;
USE airport_management_system;


                  01. Table Design
                  ----------------
CREATE TABLE towns (
  town_id INT(11) PRIMARY KEY AUTO_INCREMENT,
  town_name VARCHAR(30) NOT NULL
);

CREATE TABLE airports (
  airport_id INT(11) PRIMARY KEY AUTO_INCREMENT,
  airport_name VARCHAR(50) NOT NULL,
  town_id INT(11),
  CONSTRAINT fk_towns_town_id FOREIGN KEY (town_id)
    REFERENCES towns(town_id)
);

CREATE TABLE airlines (
  airline_id INT(11) PRIMARY KEY AUTO_INCREMENT,
  airline_name VARCHAR(30) NOT NULL,
  nationality VARCHAR(30) NOT NULL,
  rating INT(11) DEFAULT 0
);

CREATE TABLE customers (
  customer_id INT(11)PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(20) NOT NULL,
  last_name VARCHAR(20) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender VARCHAR(1),
  home_town_id INT(11),
  CONSTRAINT fk_towns_home_town_id FOREIGN KEY (home_town_id)
    REFERENCES towns(town_id)
);

CREATE TABLE flights (
  flight_id INT(11)PRIMARY KEY AUTO_INCREMENT,
  departure_time DATETIME NOT NULL,
  arrival_time DATETIME NOT NULL,
  status VARCHAR(9),
  origin_airport_id INT(11),
  destination_airport_id INT(11),
  airline_id INT(11),
  CONSTRAINT fk_airports_origin_airport_id FOREIGN KEY (origin_airport_id)
    REFERENCES airports (airport_id),
  CONSTRAINT fk_airports_destination_airport_id FOREIGN KEY (destination_airport_id)
    REFERENCES airports (airport_id),
  CONSTRAINT fk_airlines_airline_id FOREIGN KEY (airline_id)
    REFERENCES airlines (airline_id)
);

CREATE TABLE tickets (
  ticket_id INT(11)PRIMARY KEY AUTO_INCREMENT,
  price DECIMAL(8,2) NOT NULL,
  class VARCHAR(6),
  seat VARCHAR(5) NOT NULL,
  customer_id INT(11),
  flight_id INT(11),
  CONSTRAINT fk_customers_customer_id FOREIGN KEY (customer_id)
    REFERENCES customers (customer_id),
  CONSTRAINT fk_flights_flight_id FOREIGN KEY (flight_id)
    REFERENCES flights (flight_id)
);

                 02. Insert
                 ----------
INSERT INTO flights (departure_time, arrival_time, `status`, origin_airport_id, destination_airport_id, airline_id)
SELECT '2017-06-19 14:00:00'                   AS departure_time,
       '2017-06-21 11:00:00'                   AS arrival_time,
       (CASE
          WHEN a.airline_id % 4 = 0 THEN 'Departing'
          WHEN a.airline_id % 4 = 1 THEN 'Delayed'
          WHEN a.airline_id % 4 = 2 THEN 'Arrived'
          WHEN a.airline_id % 4 = 3 THEN 'Canceled'
           END)                                AS `status`,
       CEIL(SQRT(CHAR_LENGTH(a.airline_name))) AS origin_airport_id,
       CEIL(SQRT(CHAR_LENGTH(a.nationality)))  AS destination_airport_id,
       airline_id                            AS airline_id
FROM airlines AS a
WHERE airline_id BETWEEN 1 AND 10;

                    03. Update Flights
                    ----------------
INSERT INTO flights (departure_time, arrival_time, `status`, origin_airport_id, destination_airport_id, airline_id)
SELECT '2017-06-19 14:00:00'                   AS departure_time,
       '2017-06-21 11:00:00'                   AS arrival_time,
       (CASE
          WHEN a.airline_id % 4 = 0 THEN 'Departing'
          WHEN a.airline_id % 4 = 1 THEN 'Delayed'
          WHEN a.airline_id % 4 = 2 THEN 'Arrived'
          WHEN a.airline_id % 4 = 3 THEN 'Canceled'
           END)                                AS `status`,
       CEIL(SQRT(CHAR_LENGTH(a.airline_name))) AS origin_airport_id,
       CEIL(SQRT(CHAR_LENGTH(a.nationality)))  AS destination_airport_id,
       airline_id                            AS airline_id
FROM airlines AS a
WHERE airline_id BETWEEN 1 AND 10;

                     04. Update Tickets
                     ------------------
UPDATE tickets AS t
JOIN flights f ON t.flight_id = f.flight_id
JOIN airlines AS a ON f.airline_id = a.airline_id
SET price = price * 1.5
WHERE a.airline_id = (SELECT MAX(a.airline_id));

                      05. Tickets
                      -----------
  SELECT ticket_id, price, class, seat FROM tickets
    ORDER BY ticket_id ASC;

                      06. Customers
                       -------------
SELECT customer_id,CONCAT(first_name,' ',last_name) AS full_name, gender
  FROM customers
  ORDER BY full_name ASC,customer_id ASC;


                      07. Flights
                      -----------
SELECT customer_id,CONCAT(first_name,' ',last_name) AS full_name, gender
   FROM customers
ORDER BY full_name ASC,customer_id ASC;

                      08. Top 5 Airlines
                      -------------------
SELECT customer_id,CONCAT(first_name,' ',last_name) AS full_name, gender
FROM customers
ORDER BY full_name ASC,customer_id ASC;

                      09. First Class Tickets
                      -----------------------
SELECT ticket_id,	a.airport_name AS destination,
       CONCAT(c.first_name,' ', c.last_name) AS customer_name FROM tickets AS t
JOIN customers AS c ON t.customer_id = c.customer_id
JOIN flights f ON t.flight_id = f.flight_id
JOIN airports a ON f.destination_airport_id = a.airport_id
WHERE t.price < 5000 AND t.class LIKE 'First'
ORDER BY ticket_id ASC;

                       10. Home Town Customers
                       -----------------------
SELECT DISTINCT (c.customer_id), CONCAT(c.first_name, ' ', c.last_name) AS full_name, t.town_name AS home_town
FROM customers AS c
       JOIN towns t ON c.home_town_id = t.town_id
       JOIN tickets ti ON c.customer_id = ti.customer_id
       JOIN flights f ON ti.flight_id = f.flight_id
       JOIN airports a ON f.origin_airport_id = a.airport_id AND a.town_id = c.home_town_id
WHERE f.status LIKE 'Departing'
ORDER BY c.customer_id;

                        11. Flying Customers
                        --------------------
SELECT DISTINCT (c.customer_id),
                CONCAT(c.first_name, ' ', c.last_name) AS full_name,
                TIMESTAMPDIFF(YEAR,c.date_of_birth,'2016-12-31
                ') AS age FROM customers AS c
INNER JOIN tickets t ON c.customer_id = t.customer_id
INNER JOIN flights f ON t.flight_id = f.flight_id
WHERE f.status LIKE 'Departing'
ORDER BY age ASC, c.customer_id ASC;

                         12. Delayed Customers
                         ---------------------
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS full_name,
       ti.price                               AS ticket_price,
       a.airport_name                         AS destination
FROM customers AS c
       INNER JOIN tickets ti ON c.customer_id = ti.customer_id
       INNER JOIN flights f ON ti.flight_id = f.flight_id
       INNER  JOIN airports AS a ON a.airport_id = f.destination_airport_id
WHERE f.status LIKE 'Delayed'
ORDER BY ti.price DESC
LIMIT 3;
                           13. Last Departing Flights
                           --------------------------
SELECT *
FROM (SELECT f.flight_id, f.departure_time, f.arrival_time, a.airport_name AS origin, a1.airport_name AS destination
      FROM flights AS f
             INNER JOIN airports AS a ON f.origin_airport_id = a.airport_id
             INNER JOIN airports AS a1 ON f.destination_airport_id = a1.airport_id
      WHERE f.status LIKE 'Departing'
      ORDER BY f.departure_time DESC
     LIMIT 5) AS last_5
ORDER BY departure_time ASC, flight_id ASC;

                            14. Flying Children
                            -------------------
SELECT DISTINCT (c.customer_id),CONCAT(c.first_name,' ',c.last_name) AS full_name,	TIMESTAMPDIFF(YEAR ,c.date_of_birth,'2016-12-31') AS age
  FROM customers AS c
  JOIN tickets AS ti ON c.customer_id = ti.customer_id
  JOIN flights f ON ti.flight_id = f.flight_id
WHERE TIMESTAMPDIFF(YEAR ,c.date_of_birth,'2016-12-31') < 21 AND f.status LIKE 'Arrived'
ORDER BY age DESC, c.customer_id ASC;

                             15. Airports and Passengers
                             ---------------------------
SELECT DISTINCT (c.customer_id),CONCAT(c.first_name,' ',c.last_name) AS full_name,	TIMESTAMPDIFF(YEAR ,c.date_of_birth,'2016-12-31') AS age
  FROM customers AS c
  JOIN tickets AS ti ON c.customer_id = ti.customer_id
  JOIN flights f ON ti.flight_id = f.flight_id
WHERE TIMESTAMPDIFF(YEAR ,c.date_of_birth,'2016-12-31') < 21 AND f.status LIKE 'Arrived'
ORDER BY age DESC, c.customer_id ASC;

                              16. Submit Review
                              -----------------
CREATE PROCEDURE udp_submit_review (customer_id1 INT, review_content1 VARCHAR(255),
  review_grade1 INT,airline_name1 VARCHAR(255))
  BEGIN
    DECLARE airline_id2 INT;
    SET airline_id2 := (SELECT a.airline_id FROM airlines AS a
                      WHERE a.airline_name LIKE airline_name1);
    IF airline_id2 IS NULL THEN
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Airline does not exist.';
      ELSE
        INSERT INTO customer_reviews (review_content, review_grade, airline_id, customer_id)
        VALUES (review_content1,review_grade1,airline_id2,customer_id1);
    END IF;
  END;

                               17. Ticket Purchase  Compile error!!!!!!!!!
                               -------------------
 CREATE PROCEDURE udp_purchase_ticket (customer_id1 INT,flight_id1 INT,ticket_price DECIMAL(8,2),class1 VARCHAR(6),seat1 VARCHAR(5))
  BEGIN
    START TRANSACTION;
  IF ticket_price > (SELECT cba.balance FROM customer_bank_accounts AS cba)THEN
    ROLLBACK;
    ELSE
    COMMIT;
  END IF;
    INSERT INTO tickets (price, class, seat, customer_id, flight_id) VALUES (ticket_price,class1,seat1,customer_id1,flight_id1);
    UPDATE customer_bank_accounts
    SET balance = balance - ticket_price;
  END;

                                18. Update Trigger
                                ------------------
CREATE TRIGGER tr_on_change_flight_status
  BEFORE UPDATE ON flights FOR EACH ROW
  BEGIN
  DECLARE count_passengers INT;
    DECLARE origin1 VARCHAR(50);
    DECLARE destination1 VARCHAR(50);
    SET count_passengers := (SELECT COUNT(t.flight_id) FROM tickets AS t
                            JOIN flights AS f ON NEW.flight_id = f.flight_id AND f.flight_id = t.flight_id);
     SET origin1 := (SELECT a.airport_name FROM airports AS a
                  WHERE NEW.origin_airport_id = a.airport_id);
    SET  destination1 := (SELECT a.airport_name FROM airports AS a
       WHERE a.airport_id = NEW.destination_airport_id);
    IF (OLD.status LIKE 'Departing' OR OLD.status LIKE 'Delayed') THEN
  INSERT INTO arrived_flights (flight_id, arrival_time, origin, destination, passengers)
  VALUES (NEW.flight_id,NEW.arrival_time,origin1,destination1,count_passengers);
      END IF;
  END;

