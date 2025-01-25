CREATE DATABASE IF NOT EXISTS hstl;
USE hstl;
CREATE TABLE IF NOT EXISTS Resident ( 
    ID INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(255) NOT NULL, 
    DateOfBirth DATE NOT NULL, 
    Age INT, 
    Gender ENUM('male', 'female', 'others') NOT NULL, 
    ContactNumber VARCHAR(20) NOT NULL, 
    EmailID VARCHAR(255), 
    UNIQUE (ID) 
); -- Insert sample data into Resident table 
INSERT INTO Resident (Name, DateOfBirth, Age, Gender, ContactNumber, EmailID) VALUES 
('John Doe', '1995-05-15', 29, 'male', '1234567890', 'john.doe@example.com'), 
('Jane Smith', '1998-09-20', 26, 'female', '9876543210', 'jane.smith@example.com'), 
('Alice Johnson', '1990-12-10', 31, 'female', '5555555555', 'alice.johnson@example.com'), 
('Bob Brown', '1993-07-25', 28, 'male', '9999999999', 'bob.brown@example.com'); 
CREATE TABLE IF NOT EXISTS Guardian ( 
    Resident_ID INT, 
    Name VARCHAR(255) NOT NULL, 
    Relation VARCHAR(100) NOT NULL, 
    ContactNumber VARCHAR(20) NOT NULL, 
    EmailID VARCHAR(255), 
    Address VARCHAR(255), 
    FOREIGN KEY (Resident_ID) REFERENCES Resident(ID) 
); -- Insert sample data into Guardian table 
INSERT INTO Guardian (Resident_ID, Name, Relation, ContactNumber, EmailID, Address) 
VALUES  
(1, 'Michael Doe', 'Father', '1111111111', 'michael.doe@example.com', '123 Main St'), 
(2, 'Emily Smith', 'Mother', '2222222222', 'emily.smith@example.com', '456 Oak St'), 
(3, 'Jack Johnson', 'Father', '3333333333', 'jack.johnson@example.com', '789 Elm St'), 
(4, 'Sarah Brown', 'Mother', '4444444444', 'sarah.brown@example.com', '567 Pine St');
  CREATE TABLE IF NOT EXISTS Rent ( 
  Resident_ID INT, 
    Plan ENUM('annually', 'half-yearly', 'quarterly', 'monthly') NOT NULL, 
    Amount DECIMAL(10, 2), 
    Payment_Date DATE, 
    Payment_Mode ENUM('Online', 'Offline') NOT NULL, 
    FOREIGN KEY (Resident_ID) REFERENCES Resident(ID) 
); -- Insert sample data into Rent table 
INSERT INTO Rent (Resident_ID, Plan, Amount, Payment_Date, Payment_Mode) VALUES  
(1, 'annually', 12000.00, '2024-01-01', 'Online'), 
(2, 'monthly', 1000.00, '2024-05-01', 'Offline'), 
(3, 'half-yearly', 6000.00, '2024-04-01', 'Online'), 
(4, 'quarterly', 3000.00, '2024-07-01', 'Offline'); 
CREATE TABLE IF NOT EXISTS Room ( 
    Resident_ID INT, 
    Room_Number INT CHECK (Room_Number >= 1 AND Room_Number <= 5), 
    Floor ENUM('First', 'Second', 'Third', 'Fourth'), 
    Block VARCHAR(20), 
    FOREIGN KEY (Resident_ID) REFERENCES Resident(ID) 
); -- Insert sample data into Room table 
INSERT INTO Room (Resident_ID, Room_Number, Floor, Block) VALUES  
(1, 1, 'First', 'A'), 
(2, 2, 'Second', 'B'), 
(3, 3, 'Third', 'C'), 
(4, 4, 'Fourth', 'D');
CREATE TABLE IF NOT EXISTS Work ( 
    Resident_ID INT, 
    Company_Name VARCHAR(255) NOT NULL, 
    Company_Address VARCHAR(255), 
    Company_Number VARCHAR(20), 
    Designation ENUM('student', 'employee') NOT NULL, 
    FOREIGN KEY (Resident_ID) REFERENCES Resident(ID) );
    -- Insert sample data into Work table 
INSERT INTO Work (Resident_ID, Company_Name, Company_Address, Company_Number, Designation) VALUES  
(1, 'ABC Corporation', '123 Broadway', '3333333333', 'employee'), 
(2, 'XYZ University', '456 Maple St', '4444444444', 'student'), 
(4, 'LMN University', '101 Oak St', '5555555555', 'student'),
(5, 'PQR Corporation', '789 Pine St', 6666666666, 'employee');
 
UPDATE Rent 
SET Plan = 'annually', 
    Amount = 15000.00, 
    Payment_Date = '2025-01-01', 
    Payment_Mode = 'Online' 
WHERE Resident_ID = 1;
-- Select all records from the Resident table
SELECT * FROM Resident;

-- Select all records from the Guardian table
SELECT * FROM Guardian;

-- Select all records from the Rent table
SELECT * FROM Rent;

-- Select all records from the Room table
SELECT * FROM Room;

-- Select all records from the Work table
SELECT * FROM Work;


SELECT Name, Age FROM Resident;

SELECT SUM(Amount) AS Total_Amount_Paid
FROM Rent;

SELECT Name, ContactNumber FROM Guardian;

SELECT r.Name, w.Designation 
FROM Resident r 
JOIN Work w ON r.ID = w.Resident_ID;

SELECT Name, Gender
FROM Resident
WHERE Age > 26;

CREATE VIEW ResidentDetails AS
SELECT Name, Age, Gender, ContactNumber
FROM Resident;
select * from ResidentDetails;
CREATE VIEW GuardianContacts AS
SELECT Name, Relation, ContactNumber
FROM Guardian;
select * from GuardianContacts;

CREATE VIEW RentSummary AS
SELECT r.Resident_ID, rs.Name, r.Plan, r.Payment_Date
FROM Rent r
JOIN Resident rs ON r.Resident_ID = rs.ID;
select * from RentSummary;
CREATE VIEW OccupiedRooms AS
SELECT r.Room_Number, r.Floor, rs.Name AS Resident_Name
FROM Room r
JOIN Resident rs ON r.Resident_ID = rs.ID;
select * from OccupiedRooms;
CREATE VIEW WorkDetails AS
SELECT w.Resident_ID, w.Company_Name, w.Company_Address, w.Designation
FROM Work w
JOIN Resident rs ON w.Resident_ID = rs.ID;
select * from WorkDetails;
