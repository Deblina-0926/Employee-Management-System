# Employee Management System (EMS)

This *Employee Management System (EMS)* is a SQL-based project that allows for managing employee records, departments, attendance, performance reviews, and salary history. The system demonstrates the use of *relational database design, **SQL queries, and **data management*.

## Project Overview

The EMS stores the following information:

- *Employee Information*: Employee name, address, phone, job title, salary, etc.
- *Department Information*: Department name, department manager, and location.
- *Attendance Records*: Tracks daily hours worked for each employee.
- *Performance Reviews*: Stores performance ratings and review comments for each employee.
- *Salary History*: Tracks salary changes over time for each employee.

The project demonstrates fundamental SQL concepts such as table creation, relationships (foreign keys), and complex query operations.

## Features

- *Database Schema*:
  - Multiple tables to manage employees, departments, attendance, performance reviews, and salary history.
  - *Foreign key* relationships between tables to ensure data integrity.
  
- *SQL Queries*:
  - CRUD operations (Create, Read, Update, Delete).
  - Complex queries for generating reports such as average salary by department, total hours worked by employees, top performers, and more.

## Tables

- *Departments*: Stores department details like DepartmentID, DepartmentName, ManagerID, and Location.
- *Employees*: Stores employee details such as EmployeeID, Name, Address, Phone, DepartmentID, JobTitle, and Salary.
- *Attendance*: Tracks employee attendance with fields like AttendanceID, EmployeeID, Date, and HoursWorked.
- *PerformanceReviews*: Stores employee review details including ReviewID, EmployeeID, ReviewDate, Rating, and Comments.
- *SalaryHistory*: Stores salary changes over time with SalaryID, EmployeeID, OldSalary, NewSalary, and EffectiveDate.

## Getting Started

### Prerequisites

To run this project, you will need:

- *MySQL* or *PostgreSQL* database system (or any SQL database).
- A *SQL client tool* (like *MySQL Workbench, **SQL Server Management Studio, **phpMyAdmin, or **pgAdmin*) to run SQL scripts.

### Setup Instructions

1. *Clone the Repository*:
   Clone this repository to your local machine using the following command:
   bash
   git clone https://github.com/yourusername/Employee-Management-System-SQL.git
   

2. *Create the Database*:
   Open your SQL client and execute the following commands to create the database and use it:
   sql
   CREATE DATABASE EmployeeManagementSystem;
   USE EmployeeManagementSystem;
   

3. *Run the SQL Script*:
   Run the EMS_Project.sql file in your SQL client. This will create the tables and insert the sample data.

4. *Query the Data*:
   You can now run SQL queries to interact with the database. Here are a few example queries you can try:
   - *View all employees in the HR department*:
     sql
     SELECT e.Name, e.JobTitle, d.DepartmentName
     FROM Employees e
     JOIN Departments d ON e.DepartmentID = d.DepartmentID
     WHERE d.DepartmentName = 'HR';
     

   - *Get total hours worked by employees in May 2025*:
     sql
     SELECT e.Name, SUM(a.HoursWorked) AS TotalHours
     FROM Attendance a
     JOIN Employees e ON a.EmployeeID = e.EmployeeID
     WHERE MONTH(a.Date) = 5 AND YEAR(a.Date) = 2025
     GROUP BY e.Name;
     

5. *Modify the Data*:
   You can modify, delete, or insert new data into the database using appropriate *SQL commands*.

## Project Structure

- *EMS_Project.sql*: The SQL script containing all the commands to create tables, insert sample data, and run queries.
- *README.md*: This file, containing instructions and an overview of the project.
- *Sample Data*: The data inserted into the tables for testing purposes.

## Example Queries

- *Get All Employees in the IT Department*:
  sql
  SELECT e.Name, e.JobTitle, d.DepartmentName
  FROM Employees e
  JOIN Departments d ON e.DepartmentID = d.DepartmentID
  WHERE d.DepartmentName = 'IT';
  

- *Get Salary History for an Employee*:
  sql
  SELECT e.Name, s.OldSalary, s.NewSalary, s.EffectiveDate
  FROM SalaryHistory s
  JOIN Employees e ON s.EmployeeID = e.EmployeeID
  WHERE e.Name = 'John Doe';
  

## Future Enhancements

- *Leave Management*: Add the ability to track employee leave records.
- *Payroll Management*: Add payroll calculations and integrate with salary and attendance data.
- *Web Interface*: Develop a user-friendly web interface to interact with the database.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.