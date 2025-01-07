-- Create Database and Use It
CREATE DATABASE WorkerDB;
USE WorkerDB;

-- Create Worker Table
CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25) NOT NULL,
    LastName CHAR(25) NOT NULL,
    Salary INT NOT NULL,
    JoiningDate DATETIME NOT NULL,
    Department CHAR(25) NOT NULL
);

-- Procedure 1: Add a New Worker
DELIMITER $$
CREATE PROCEDURE AddWorker(
    IN p_Worker_Id INT,
    IN p_FirstName CHAR(25),
    IN p_LastName CHAR(25),
    IN p_Salary INT,
    IN p_JoiningDate DATETIME,
    IN p_Department CHAR(25)
)
BEGIN
    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END$$
DELIMITER ;

-- Procedure 2: Retrieve Worker Salary by ID
DELIMITER $$
CREATE PROCEDURE GetWorkerSalary(
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary
    FROM Worker
    WHERE Worker_Id = p_Worker_Id;
END$$
DELIMITER ;

-- Procedure 3: Update Worker Department by ID
DELIMITER $$
CREATE PROCEDURE UpdateWorkerDepartment(
    IN p_Worker_Id INT,
    IN p_Department CHAR(25)
)
BEGIN
    UPDATE Worker
    SET Department = p_Department
    WHERE Worker_Id = p_Worker_Id;
END$$
DELIMITER ;

-- Procedure 4: Count Workers in a Department
DELIMITER $$
CREATE PROCEDURE CountWorkersInDepartment(
    IN p_Department CHAR(25),
    OUT p_WorkerCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount
    FROM Worker
    WHERE Department = p_Department;
END$$
DELIMITER ;

-- Procedure 5: Calculate Average Salary in a Department
DELIMITER $$
CREATE PROCEDURE AvgSalaryInDepartment(
    IN p_Department CHAR(25),
    OUT p_AvgSalary FLOAT
)
BEGIN
    SELECT AVG(Salary) INTO p_AvgSalary
    FROM Worker
    WHERE Department = p_Department;
END$$
DELIMITER ;

-- Insert Sample Data
INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
VALUES
(1, 'John', 'Doe', 50000, '2025-01-01', 'HR'),
(2, 'Jane', 'Smith', 60000, '2024-06-15', 'Finance'),
(3, 'Mike', 'Brown', 55000, '2023-12-10', 'Finance'),
(4, 'Emily', 'Davis', 70000, '2022-08-22', 'HR'),
(5, 'Chris', 'Wilson', 48000, '2024-03-05', 'IT');

-- Example Calls for Testing

-- Add a New Worker
CALL AddWorker(6, 'Alice', 'Taylor', 52000, '2025-02-15', 'HR');

-- Retrieve Salary of Worker with ID 1
SET @p_Salary = 0;
CALL GetWorkerSalary(1, @p_Salary);
SELECT @p_Salary AS Salary;

-- Update Department of Worker with ID 3
CALL UpdateWorkerDepartment(3, 'IT');

-- Count Workers in the 'Finance' Department
SET @p_WorkerCount = 0;
CALL CountWorkersInDepartment('Finance', @p_WorkerCount);
SELECT @p_WorkerCount AS WorkerCount;

-- Calculate Average Salary in the 'HR' Department
SET @p_AvgSalary = 0;
CALL AvgSalaryInDepartment('HR', @p_AvgSalary);
SELECT @p_AvgSalary AS AvgSalary;
