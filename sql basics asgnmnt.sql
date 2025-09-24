# 1. Create a table called employees with the following structure? : emp_id (integer, should not be NULL and should be a primary key)Q : emp_name (text, should not be NULL)Q : age (integer, should have a check constraint to ensure the age is at least 18)Q : email (text, should be unique for each employee)Q : salary (decimal, with a default value of 30,000). Write the SQL query to create the above table with all constraints.

CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY NOT NULL,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL DEFAULT 30000
);

#2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.

   /* Constraints are rules enforced on data within a database to ensure its accuracy, consistency, and reliability, collectively known as data integrity. They prevent invalid data from being entered or modified, thereby maintaining the quality and trustworthiness of the information stored.

How Constraints Maintain Data Integrity:

Preventing Invalid Data: Constraints define permissible values and formats for data, rejecting any input that violates these rules. This prevents errors and inconsistencies from being introduced into the database.

Enforcing Relationships: Constraints can establish and maintain relationships between different tables, ensuring that related data remains consistent across the database.

Ensuring Uniqueness: Certain constraints guarantee that specific data values are unique, preventing duplicate entries that could lead to ambiguity or incorrect analysis.

Mandating Data Presence: Constraints can ensure that critical data fields are never left empty, guaranteeing the completeness of records.

Common Types of Constraints:

PRIMARY KEY: Uniquely identifies each record in a table. It implicitly enforces NOT NULL and UNIQUE constraints.
    
    CREATE TABLE Students (
        StudentID INT PRIMARY KEY,
        Name VARCHAR(255)
    );

FOREIGN KEY: Establishes a link between data in two tables, ensuring referential integrity. It dictates that values in the foreign key column must exist in the primary key column of the referenced table.

     CREATE TABLE Courses (
        CourseID INT PRIMARY KEY,
        CourseName VARCHAR(255),
        InstructorID INT,
        FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
    );

UNIQUE: Ensures that all values in a column or a set of columns are distinct.   

    CREATE TABLE Employees (
        EmployeeID INT PRIMARY KEY,
        Email VARCHAR(255) UNIQUE
    );

NOT NULL: Ensures that a column cannot contain NULL values, meaning it must always have a value.

    CREATE TABLE Products (
        ProductID INT PRIMARY KEY,
        ProductName VARCHAR(255) NOT NULL
    );

CHECK: Enforces a specific condition that all values in a column must satisfy.

    CREATE TABLE Orders (
        OrderID INT PRIMARY KEY,
        Quantity INT CHECK (Quantity > 0)
    );

DEFAULT: Provides a default value for a column if no value is explicitly specified during insertion.

    CREATE TABLE Users (
        UserID INT PRIMARY KEY,
        Status VARCHAR(50) DEFAULT 'Active'
    );

#3. Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.  

   -> You would apply a NOT NULL constraint to ensure a column always has a value, enforcing data integrity for mandatory fields like a customer's email address. A primary key cannot contain NULL values because its fundamental purpose is to uniquely identify each row; a NULL identifier would be ambiguous and defeat the purpose of the key. Database systems enforce this by implicitly making primary key columns NOT NULL.

Why apply the NOT NULL constraint to a column?

Enforce Mandatory Fields:
It ensures that users or applications always provide a value for that column when inserting or updating data, preventing incomplete records.

Improve Data Quality:
By preventing unknown or missing values in critical columns, you maintain a higher standard of data quality and reliability.

Enhance Query Performance:
In some cases, adding a NOT NULL constraint can help the database optimize queries, especially when joining tables, as it provides a strong guarantee that the column will not contain NULLs, reducing the rows that need to be processed.

Can a primary key contain NULL values?

No, a primary key cannot contain NULL values.

Unique Identification:
A primary key's sole purpose is to uniquely identify each record within a table. A NULL value signifies an unknown or missing identifier, which would make it impossible to reliably identify a specific row.

Entity Integrity:
The concept of entity integrity in database design dictates that a primary key must have a unique, non-null value to serve its identifying role correctly.

Implicit NOT NULL:
When you declare a column or set of columns as a primary key, most relational database systems automatically apply the NOT NULL constraint to it, even if you don't explicitly state it.

#4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.

   -> Adding and removing constraints on an existing table in SQL involves using the ALTER TABLE statement.

Adding a Constraint:
Identify the constraint type and target column(s): Determine whether you need a PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, or NOT NULL constraint and which column(s) it will apply to.

Use the ALTER TABLE ADD CONSTRAINT command: The general syntax is:
Code

    ALTER TABLE table_name
    ADD CONSTRAINT constraint_name constraint_definition;

table_name: The name of the table to modify.

constraint_name: A unique name for the new constraint. This is optional for NOT NULL but recommended for others for easier management.

constraint_definition: The specific type of constraint and the column(s) it applies to.

Example (Adding a UNIQUE constraint):
To add a unique constraint named UQ_Email to the Email column of the Customers table:
Code

    ALTER TABLE Customers
    ADD CONSTRAINT UQ_Email UNIQUE (Email);

Removing a Constraint:
Identify the constraint to remove: You typically need the name of the constraint. If it's a NOT NULL constraint, you might need to modify the column definition directly.

Use the ALTER TABLE DROP CONSTRAINT command: The general syntax is:
Code

    ALTER TABLE table_name
    DROP CONSTRAINT constraint_name;

table_name: The name of the table from which to remove the constraint.

constraint_name: The name of the constraint to be removed.

Example (Removing a UNIQUE constraint):
To remove the unique constraint named UQ_Email from the Customers table:
Code

    ALTER TABLE Customers
    DROP CONSTRAINT UQ_Email;

Example (Removing a NOT NULL constraint):
To remove a NOT NULL constraint from the PhoneNumber column in the Customers table (assuming it was added directly to the column and not named as a table constraint):
Code

    ALTER TABLE Customers
    ALTER COLUMN PhoneNumber NULL;
(Note: The exact syntax for removing NOT NULL might vary slightly between database systems, but ALTER COLUMN column_name NULL is common.)

#5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.

   -> Attempting to insert, update, or delete data in a way that violates database constraints has several consequences, primarily aimed at maintaining data integrity and consistency.

Consequences of Constraint Violations:

Operation Rejection: The most common consequence is the rejection of the entire DML (Data Manipulation Language) operation (INSERT, UPDATE, or DELETE). The database management system (DBMS) prevents the modification from occurring, ensuring that invalid data is not introduced or existing valid data is not corrupted.

Error Messages: The DBMS will typically return an error message to the user or application, indicating the specific constraint that was violated and often providing details about the nature of the violation (e.g., duplicate key, foreign key violation, check constraint violation).

Transaction Rollback: If the DML operation is part of a larger transaction, the entire transaction might be rolled back, undoing all changes made within that transaction to maintain atomicity and consistency.

Application-Level Handling: Applications interacting with the database must be designed to handle these error messages gracefully. This might involve displaying user-friendly error messages, logging the error, or prompting the user to correct the data.

Example Error Message (PostgreSQL Foreign Key Violation):
Consider a scenario where you have two tables, Departments with department_id as a primary key, and Employees with department_id as a foreign key referencing Departments. If you try to insert an employee with a department_id that does not exist in the Departments table, you might receive an error message similar to this:

Code

ERROR: insert or update on table "employees" violates foreign key constraint "employees_department_id_fkey"

DETAIL: Key (department_id)=(999) is not present in table "departments".

This error message clearly indicates that the employees_department_id_fkey foreign key constraint on the employees table was violated because the department_id value of 999 does not exist in the departments table.

#6. You created a products table without constraints as follows:
CREATE TABLE products (
    product_id INT,
        product_name VARCHAR(50),
            price DECIMAL(10, 2));
Now, you realise that?
: The product_id should be a primary key.
: The price should have a default value of 50.00       

ALTER TABLE products
ADD PRIMARY KEY (product_id),
MODIFY price DECIMAL(10,2) DEFAULT 50.00;

#7. You have two tables:
Student:
| student\_id | student\_name | class\_id |
| ----------- | ------------- | --------- |
| 1           | Alice         | 101       |
| 2           | Bob           | 102       |
| 3           | Charlie       | 101       |
class:
| class\_id | class\_name |
| --------- | ----------- |
| 101       | Math        |
| 102       | Science     |
| 103		| History     |
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

 SELECT 
    s.student_name,
    c.class_name
FROM 
    Student s
INNER JOIN 
    class c ON s.class_id = c.class_id;
    
8. Consider the following three tables:
orders:
| order_id    | order_date    | customer_id |
| ----------- | ------------- | ----------|
| 1           | 2024-01-01        | 101       |
| 2           | 2024-01-03        | 102       |
customers:
| customer_id | customer_name |
| --------- | ----------- |
| 101       | Alice       |
| 102       | Bob         |
products:
| product_id | product_name | order_id |
| ----------- | ------------- | --------- |
| 1           | Laptop         | 1         |
| 2           | phone          | Null      |

Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are 
listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN).

SELECT 
    p.order_id,
    c.customer_name,
    p.product_name
FROM 
    products p
LEFT JOIN 
    orders o ON p.order_id = o.order_id
INNER JOIN 
    customers c ON o.customer_id = c.customer_id;

9. Given the following tables:
Sales:
| sale_id     | product_id    | amount    |
| ----------- | ------------- | --------- |
| 1           | 101           | 500       |
| 2           | 102           | 300       |
| 3           | 101           | 700       |
products:
| product_id | product_name   | 
| ----------- | ------------- |
| 101           | Laptop        | 
| 102           | phone         | 
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
SELECT 
    p.product_name,
    SUM(s.amount) AS total_sales
FROM 
    Sales s
INNER JOIN 
    Products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name;

#10. You are given three tables:
orders:
| order_id    | order_date    | customer_id |
| ----------- | ------------- | ----------|
| 1           | 2024-01-01        | 1      |
| 2           | 2024-01-05        | 2      |
customers:
| customer_id | customer_name |
| --------- | ----------- |
| 1       | Alice       |
| 2       | Bob         |
order_details:
| order_id    | product_id    | quantity |
| ----------- | ------------- | ----------|
| 1           | 101           | 2     |
| 1           | 102           | 1     |
| 2           | 101           | 3     |
Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
customer using an INNER JOIN between all three tables.    
SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    orders o
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
INNER JOIN 
    order_details od ON o.order_id = od.order_id;
    
SQL COMMANDS:

1.Identify the primary keys and foreign keys in maven movies db. Discuss the differences    
| Table            | Primary Key(s)                     | Foreign Key(s)                                                                                                                      |
| ---------------- | ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **actor**        | `actor_id`                         | —                                                                                                                                   |
| **actor\_award** | `actor_award_id`                   | `actor_id` → `actor.actor_id` ([cdips.org][1])                                                                                      |
| **address**      | `address_id`                       | `city_id` → `city.city_id` ([cdips.org][1])                                                                                         |
| **city**         | `city_id`                          | `country_id` → `country.country_id` ([cdips.org][1])                                                                                |
| **country**      | `country_id`                       | —                                                                                                                                   |
| **category**     | `category_id`                      | —                                                                                                                                   |
| **customer**     | `customer_id`                      | `store_id` → `store.store_id`, `address_id` → `address.address_id` ([cdips.org][1])                                                 |
| **film**         | `film_id`                          | — (for that table’s own) but other tables refer to it; columns like `rating` etc are attributes, not foreign keys. ([cdips.org][1]) |
| **film\_actor**  | composite: (`film_id`, `actor_id`) | `film_id` → `film.film_id`, `actor_id` → `actor.actor_id` ([cdips.org][1])                                                          |
| **staff**        | `staff_id`                         | `store_id` → `store.store_id`, `address_id` → `address.address_id` ([cdips.org][1])                                                 |
| **store**        | `store_id`                         | `manager_staff_id` → `staff.staff_id`, `address_id` → `address.address_id` ([cdips.org][1])                                         |

[1]: https://cdips.org/certifications/sql-certification/lessons/understanding-the-maven-movies-dataset/?utm_source=chatgpt.com "Understanding the Maven Movies Dataset – cdips.org"

2.List all details of actors

SELECT * FROM actor;

3. List all customer information from DB.

select * from customer;

4. List different countries.

select distinct country from country;

5. Display all active customers.

select * from customer where active = 1;

6. List of all rental IDs for customer with ID 1.

select rental_id from rental where customer_id = 1;

7. Display all the films whose rental duration is greater than 5 .

select * from film where rental_duration > 5;

8.List the total number of films whose replacement cost is greater than $15 and less than $20.

select * from film where replacement_cost between 15 and 20;

9. Display the count of unique first names of actors.

SELECT COUNT(DISTINCT first_name) AS unique_first_name_count
FROM actor;

10. Display the first 10 records from the customer table .

SELECT * FROM customer
LIMIT 10;

11.Display the first 3 records from the customer table whose first name starts with ‘b’.

SELECT *
FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

12. Display the names of the first 5 movies which are rated as ‘G’.

SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;

13. Find all customers whose first name starts with "a".

SELECT *
FROM customer
WHERE first_name LIKE 'a%';

14.Find all customers whose first name ends with "a".

SELECT *
FROM customer
WHERE first_name LIKE '%a';

15.Display the list of first 4 cities which start and end with ‘a’ .

SELECT city
FROM city
WHERE city LIKE 'a%' AND city LIKE '%a'
LIMIT 4;

16. Find all customers whose first name have "NI" in any position.

SELECT *
FROM customer
WHERE first_name LIKE '%NI%';

17. Find all customers whose first name have "r" in the second position .

SELECT *
FROM customer
WHERE first_name LIKE '_r%';

18. Find all customers whose first name starts with "a" and are at least 5 characters in length.

SELECT *
FROM customer
WHERE first_name LIKE 'a%'
  AND LENGTH(first_name) >= 5;
 
 19. Find all customers whose first name starts with "a" and ends with "o".
 
 SELECT *
FROM customer
WHERE first_name LIKE 'a%o';

20. Get the films with pg and pg-13 rating using IN operator.

SELECT *
FROM film
WHERE rating IN ('PG', 'PG-13');

21.Get the films with length between 50 to 100 using between operator.

SELECT *
FROM film
WHERE length BETWEEN 50 AND 100;

22.Get the top 50 actors using limit operator.

SELECT *
FROM actor
ORDER BY actor_name
LIMIT 50;

23.Get the distinct film ids from inventory table.

SELECT DISTINCT film_id
FROM inventory;

Functions:
Basic Aggregate Functions:

Question 1: Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.

SELECT COUNT(*) AS total_rentals FROM rental;

Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.

SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration
FROM rental;

String Functions:
Question 3: Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function.

SELECT UPPER(first_name) AS first_name_upper,
       UPPER(last_name) AS last_name_upper
FROM sakilacustomer;

Question 4: Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.

SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

GROUP BY:

Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.

SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

Question 6: Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.

SELECT store_id, SUM(revenue) AS total_revenue
FROM sales
GROUP BY store_id;

Question 7: Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.

SELECT 
    c.name AS category,
    COUNT(r.rental_id) AS total_rentals
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name
ORDER BY 
    total_rentals DESC;

Question 8: Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT 
    l.name AS language,
    AVG(f.rental_rate) AS average_rental_rate
FROM 
    film f
JOIN 
    language l ON f.language_id = l.language_id
GROUP BY 
    l.name;

Joins:

Questions 9 - Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.
SELECT 
    film.title AS movie_title,
    customer.first_name,
    customer.last_name
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
JOIN 
    customer ON rental.customer_id = customer.customer_id;

Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

Question 11: Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.

SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS total_spent
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_spent DESC;

Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.

SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    f.title AS film_title
FROM 
    customer c
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
WHERE 
    ci.city = 'London'
GROUP BY 
    customer_name, f.title
ORDER BY 
    customer_name, f.title;

Advanced Joins and GROUP BY:

Question 13: Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    rental_count DESC
LIMIT 5;

Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
WHERE
    i.store_id IN (1, 2)
GROUP BY
    c.customer_id, c.first_name, c.last_name
HAVING
    COUNT(DISTINCT i.store_id) = 2;

Windows Function:

1. Rank the customers based on the total amount they've spent on rentals.

SELECT
    customer_id,
    SUM(amount_spent) AS total_spent,
    RANK() OVER (ORDER BY SUM(amount_spent) DESC) AS rank
FROM
    rentals
GROUP BY
    customer_id
ORDER BY
    rank;

2. Calculate the cumulative revenue generated by each film over time.

SELECT
  film_id,
  film_title,
  revenue_date,
  revenue,
  SUM(revenue) OVER (PARTITION BY film_id ORDER BY revenue_date) AS cumulative_revenue
FROM
  film_revenue
ORDER BY
  film_id,
  revenue_date;

3. Determine the average rental duration for each film, considering films with similar lengths.

SELECT
    FLOOR(f.length / 10) * 10 AS length_bucket_start,
    FLOOR(f.length / 10) * 10 + 9 AS length_bucket_end,
    f.film_id,
    f.title,
    AVG(r.rental_duration) AS avg_rental_duration
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY
    length_bucket_start,
    length_bucket_end,
    f.film_id,
    f.title
ORDER BY
    length_bucket_start,
    f.film_id;

4. Identify the top 3 films in each category based on their rental counts.

WITH rental_counts AS (
    SELECT
        c.name AS category_name,
        f.film_id,
        f.title,
        COUNT(r.rental_id) AS rental_count
    FROM
        category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name,
        f.film_id,
        f.title
),
ranked_films AS (
    SELECT
        category_name,
        film_id,
        title,
        rental_count,
        ROW_NUMBER() OVER (PARTITION BY category_name ORDER BY rental_count DESC) AS rank
    FROM
        rental_counts
)
SELECT
    category_name,
    film_id,
    title,
    rental_count
FROM
    ranked_films
WHERE
    rank <= 3
ORDER BY
    category_name,
    rental_count DESC;

5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

SELECT
    customer_id,
    COUNT(rental_id) AS total_rentals,
    AVG(total_rentals) OVER () AS avg_rentals,
    COUNT(rental_id) - AVG(COUNT(rental_id)) OVER () AS rental_difference
FROM rentals
GROUP BY customer_id;

6. Find the monthly revenue trend for the entire rental store over time.

SELECT
  DATE_FORMAT(rental_date, '%Y-%m') AS year_month,
  SUM(revenue) AS total_revenue
FROM rentals
GROUP BY year_month
ORDER BY year_month;

7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

WITH CustomerTotals AS (
    SELECT
        customer_id,
        SUM(amount_spent) AS total_spent
    FROM rentals
    GROUP BY customer_id
),
Percentiles AS (
    SELECT
        total_spent,
        PERCENTILE_CONT(0.8) WITHIN GROUP (ORDER BY total_spent) OVER () AS percentile_80
    FROM CustomerTotals
)
SELECT
    customer_id,
    total_spent
FROM CustomerTotals
WHERE total_spent >= (SELECT DISTINCT percentile_80 FROM Percentiles);

8. Calculate the running total of rentals per category, ordered by rental count.

SELECT
  category,
  rental_count,
  SUM(rental_count) OVER (ORDER BY rental_count) AS running_total
FROM rentals
ORDER BY rental_count;

9. Find the films that have been rented less than the average rental count for their respective categories.

WITH FilmRentalCounts AS (
    SELECT
        f.film_id,
        f.title,
        c.category_id,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY f.film_id, f.title, c.category_id, c.name
),

CategoryAverageRentals AS (
    SELECT
        category_id,
        AVG(rental_count) AS avg_rental_count
    FROM FilmRentalCounts
    GROUP BY category_id
)

SELECT
    frc.film_id,
    frc.title,
    frc.category_name,
    frc.rental_count,
    car.avg_rental_count
FROM FilmRentalCounts frc
JOIN CategoryAverageRentals car ON frc.category_id = car.category_id
WHERE frc.rental_count < car.avg_rental_count
ORDER BY frc.category_name, frc.rental_count;

10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT 
    DATE_FORMAT(date_column, '%Y-%m') AS month,  -- Format the date to Year-Month
    SUM(revenue) AS total_revenue
FROM 
    sales_table
GROUP BY 
    month
ORDER BY 
    total_revenue DESC
LIMIT 5;

Normalisation & CTE: 

1. First Normal Form (1NF):
 a. Identify a table in the Sakila database that violates 1NF. Explain how you  would normalize it to achieve 1NF.

-- Step 1: Create a new table for phone numbers
CREATE TABLE customer_phone (
    customer_id SMALLINT UNSIGNED NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (customer_id, phone_number),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

-- Step 2: Insert normalized data
INSERT INTO customer_phone (customer_id, phone_number)
VALUES
    (1, '123-4567'),
    (1, '234-5678'),
    (2, '345-6789');

2. Second Normal Form (2NF):
 a. Choose a table in Sakila and describe how you would determine whether it is in 2NF.  If it violates 2NF, explain the steps to normalize it.

-> For a table to be in the Second Normal Form (2NF), it must first be in the First Normal Form (1NF) and every non-key attribute must be fully dependent on the entire primary key. For tables with a single-column primary key, any table in 1NF is automatically in 2NF, since there is no possibility of a partial dependency. Therefore, to identify a violation of 2NF, we must select a table with a composite primary key. 
Let's examine the film_actor table from the Sakila database to demonstrate this process.
About the film_actor table
This table is designed to handle the many-to-many relationship between actors and films. 
Table Name: film_actor
Columns: actor_id, film_id, last_update.
Primary Key: The composite key (actor_id, film_id).
Non-Key Attributes: last_update. 
How to determine if film_actor is in 2NF
Check for 1NF: The film_actor table is in 1NF because every cell contains a single, atomic value, there are no repeating groups, and a primary key exists.
Check for Partial Dependencies: Next, we determine if any non-key attribute is dependent on only a part of the composite primary key (actor_id, film_id).
Candidate Key: The only candidate key is the composite primary key (actor_id, film_id), as it is the minimal set of attributes that uniquely identifies each row.
Check last_update: The last_update column records the timestamp for the row. This value is dependent on the row itself, which is uniquely identified by the full composite key (actor_id, film_id). The last_update timestamp does not depend solely on actor_id or film_id alone. 
Because all non-key attributes (last_update) are dependent on the entire primary key, and the table is in 1NF, the film_actor table is already in 2NF 

3. Third Normal Form (3NF):
 a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies  present and outline the steps to normalize the table to 3NF.
 
 The Sakila database's film table violates Third Normal Form (3NF) due to transitive dependencies.
Transitive Dependencies in film table:
The film table contains attributes like rental_duration, rental_rate, replacement_cost, and rating, which are related to the film itself. However, it also includes language_id and original_language_id. While language_id is a foreign key referencing the language table, the language table itself contains name.
The transitive dependency exists as follows: film_id -> language_id -> name (language name)
Here, name (language name) is a non-key attribute that depends on language_id, which is also a non-key attribute (though a foreign key) in the film table, rather than directly on the primary key film_id. This violates 3NF.
Normalization Steps to 3NF:
To normalize the film table to 3NF, the following steps are required:
Identify and Isolate Transitive Dependencies: Recognize that the name of the language is indirectly dependent on film_id through language_id.
Create a New Table for the Dependent Attribute: Create a new table, language, if it doesn't already exist, with language_id as its primary key and name as an attribute. In Sakila, this table already exists.
Code

    CREATE TABLE language (
        language_id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
        name CHAR(20) NOT NULL,
        last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (language_id)
    );
Remove the Transitively Dependent Attribute from the Original Table: The name attribute (language name) should not be directly present in the film table. Instead, film should only contain language_id as a foreign key. The Sakila film table correctly implements this by only storing language_id and original_language_id and not the actual language names.
Code

    CREATE TABLE film (
        film_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        description TEXT DEFAULT NULL,
        release_year YEAR DEFAULT NULL,
        language_id TINYINT UNSIGNED NOT NULL,
        original_language_id TINYINT UNSIGNED DEFAULT NULL,
        rental_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
        rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
        length SMALLINT UNSIGNED DEFAULT NULL,
        replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
        rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
        special_features SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
        last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (film_id),
        KEY idx_fk_language_id (language_id),
        KEY idx_fk_original_language_id (original_language_id),
        CONSTRAINT fk_film_language FOREIGN KEY (language_id) REFERENCES language (language_id) ON UPDATE CASCADE,
        CONSTRAINT fk_film_language_original FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON UPDATE CASCADE
    );
By ensuring that the name of the language is stored only in the language table and referenced by language_id in the film table, the transitive dependency is eliminated, and the film table adheres to 3NF.

4. Normalization Process:
 a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  unnormalized form up to at least 2NF.
 
 To normalize a Sakila table to at least Second Normal Form (2NF), start with a table that contains a composite primary key, like the payment table which includes customer_id and payment_id, and apply the following steps: First, ensure the table is in First Normal Form (1NF) by having atomic values and unique records. Then, to achieve 2NF, identify and remove any partial dependencies by splitting the table. For the payment table, the payment_id is already a primary key, and attributes like customer_id, staff_id, and rental_id are fully dependent on it. Therefore, the payment table is already in 1NF and 2NF because it lacks a composite primary key and has no partial dependencies. 
1. Understanding the payment table (Sakila Example)
Let's consider the payment table in Sakila, which has the following structure (simplified):
payment_id (Primary Key)
customer_id
staff_id
rental_id
amount
payment_date
2. Initial State: First Normal Form (1NF)
Atomicity
: All values in the payment table are atomic, meaning each column contains a single, indivisible value (e.g., a single amount, a single payment_date). 
Unique Records
: Each row represents a distinct payment, and there are no repeating groups of columns. 
Conclusion
: The payment table is already in 1NF.
3. Achieving Second Normal Form (2NF)
Definition
: A table is in 2NF if it is in 1NF and has no partial dependencies. A partial dependency occurs when a non-key attribute depends on only a proper subset of a composite primary key. 
Analysis of payment table
:
The payment_id is the primary key.
All other attributes (customer_id, staff_id, rental_id, amount, payment_date) are functionally dependent on the entire primary key, payment_id.
There is no composite primary key, so there cannot be any partial dependencies. 
Conclusion
: Since the payment table has a single-attribute primary key and all other attributes depend on that single attribute, it inherently has no partial dependencies. Therefore, the payment table is already in 2NF.
Summary of the process for this specific table:
Verify 1NF: Confirm that all values are atomic and there are no repeating groups in the payment table.
Identify Primary Key: Determine the primary key, which is payment_id.
Check for Partial Dependencies: Since payment_id is not a composite key, no partial dependency exists. Therefore, the table satisfies the condition for 2NF without requiring any modification. 

5. CTE Basics:
 a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in from the actor and film_actor tables.
 
 WITH actor_film_count AS (
    SELECT
        fa.actor_id,
        COUNT(DISTINCT fa.film_id) AS film_count
    FROM
        film_actor fa
    GROUP BY
        fa.actor_id
)

SELECT
    a.first_name || ' ' || a.last_name AS actor_name,
    afc.film_count
FROM
    actor a
JOIN
    actor_film_count afc ON a.actor_id = afc.actor_id
ORDER BY
    afc.film_count DESC, actor_name;

6. CTE with Joins:
 a. Create a CTE that combines information from the film and language tables to display the film title,  language name, and rental rate.
 
 WITH FilmLanguageCTE AS (
    SELECT
        f.title AS film_title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film f
    JOIN
        language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLanguageCTE;

7. CTE for Aggregation:
 a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)  from the customer and payment tables.
 
 WITH customer_payments AS (
    SELECT
        customer_id,
        SUM(amount) AS total_revenue
    FROM
        payment
    GROUP BY
        customer_id
)

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    cp.total_revenue
FROM
    customer c
JOIN
    customer_payments cp ON c.customer_id = cp.customer_id
ORDER BY
    cp.total_revenue DESC;

8. CTE with Window Functions:
 a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
 
 WITH FilmRanked AS (
    SELECT 
        film_id,
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_duration_rank
    FROM film
)
SELECT *
FROM FilmRanked
ORDER BY rental_duration_rank;

9. CTE and Filtering:
 a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the  customer table to retrieve additional customer details.
 
 -- Step 1: Define the CTE to count rentals per customer
WITH rental_counts AS (
    SELECT 
        customer_id,
        COUNT(*) AS rental_count
    FROM 
        rental
    GROUP BY 
        customer_id
    HAVING 
        COUNT(*) > 2
)

-- Step 2: Join the CTE with the customer table to get customer details
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.address_id,
    rc.rental_count
FROM 
    rental_counts rc
JOIN 
    customer c ON rc.customer_id = c.customer_id;

10. CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month, considering the  rental_date from the rental table
 
 WITH MonthlyRentals AS (
    SELECT
        DATE_TRUNC('month', rental_date) AS rental_month,
        COUNT(*) AS total_rentals
    FROM rental
    GROUP BY DATE_TRUNC('month', rental_date)
)
SELECT *
FROM MonthlyRentals
ORDER BY rental_month;

11. CTE and Self-Join:
 a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film  together, using the film_actor table.
 
 WITH actor_pairs AS (
    SELECT
        fa1.actor_id AS actor_id_1,
        fa2.actor_id AS actor_id_2,
        fa1.film_id
    FROM
        film_actor fa1
    JOIN
        film_actor fa2
        ON fa1.film_id = fa2.film_id
       AND fa1.actor_id < fa2.actor_id
)
SELECT
    ap.actor_id_1,
    ap.actor_id_2,
    f.title AS film_title
FROM
    actor_pairs ap
JOIN
    film f ON ap.film_id = f.film_id
ORDER BY
    ap.actor_i_

12. CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,  considering the reports_to column.
 
 WITH RECURSIVE subordinates AS (
    -- Anchor member: Start with the manager
    SELECT 
        employee_id,
        name,
        reports_to
    FROM staff
    WHERE reports_to = 101  -- Replace 101 with the specific manager's ID

    UNION ALL

    -- Recursive member: Find employees who report to employees found in previous step
    SELECT 
        s.employee_id,
        s.name,
        s.reports_to
    FROM staff s
    INNER JOIN subordinates sub ON s.reports_to = sub.employee_id
)

SELECT * FROM subordinates;









