-- ==========================================
--   DATABASE: ACADEMY
--   Contains Faculties, Departments, Groups, Teachers
--   Tasks 1–2 with queries according to the assignment
-- ==========================================

CREATE DATABASE Academy;
USE Academy;

-- ==========================================
-- 1. Faculties table
-- ==========================================
CREATE TABLE Faculties (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Dean NVARCHAR(255) NOT NULL CHECK (Dean <> '')
);

-- ==========================================
-- 2. Departments table
-- ==========================================
CREATE TABLE Departments (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Financing MONEY NOT NULL DEFAULT 0 CHECK (Financing >= 0),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (Name <> '')
);

-- ==========================================
-- 3. Groups table
-- ==========================================
CREATE TABLE Groups (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK (Name <> ''),
    Rating INT NOT NULL CHECK (Rating BETWEEN 0 AND 5),
    Year INT NOT NULL CHECK (Year BETWEEN 1 AND 5)
);

-- ==========================================
-- 4. Teachers table
-- ==========================================
CREATE TABLE Teachers (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    EmploymentDate DATE NOT NULL CHECK (EmploymentDate >= '1990-01-01'),
    IsAssistant BIT NOT NULL DEFAULT 0,
    IsProfessor BIT NOT NULL DEFAULT 0,
    Name NVARCHAR(255) NOT NULL CHECK (Name <> ''),
    Position NVARCHAR(255) NOT NULL CHECK (Position <> ''),
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(255) NOT NULL CHECK (Surname <> '')
);

-- ==========================================
-- EXAMPLE DATA
-- ==========================================
INSERT INTO Faculties (Name, Dean) VALUES
('Computer Science', 'Dr. John Smith'),
('Mathematics', 'Prof. Alice Brown');

INSERT INTO Departments (Financing, Name) VALUES
(12000, 'Software Development'),
(8000, 'Physics'),
(30000, 'Applied Mathematics');

INSERT INTO Groups (Name, Rating, Year) VALUES
('CS-51', 4, 5),
('CS-52', 3, 5),
('MATH-31', 5, 3);

INSERT INTO Teachers (EmploymentDate, IsAssistant, IsProfessor, Name, Position, Premium, Salary, Surname)
VALUES
('1998-03-12', 0, 1, 'Ivan', 'Professor', 200, 1200, 'Petrov'),
('2005-09-01', 1, 0, 'Anna', 'Assistant', 300, 500, 'Smirnova'),
('1999-11-23', 1, 0, 'Pavel', 'Assistant', 150, 400, 'Kuznetsov');

-- ==========================================
-- QUERIES (Задание 2)
-- ==========================================

-- 1) Таблица кафедр, поля в обратном порядке
SELECT Name, Financing, Id
FROM Departments;

-- 2) Названия групп и рейтинги (с указанием имени таблицы)
SELECT Groups.Name AS 'Groups.Name', Groups.Rating AS 'Groups.Rating'
FROM Groups;

-- 3) Фамилия, % ставки к надбавке и зарплате
SELECT 
    Surname,
    (Salary / Premium * 100) AS PercentToPremium,
    (Salary / (Salary + Premium) * 100) AS PercentToTotal
FROM Teachers;

-- 4) Факультеты в виде одной строки
SELECT CONCAT('The dean of faculty ', Name, ' is ', Dean, '.') AS FacultyInfo
FROM Faculties;

-- 5) Профессора со ставкой > 1050
SELECT Surname
FROM Teachers
WHERE IsProfessor = 1 AND Salary > 1050;

-- 6) Кафедры с финансированием < 11000 или > 25000
SELECT Name
FROM Departments
WHERE Financing < 11000 OR Financing > 25000;

-- 7) Факультеты кроме “Computer Science”
SELECT Name
FROM Faculties
WHERE Name <> 'Computer Science';

-- 8) Преподаватели, не профессора
SELECT Surname, Position
FROM Teachers
WHERE IsProfessor = 0;

-- 9) Ассистенты с надбавкой 160–550
SELECT Surname, Position, Salary, Premium
FROM Teachers
WHERE IsAssistant = 1 AND Premium BETWEEN 160 AND 550;

-- 10) Фамилии и ставки ассистентов
SELECT Surname, Salary
FROM Teachers
WHERE IsAssistant = 1;

-- 11) Преподаватели, принятые до 01.01.2000
SELECT Surname, Position
FROM Teachers
WHERE EmploymentDate < '2000-01-01';

-- 12) Кафедры, идущие до “Software Development” по алфавиту
SELECT Name AS 'Name of Department'
FROM Departments
WHERE Name < 'Software Development'
ORDER BY Name;

-- 13) Ассистенты с зарплатой ≤ 1200
SELECT Surname
FROM Teachers
WHERE IsAssistant = 1 AND (Salary + Premium) <= 1200;

-- 14) Группы 5-го курса с рейтингом 2–4
SELECT Name
FROM Groups
WHERE Year = 5 AND Rating BETWEEN 2 AND 4;

-- 15) Ассистенты со ставкой < 550 или надбавкой < 200
SELECT Surname
FROM Teachers
WHERE IsAssistant = 1 AND (Salary < 550 OR Premium < 200);
