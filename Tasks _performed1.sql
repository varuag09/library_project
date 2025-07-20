SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

-- Task 1. Create a New Book Record 
-- "('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic',6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn,book_title,category,rental_price,status,author,publisher)
VALUES('978-1-60129-456-2','To Kill a Mockingbird','Classic','6.00','yes','Harper Lee','J.B. Lippincott & Co.')
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Task 5  List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT 
	issued_emp_id,
	COUNT(issued_id) as total_book_issued
FROM issued_status
GROUP BY 1
HAVING COUNT(*)>1;

-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results 
-- each book and total book_issued_cnt**

CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(iss.issued_id) as issue_count
FROM books as b
JOIN issued_status as iss
ON b.isbn = iss.issued_book_isbn
GROUP BY b.isbn, b.book_title;

SELECT * FROM book_issued_cnt;

-- Task 7: Retrieve All Books in a Specific Category:

SELECT DISTINCT category FROM books;

SELECT * FROM books
WHERE category = 'History';

-- Task 8: Find Total Rental Income by Category:

SELECT b.category, SUM(b.rental_price), COUNT(iss.issued_id)
FROM books as b
JOIN issued_status as iss
ON b.isbn = iss.issued_book_isbn
GROUP BY b.category;

-- Task 9: List Members Who Registered in the last 180 Days:

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL'180 days';

INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C128','K. Kingston','145 Main Street','2025-06-09'),
('C129','M. Jordan','178 Main Street','2025-05-29')

-- Task 10: List the employees with Their Branch Manager's Name and their branch details:

SELECT
	e1.emp_id,
	e1.emp_name,
	e1.position,
	e1.salary,
	b.branch_id,
	b.manager_id,
	e2.emp_name as manager
FROM employees as e1
JOIN
branch as b
ON e1.branch_id = b.branch_id
JOIN
employees as e2
ON e2.emp_id = b.manager_id;

-- Task 11: Create a table of Books with Rental Price Above a Certain Threshold:

CREATE TABLE expensive_books AS
SELECT * FROM books
WHERE rental_price > 7.00;

SELECT * FROM expensive_books

-- Task 12: Retrieve the list of Books Not Yet Returned 

SELECT *
FROM issued_status as iss
LEFT JOIN
return_status as rs
ON iss.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;

-- Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period).
--Display the member's_id, member's name, book title, issue date, and days overdue.

SELECT *
FROM
	

