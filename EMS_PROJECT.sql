mysql> CREATE DATABASE EmployeeManagementSystem;
Query OK, 1 row affected (0.01 sec)

mysql> USE EmployeeManagementSystem;
Database changed
mysql> -- Departments Table
mysql> CREATE TABLE Departments (
    ->     DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    ->     DepartmentName VARCHAR(100),
    ->     ManagerID INT,
    ->     Location VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> -- Employees Table
mysql> CREATE TABLE Employees (
    ->     EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Name VARCHAR(100),
    ->     Address VARCHAR(255),
    ->     Phone VARCHAR(15),
    ->     Email VARCHAR(100),
    ->     DepartmentID INT,
    ->     JobTitle VARCHAR(100),
    ->     Salary DECIMAL(10, 2),
    ->     FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> -- Attendance Table
mysql> CREATE TABLE Attendance (
    ->     AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    ->     EmployeeID INT,
    ->     Date DATE,
    ->     HoursWorked DECIMAL(5, 2),
    ->     FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> -- Performance Reviews Table
mysql> CREATE TABLE PerformanceReviews (
    ->     ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    ->     EmployeeID INT,
    ->     ReviewDate DATE,
    ->     Rating INT,
    ->     Comments TEXT,
    ->     FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql>
mysql> -- Salary History Table
mysql> CREATE TABLE SalaryHistory (
    ->     SalaryID INT PRIMARY KEY AUTO_INCREMENT,
    ->     EmployeeID INT,
    ->     OldSalary DECIMAL(10, 2),
    ->     NewSalary DECIMAL(10, 2),
    ->     EffectiveDate DATE,
    ->     FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> -- Insert Departments
mysql> INSERT INTO Departments (DepartmentName, ManagerID, Location)
    -> VALUES ('HR', 1, 'New York'),
    ->        ('IT', 2, 'San Francisco'),
    ->        ('Marketing', 3, 'Chicago');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert Employees
mysql> INSERT INTO Employees (Name, Address, Phone, Email, DepartmentID, JobTitle, Salary)
    -> VALUES ('Alice Smith', '123 Main St, NY', '123-456-7890', 'alice@example.com', 1, 'HR Manager', 75000),
    ->        ('Bob Johnson', '456 Oak St, SF', '234-567-8901', 'bob@example.com', 2, 'Software Engineer', 95000),
    ->        ('Charlie Davis', '789 Pine St, CHI', '345-678-9012', 'charlie@example.com', 3, 'Marketing Specialist', 65000);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert Attendance
mysql> INSERT INTO Attendance (EmployeeID, Date, HoursWorked)
    -> VALUES (1, '2025-05-01', 8),
    ->        (2, '2025-05-01', 9),
    ->        (3, '2025-05-01', 7);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert Performance Reviews
mysql> INSERT INTO PerformanceReviews (EmployeeID, ReviewDate, Rating, Comments)
    -> VALUES (1, '2025-04-30', 4, 'Great leadership skills'),
    ->        (2, '2025-04-30', 5, 'Exceptional technical performance'),
    ->        (3, '2025-04-30', 3, 'Satisfactory work, room for improvement');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert Salary History
mysql> INSERT INTO SalaryHistory (EmployeeID, OldSalary, NewSalary, EffectiveDate)
    -> VALUES (1, 70000, 75000, '2025-05-01'),
    ->        (2, 90000, 95000, '2025-05-01'),
    ->        (3, 60000, 65000, '2025-05-01');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT e.Name, e.JobTitle, d.DepartmentName
    -> FROM Employees e
    -> JOIN Departments d ON e.DepartmentID = d.DepartmentID
    -> WHERE d.DepartmentName = 'HR';
+-------------+------------+----------------+
| Name        | JobTitle   | DepartmentName |
+-------------+------------+----------------+
| Alice Smith | HR Manager | HR             |
+-------------+------------+----------------+
1 row in set (0.01 sec)

mysql> SELECT e.Name, SUM(a.HoursWorked) AS TotalHours
    -> FROM Attendance a
    -> JOIN Employees e ON a.EmployeeID = e.EmployeeID
    -> WHERE MONTH(a.Date) = 5 AND YEAR(a.Date) = 2025
    -> GROUP BY e.Name;
+---------------+------------+
| Name          | TotalHours |
+---------------+------------+
| Alice Smith   |       8.00 |
| Bob Johnson   |       9.00 |
| Charlie Davis |       7.00 |
+---------------+------------+
3 rows in set (0.01 sec)

mysql> SELECT e.Name, s.OldSalary, s.NewSalary, s.EffectiveDate
    -> FROM SalaryHistory s
    -> JOIN Employees e ON s.EmployeeID = e.EmployeeID
    -> WHERE s.EffectiveDate > '2025-01-01';
+---------------+-----------+-----------+---------------+
| Name          | OldSalary | NewSalary | EffectiveDate |
+---------------+-----------+-----------+---------------+
| Alice Smith   |  70000.00 |  75000.00 | 2025-05-01    |
| Bob Johnson   |  90000.00 |  95000.00 | 2025-05-01    |
| Charlie Davis |  60000.00 |  65000.00 | 2025-05-01    |
+---------------+-----------+-----------+---------------+
3 rows in set (0.01 sec)

mysql> SELECT e.Name, p.Rating, p.Comments
    -> FROM PerformanceReviews p
    -> JOIN Employees e ON p.EmployeeID = e.EmployeeID
    -> WHERE p.Rating >= 4;
+-------------+--------+-----------------------------------+
| Name        | Rating | Comments                          |
+-------------+--------+-----------------------------------+
| Alice Smith |      4 | Great leadership skills           |
| Bob Johnson |      5 | Exceptional technical performance |
+-------------+--------+-----------------------------------+
2 rows in set (0.00 sec)

mysql> SELECT d.DepartmentName, AVG(e.Salary) AS AverageSalary
    -> FROM Employees e
    -> JOIN Departments d ON e.DepartmentID = d.DepartmentID
    -> GROUP BY d.DepartmentName;
+----------------+---------------+
| DepartmentName | AverageSalary |
+----------------+---------------+
| HR             |  75000.000000 |
| IT             |  95000.000000 |
| Marketing      |  65000.000000 |
+----------------+---------------+
3 rows in set (0.00 sec)

mysql>