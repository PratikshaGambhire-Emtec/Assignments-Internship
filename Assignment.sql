CREATE DATABASE Worksheet;
USE Worksheet;

CREATE TABLE Employee(
    Worker_ID INT IDENTITY PRIMARY KEY,
    First_Name VARCHAR(30),
    Last_Name VARCHAR(30),
    Salary FLOAT,
    Joining_Date DateTime,
    Department_Id INT
);

INSERT INTO Employee (
   First_Name,  Last_Name, Salary, Joining_Date, Department_Id) VALUES
 ('Monika', 'Arora', 100000, '20/02/2014  9:00:00 AM', 1),
('Niharika', 'Verma', 80000, '11/06/2014  9:00:00 AM', 2 ),
( 'Vishal', 'Singhal', 300000, '20/02/2014  9:00:00 AM', 1),
( 'Amitabh', 'Singh', 500000, '20/02/2014  9:00:00 AM', 2),
('Vivek', 'Bhati', 500000, '11/06/2014  9:00:00 AM', 2),
( 'Vipul', 'Diwan', 200000, '11/06/2014  9:00:00 AM', 3),
( 'Satish', 'Kumar', 75000, '20/01/2014  9:00:00 AM', 3),
( 'Geetika', 'Chauhan', 90000, '11/04/2014  9:00:00 AM', 2);

CREATE TABLE Department(
    FOREIGN KEY ( Department_Id)
		REFERENCES Employee(Worker_ID ),
    Department_Name VARCHAR(25)    
);

 CREATE TABLE Department(
     Department_Id INT,
      FOREIGN KEY (Department_Id ) 
      REFERENCES Employee( Worker_ID )
       ON DELETE CASCADE,
       Department_Name VARCHAR(25)  
      );

    INSERT INTo Department(Department_Id, Department_Name)  VALUES
    (1, 'HR' ),
    (2, 'Admin'),
    (3, 'Account')


CREATE TABLE Bonus (
	WORKER_REF_ID INT,
    BONUS_DATE VARCHAR(50),
	BONUS_AMOUNT INT,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Employee(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_DATE,  BONUS_AMOUNT) VALUES
		(1, '20/02/2016  12:00:00 AM', 5000 ),
		(2, '11/06/2016  12:00:00 AM', 3000 ),
		(3, '20/02/2016  12:00:00 AM', 4000),
		(1, '20/02/2016  12:00:00 AM', 4500 ),
		(2, '11/06/2016  12:00:00 AM', 3500 );

CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM VARCHAR(50),
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Employee(WORKER_ID)
        ON DELETE CASCADE
);


INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (1, 'Manager', '20/02/2016  12:00:00 AM'),
 (2, 'Executive', '11/06/2016  12:00:00 AM'),
 (8, 'Executive', '11/06/2016  12:00:00 AM'),
 (5, 'Manager', '11/06/2016  12:00:00 AM'),
 (4, 'Asst. Manager', '11/06/2016  12:00:00 AM'),
 (7, 'Executive', '11/06/2016  12:00:00 AM'),
 (6, 'Lead', '11/06/2016  12:00:00 AM'),
 (3, 'Lead', '11/06/2016  12:00:00 AM');

 SELECT * FROM Employee;
 SELECT * FROM Department;
    SELECT * FROM Bonus;
    SELECT * FROM Title;


--Add a default constraint to insert Current DateTime on Joining Date column of Worker table
ALTER TABLE Employee ADD CONSTRAINT DF_Employee DEFAULT GETDATE() FOR Joining_Date

--Update Satish Kumar & Geetika Chauhan salary to increase by 20,000 in worker table.
UPDATE Employee SET Salary = Salary + 20000  WHERE Worker_ID=7
   
UPDATE Employee SET Salary = Salary + 20000  WHERE Worker_ID=8


-- Display details of all the Workers and sort the result by <FIRST_NAME> (Exclude Department_ID)
 SELECT Worker_ID, First_Name, Last_Name, Salary, Joining_Date
 FROM Employee
 ORDER BY  First_Name;

--Display details of all the Workers and sort the result by <FIRST_NAME> & <SALARY> (Exclude Department_ID)
SELECT Worker_ID, First_Name, Last_Name, Salary, Joining_Date
 FROM Employee
 ORDER BY  First_Name , Salary;

--Select all the Workers whose salary is greater than 300000
SELECT First_Name
FROM Employee
WHERE Salary>300000;

--Select all the Workers who have joined after 31st May 2014(Exclude Department_ID)
-- SELECT Worker_ID, First_Name, Last_Name, Salary, Joining_Date
-- FROM Employee
-- WHERE SUBSTRING(CONVERT(varchar, Joining_Date,100),31,5)='May'

--  SELECT Worker_ID, First_Name, Last_Name, Salary, Joining_Date
--  FROM Employee
--  Joining_Date >= '05/31/2014';

-- Select details of all the Workers and their Department
SELECT  *
FROM Employee
FULL JOIN Department
ON Employee.Department_Id = Department.Department_Id;

--Select details of all the Workers. Calculate Salary based on Bonus <Total Salary> = (Salary + Bonus)
select
    First_Name, Salary, BONUS_AMOUNT,
    (Salary + BONUS_AMOUNT) as "Total_salary" 
from Employee, Bonus;

--Select details of all the Workers and their Title
SELECT * FROM Employee
UNION ALL
SELECT * FROM Title

--Calculate sum of Salary for each Department
SELECT Department_Id, SUM(Salary) FROM Employee GROUP BY Department_Id;

--Select only those Departments where sum of Salary is greater than 500000
SELECT Department_Id, SUM(Salary) FROM Employee GROUP BY Department_Id
WHERE SUM(Salary)>500000;