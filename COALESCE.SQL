--What is the purpose of the COALESCE function in SQL, and how does it work?

/*The COALESCE function in SQL is used to handle NULL values and return the first
non-null expression in a list of expressions. Its purpose is to provide a way to replace
NULL values with an alternative non-null value.
The function takes multiple expressions as arguments, separated by commas.
It evaluates these expressions in the order they are provided and returns the value of 
the first non-null expression. If all the expressions are NULL, 
the COALESCE function will return NULL.*/

/*Write an SQL query that uses COALESCE to select the non-null value from two columns, column1 and column2,
in a table called my_table.*/
SELECT COALESCE(column1, column2) AS non_null_value
FROM my_table;

/*How can you use the COALESCE function to handle NULL values when concatenating two columns, 
first_name and last_name, to create a full name in a result set?*/

/*You can use the COALESCE function to handle NULL values when concatenating first_name and last_name 
columns to create a full name in a result set. The COALESCE function will ensure that if either 
first_name or last_name is NULL, it will be replaced with an alternative value (for example, an empty string)
to avoid NULL in the final concatenated result. Here's how you can do it:*/

SELECT COALESCE(first_name, '') || ' ' || COALESCE(last_name, '') AS full_name
FROM your_table;

/*With this query, you will get a result set containing full names where NULL values
in first_name or last_name are replaced by an empty string. This ensures that you 
have a complete and consistent full name in
the result set even if some parts are missing.*/

/*In a table named inventory, there are three columns: product_id, product_name, and alternative_name. 
Write an SQL query that uses COALESCE to select the product name, but if it is NULL, 
it should use the alternative name.*/

SELECT COALESCE(product_name, alternative_name) AS product_or_alternative_name
FROM inventory;

/*This query will return a result set with a single column (product_or_alternative_name),
and each row will contain either the product name or the alternative name, depending on which
one is available and non-null. If the product name is NULL, 
it will be replaced by the alternative name in the result set.*/

/*How can you use COALESCE to perform a search for a specific value in multiple columns 
and return the first non-null value found?*/

SELECT COALESCE(column1, column2, column3) AS first_non_null_value
FROM your_table
WHERE column1 = 'target_value' OR column2 = 'target_value' OR column3 = 'target_value'
LIMIT 1;

/*This query will return a result set with a single column (first_non_null_value), 
and the first non-null value found among the three columns (column1, column2, column3) 
that matches the 'target_value' will be returned in the result set. 
If no match is found, the result set will be empty.*/

/*In a table called orders, there are four columns: order_id, customer_name, shipping_address, 
and billing_address. Write an SQL query that selects the customer's name and the address
(either shipping or billing) using COALESCE, with preference 
given to the shipping address if it is available.*/

SELECT customer_name, COALESCE(shipping_address, billing_address) AS address
FROM orders;

/*This query will return a result set with two columns (customer_name and address). 
The address column will contain either the shipping address (if available) or the billing address, 
with preference given to the shipping address if it exists.
If both addresses are NULL, the address column will contain NULL.*/

--Explain how the COALESCE function differs from the NULLIF function in SQL, and provide an example of each.
/*The COALESCE and NULLIF functions in SQL are used to handle NULL values, but they serve different purposes and work differently:

COALESCE Function:

Purpose: The COALESCE function is used to return the first non-null value from a list of expressions. It evaluates the expressions in order and returns the first non-null value it encounters. If all the expressions are NULL, it returns NULL.

Syntax: COALESCE(expression1, expression2, ..., expressionN)

Example:
Let's say we have a table called products with columns product_id, 
product_name, and alternative_name. We want to select the first non-null 
value among product_name and alternative_name for each product.*/
SELECT product_id, COALESCE(product_name, alternative_name) AS product_or_alternative_name
FROM products;

/*n this example, if product_name is NULL, the COALESCE function will return alternative_name.
If both product_name and alternative_name are NULL, the product_or_alternative_name column will contain NULL.*/

/*NULLIF Function:

Purpose: The NULLIF function is used to compare two expressions and return NULL if they are equal; 
otherwise, it returns the first expression. It is particularly useful for setting a specific 
value to NULL when two values are equal, and it can be seen as a "conditional nullification" function.

Syntax: NULLIF(expression1, expression2)

Example:
Let's say we have a table called employees with columns employee_id, employee_name, and temporary_name.
We want to replace the temporary_name with NULL if it matches the employee_name.*/

SELECT employee_id, NULLIF(temporary_name, employee_name) AS final_name
FROM employees;

/*In this example, if temporary_name is equal to employee_name, the NULLIF function will return NULL for 
the final_name column. Otherwise, it will return the value of temporary_name.
To summarize, COALESCE is used to select the first non-null value from a list of expressions,
while NULLIF is used to conditionally return NULL if two expressions are equal. 
They provide different functionalities for handling NULL and conditional values in SQL queries.*/

/*In a table named products, there are three columns: product_id, product_name, 
and product_price. Write an SQL query that uses COALESCE to select the product name 
and price, but if the price is NULL, 
it should return "Price not available."*/

SELECT product_id, product_name, COALESCE(CAST(product_price AS VARCHAR), 
'Price not available') AS product_price
FROM products;

/*How does the COALESCE function handle data types in SQL? Can it be used with different data types, 
and if so, how?*/
SELECT COALESCE(10, 20, 30);
-- Output: 10 (all expressions are integers)
SELECT COALESCE('Hello', 42);
-- Output: 'Hello' (string data type takes precedence over integer data type)
SELECT COALESCE(NULL, 'Hello', 42);
/*Output: 'Hello' (string data type takes precedence over integer data 
type even though the first expression is NULL)*/
SELECT COALESCE(NULL, NULL, NULL);
-- Output: NULL


/*Write an SQL query that uses COALESCE to calculate the total quantity of a product, 
accounting for both the original quantity and the quantity of backordered items stored in 
two columns, quantity and backorder_quantity. 
If the backorder_quantity is NULL, it should be treated as 0.*/

SELECT product_id, product_name, 
       COALESCE(quantity, 0) + COALESCE(backorder_quantity, 0) AS total_quantity
FROM products;