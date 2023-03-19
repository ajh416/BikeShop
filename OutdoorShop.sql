-- Matthew O'Malley-Nichols
-- Adam Henry
-- Shane Ludwig
.headers on
.mode columns

-- Enables foreign key constraints
PRAGMA foreign_keys=on;

DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS SALES_HISTORY;
DROP TABLE IF EXISTS INVENTORY;
DROP TABLE IF EXISTS CUSTOMER;
DROP TABLE IF EXISTS ITEM;
DROP TABLE IF EXISTS SKI;
DROP TABLE IF EXISTS BIKE;
DROP TABLE IF EXISTS SNOWBOARD;
DROP TABLE IF EXISTS MAINTAINS;
DROP TABLE IF EXISTS RENTS;

--EMPLOYEE: Step 1, Step 4, Step 8D
-- Foreign key constraint for sid not in Create Table due to causing errors. Referencing Page 182 in Fundamentals of Database Design, we decided to put the constraint in an alter table statement.
CREATE TABLE IF NOT EXISTS EMPLOYEE(
  eid  INT  NOT NULL PRIMARY KEY,
  salary DECIMAL(10,2) CHECK (salary >= 0),
  sid  INT,
  fname VARCHAR(20),
  lname VARCHAR(20),
  sFlag BOOLEAN NOT NULL DEFAULT FALSE,
  location VARCHAR(20),
  mflag BOOLEAN NOT NULL DEFAULT FALSE,
  skill CHAR,
  FOREIGN KEY (sid) REFERENCES EMPLOYEE(eid),
  FOREIGN KEY (location) REFERENCES INVENTORY(location)
);
-- SALES_HISTORY: Step 2, Step 4
CREATE TABLE IF NOT EXISTS SALES_HISTORY (
  date  TIMESTAMP  NOT NULL PRIMARY KEY,
  eid  INT  NOT NULL,
  iid  INT  NOT NULL,
  FOREIGN KEY (eid) REFERENCES EMPLOYEE(eid),
  FOREIGN KEY (iid) REFERENCES ITEM(iid)
);
--INVENTORY: Step 1
CREATE TABLE IF NOT EXISTS INVENTORY (
  location  VARCHAR(20)  NOT NULL PRIMARY KEY
);
--CUSTOMER: Step 1
CREATE TABLE IF NOT EXISTS CUSTOMER(
  cid INT NOT NULL PRIMARY KEY,
  phone INT,
  email VARCHAR(64),
  fname VARCHAR(20),
  lname VARCHAR(20)
);
--ITEM: Step 1, Step 4
CREATE TABLE IF NOT EXISTS ITEM(
  iid INT NOT NULL PRIMARY KEY,
  type VARCHAR(20) NOT NULL,
  price DECIMAL(8, 2) CHECK (price >= 0),
  rating DECIMAL(8, 2) CHECK (rating >= 0 and rating <= 5),
  location VARCHAR(20) NOT NULL,
  eid INT,
  cid INT,
  FOREIGN KEY (location) REFERENCES INVENTORY(location),
  FOREIGN KEY (eid) REFERENCES EMPLOYEE(eid),
  FOREIGN KEY (cid) REFERENCES CUSTOMER(cid)
);
--SKI: Step 8A
CREATE TABLE IF NOT EXISTS SKI(
  iid INT NOT NULL PRIMARY KEY,
  tip_width INT CHECK (tip_width >= 0 and tip_width <= 999),
  waist_width int CHECK (waist_width >= 0 and waist_width <= 999),
  length INT CHECK (length >= 0 and length <= 999),
  FOREIGN KEY (iid) REFERENCES ITEM(iid)
);
--BIKE: Step 8A
CREATE TABLE IF NOT EXISTS BIKE(
  iid  INT  NOT NULL PRIMARY KEY,
  tire_size  DECIMAL(4, 2) CHECK (tire_size >= 0 and tire_size <= 99),
  front_suspension  VARCHAR(20),
  rear_suspension  VARCHAR(20),
  FOREIGN KEY (iid) REFERENCES ITEM(iid)
);
--SNOWBOARD: Step 8A
CREATE TABLE IF NOT EXISTS SNOWBOARD(
  iid INT NOT NULL PRIMARY KEY,
  length INT CHECK (length >= 0 and length <= 999),
  camber VARCHAR(10),
  FOREIGN KEY (iid) REFERENCES ITEM(iid)
);
--MAINTAINS: Step 5
CREATE TABLE IF NOT EXISTS MAINTAINS(
  iid INT NOT NULL,
  eid INT NOT NULL,
  date TIMESTAMP,
  PRIMARY KEY (iid,eid),
  FOREIGN KEY (iid) REFERENCES ITEM(iid),
  FOREIGN KEY (eid) REFERENCES EMPLOYEE(eid)
);
--RENTS: Step 4
CREATE TABLE IF NOT EXISTS RENTS(
  cid INT NOT NULL,
  iid INT NOT NULL PRIMARY KEY,
  start_rental TIMESTAMP,
  end_rental TIMESTAMP,
  FOREIGN KEY (cid) REFERENCES CUSTOMER(cid),
  FOREIGN KEY (iid) REFERENCES ITEM(iid)
);

-- Part 3: INSERT STATEMENTS FOR SQL TABLE

--INVENTORY
INSERT INTO INVENTORY (location) VALUES 
('New York'),
('Los Angeles'),
('Chicago'),
('San Franscisco'),
('Miami');

--CUSTOMER
INSERT INTO CUSTOMER (cid, phone, email, fname, lname) VALUES 
(1001, 1234567890, 'johndoe@gmail.com', 'Johnny', 'Doe'),
(1002, 2345678901, 'janesmith@yahoo.com', 'Jane', 'Smith'),
(1003, 3456789012, 'davidjones@hotmail.com', 'David', 'Jones'),
(1004, 2149834744, 'bobross@gmail.com', 'Bob', 'Ross'),
(1005, 8342737743, 'themanthemyth@gmail.com', 'Harper', 'Screw');

--EMPLOYEE
INSERT INTO EMPLOYEE (eid, salary, sid, fname, lname, sFlag, location, mflag, skill) VALUES
(101, 50000, NULL, 'Buggs', 'Bunny', true, 'New York', false, NULL),
(102, 45000, 101, 'Horatio', 'Smith', false, 'Los Angeles', true, 'B'),
(103, 60000, 101, 'Willy', 'Shakespeare', true, 'Chicago', false, NULL),
(104, 50000, 101, 'Mario', 'Crack', false, 'New York', true, 'C'),
(105, 45000, 101, 'Smelvin', 'Kelvin', false, 'Los Angeles', true, 'A');

--ITEM
INSERT INTO ITEM (iid, type, price, rating, location, eid, cid) VALUES 
(1001, 'Ski', 400, 4.5, 'New York', 101, 1001),
(1002, 'Ski', 300, 4.7, 'Los Angeles', 101, 1002),
(1003, 'Ski', 500, 4.2, 'Chicago', 101, 1003),
(1004, 'Ski', 700, 4.3, 'San Franscisco', 101, 1004),
(1005, 'Ski', 300, 4.1, 'Miami', 101, 1005),
(1006, 'Bike', 2050, 3.2, 'Los Angeles', 102, NULL),
(1007, 'Bike', 3050, 3.5, 'Chicago', 102, NULL),
(1008, 'Bike', 4050, 3.9, 'Los Angeles', 102, NULL),
(1009, 'Bike', 1050, 3.4, 'New York', 102, NULL),
(1010, 'Bike', 2250, 3.75, 'Los Angeles', 102, NULL),
(1011, 'Snowboard', 520, 4.4, 'Chicago', 103, NULL),
(1012, 'Snowboard', 420, 4.2, 'Miami', 103, NULL),
(1013, 'Snowboard', 320, 4.1, 'Los Angeles', 103, NULL),
(1014, 'Snowboard', 620, 4.7, 'New York', 103, NULL),
(1015, 'Snowboard', 720, 4.8, 'Miami', 103, NULL);

--SALES_HISTORY
INSERT INTO SALES_HISTORY (date, eid, iid) VALUES 
('2022-01-01 10:00:00', 101, 1001),
('2022-01-01 11:00:00', 102, 1002),
('2022-01-02 12:00:00', 103, 1003),
('2022-01-02 13:00:00', 103, 1003),
('2022-01-02 14:00:00', 103, 1003);

--SKI
INSERT INTO SKI (iid, tip_width, waist_width, length) VALUES 
(1001, 110, 80, 180),
(1002, 120, 85, 190),
(1003, 100, 75, 170),
(1004, 120, 85, 190),
(1005, 115, 80, 180);

--BIKE
INSERT INTO BIKE (iid, tire_size, front_suspension, rear_suspension) VALUES 
(1006, 29, 'Full', 'None'),
(1007, 27.5, 'Front', 'Rear'),
(1008, 26, 'None', 'None'),
(1009, 27.5, 'Front', 'Rear'),
(1010, 26, 'None', 'None');

--SNOWBOARD
INSERT INTO SNOWBOARD (iid, length, camber) VALUES 
(1011, 156, 'Rocker'),
(1012, 162, 'Camber'),
(1013, 158, 'Flat'),
(1014, 146, 'Rocker'),
(1015, 173, 'Banana');

--MAINTAINS
INSERT INTO MAINTAINS (iid, eid, date) VALUES 
(1001, 105, '2022-02-01 10:00:00'),
(1002, 105, '2022-02-02 11:00:00'),
(1003, 105, '2022-02-03 12:00:00'),
(1004, 105, '2022-02-03 12:00:00'),
(1005, 105, '2022-02-03 12:00:00'),
(1006, 104, '2022-02-01 10:00:00'),
(1007, 104, '2022-02-02 11:00:00'),
(1008, 104, '2022-02-03 14:00:00'),
(1009, 104, '2022-02-03 16:00:00'),
(1010, 104, '2022-02-03 11:00:00'),
(1011, 102, '2022-02-01 10:00:00'),
(1012, 102, '2022-02-02 11:00:00'),
(1013, 102, '2022-02-03 13:00:00'),
(1014, 102, '2022-02-03 14:00:00'),
(1015, 102, '2022-02-03 15:00:00');

--RENTS
INSERT INTO RENTS (cid, iid, start_rental, end_rental) VALUES 
(1001, 1001, '2022-03-01 10:00:00', '2022-03-03 10:00:00'),
(1002, 1002, '2022-03-02 11:00:00', '2022-03-03 10:00:00'),
(1003, 1003, '2022-03-02 11:00:00', '2022-03-03 10:00:00'),
(1004, 1004, '2022-03-02 11:00:00', '2022-03-03 10:00:00'),
(1005, 1005, '2022-03-02 11:00:00', '2022-03-03 10:00:00');


-- Part 4: SELECT STATEMENTS
SELECT * FROM EMPLOYEE LIMIT 5;
SELECT * FROM CUSTOMER LIMIT 5;
SELECT * FROM INVENTORY LIMIT 5;
SELECT * FROM SALES_HISTORY LIMIT 5;
SELECT * FROM ITEM LIMIT 5;
SELECT * FROM SKI LIMIT 5;
SELECT * FROM SNOWBOARD LIMIT 5;
SELECT * FROM BIKE LIMIT 5;
SELECT * FROM MAINTAINS LIMIT 5;
SELECT * FROM RENTS LIMIT 5;

-- Part 5: INTERESTING QUERIES -- RESULT SET IS SHOWN BELOW EACH QUERY
-- Retrieve the total sales made by an employee
SELECT SUM(price) as TOTAL_SALES FROM ITEM JOIN SALES_HISTORY ON ITEM.iid = SALES_HISTORY.iid WHERE SALES_HISTORY.eid = 101;
/*
TOTAL_SALES
-----------
400
*/
-- Retrieve the items maintained by an employee on a specific date.
SELECT ITEM.iid, ITEM.type, MAINTAINS.date FROM ITEM JOIN MAINTAINS ON ITEM.iid = MAINTAINS.iid WHERE MAINTAINS.eid = 104 AND MAINTAINS.date = '2022-02-03 11:00:00';
/*
iid   type  date               
----  ----  -------------------
1010  Bike  2022-02-03 11:00:00
*/
-- Retrieve all the employees who have sold an item priced above $100.
SELECT DISTINCT EMPLOYEE.fname, EMPLOYEE.lname FROM EMPLOYEE JOIN SALES_HISTORY ON EMPLOYEE.eid = SALES_HISTORY.eid JOIN ITEM ON ITEM.iid = SALES_HISTORY.iid WHERE ITEM.price > 100;
/*
fname    lname      
-------  -----------
Buggs    Bunny      
Horatio  Smith      
Willy    Shakespeare
*/
-- Retrieve the most rented item
SELECT ITEM.iid, ITEM.type FROM ITEM JOIN RENTS ON ITEM.iid = RENTS.iid GROUP BY ITEM.iid ORDER BY COUNT(*) DESC LIMIT 1;
/*
iid   type
----  ----
1001  Ski
*/
-- Retrieve the most bought item type
SELECT ITEM.type as ITEM_TYPE FROM ITEM GROUP BY ITEM.cid ORDER BY COUNT(*) LIMIT 1;
/*
ITEM_TYPE
---------
Ski 
*/
