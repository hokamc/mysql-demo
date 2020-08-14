<p align="center">
  <a href="" rel="noopener">
 <img src="https://upload.wikimedia.org/wikipedia/zh/thumb/6/62/MySQL.svg/2560px-MySQL.svg.png"  width="200" alt="Git"></a>
</p>
<h1 align="center">Mysql Demo</h1>

<div align="center">

[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)]()
[![Status](https://img.shields.io/badge/status-active-success.svg)]()

</div>

<p align="center"> Share some useful mysql commands
    <br> 
</p>

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Set up Mysql by Docker](#set-up-mysql-by-docker)
- [Shell control](#shell-control)
- [Querying](#querying)
- [Sorting](#sorting)
- [Filtering](#filtering)
- [Joining](#joining)
- [Authors](#authors)
- [Credit](#credit)

## Set up Mysql by Docker

Let's start a mysql instance with sample database.

```bash
docker run -d \
--name mysql-demo \
-e MYSQL_ROOT_PASSWORD=123 \
-v $PWD/mysqlsampledatabase.sql:/usr/mysql/mysqlsampledatabase.sql \
mysql:5.5.62;
```
Simply run a mysql container with default password and also bind sql file.

```bash
CONTAINER=`docker container ls -q --filter "name=mysql-demo"`;
docker container exec -it $CONTAINER bash \
-c 'mysql -u root --password=123 -e "source /usr/mysql/mysqlsampledatabase.sql"';
```
And then load sample database into mysql server for later usage.

**Sample Database Schema**<br><br>
![alt schema](https://sp.mysqltutorial.org/wp-content/uploads/2009/12/MySQL-Sample-Database-Schema.png)

## Shell control

- SHOW DATABASES
- USE $database
- SHOW TABLES
- SHOW COLUMNS FROM $table

## Querying

- **SELECT** $columns FROM $table
```sql
SELECT * FROM employees;
SELECT lastName, firstName FROM employees;
```

## Sorting

- SELECT $columns FROM $table **ORDER BY** $column [ASC|DESC], ...
```sql
SELECT customerName, creditLimit FROM customers ORDER BY creditLimit ASC;
SELECT customerName, creditLimit FROM customers ORDER BY customerName DESC, creditLimit ASC;
```

- ORDER BY *expresssion*
```sql
SELECT orderNumber, quantityOrdered * priceEach FROM orderdetails ORDER BY quantityOrdered * priceEach DESC;
SELECT orderNumber, quantityOrdered * priceEach AS subtotal FROM orderdetails ORDER BY subtotal DESC;
```

- ORDER BY *custom list*
```sql
SELECT orderNumber, status FROM orders ORDER BY FIELD(status, 'In Process', 'On Hold') DESC;
```

## Filtering

- SELECT $columns FROM $table **WHERE** $condition
> **Supported operators**: =, !=, <, >, <=, >=
```sql
SELECT customerName from customers WHERE contactLastName = 'Moos';
SELECT customerName from customers WHERE country = 'USA' AND creditLimit > 10000;
SELECT customerName from customers WHERE country = 'USA' OR creditLimit < 10000;
```

- SELECT **DISTINCT** $columns FROM $table
> filter duplicated rows
```sql
SELECT DISTINCT lastname FROM employees;
SELECT DISTINCT lastname, firstname FROM employees;
```

- **IN, BETWEEN AND, LIKE, IS NULL**
> **LIKE** is case insensitive; **%** mean any string; **_** mean single character
```sql
SELECT customerName, country FROM customers WHERE country IN ('USA', 'FRANCE');
SELECT customerName, creditLimit from customers WHERE creditLimit BETWEEN 10000 AND 20000;
SELECT customerName from customers WHERE customerName LIKE '%Co.';
SELECT customerName from customers WHERE customerName LIKE '%Co_';
SELECT firstName from employees WHERE reportsTo IS NULL;
```

- SELECT $columns FROM $table **LIMIT** $offset, $count
```sql
SELECT customerName FROM customers LIMIT 5;
SELECT customerName FROM customers LIMIT 3, 5;
```

## Joining

- AS $name (optional keyword)
> alias for columns, expressions, tables
```sql
SELECT CONCAT_WS(' ', lastName, firstname) AS 'Full name' FROM employees;
SELECT CONCAT_WS(' ', lastName, firstname) 'Full name' FROM employees;
SELECT c.lastName FROM employees c;
```

- INNER JOIN $table ON $condition
```sql
SELECT productCode, p1.productLine, textDescription FROM products p1 INNER JOIN productlines p2 ON p1.productline = p2.productline;
SELECT t1.orderNumber, COUNT(t1.orderNumber) FROM orderdetails t1 INNER JOIN orders t2 ON t1.orderNumber = t2.orderNumber GROUP BY orderNumber;
```

- LEFT JOIN $table ON $condition
```sql
SELECT t1.customerNumber, t2.orderNumber FROM customers t1 LEFT JOIN orders t2 ON t1.customerNumber = t2.customerNumber;
```

- RIGHT JOIN $table ON $condition
```sql
SELECT t2.customerNumber, t1.orderNumber FROM orders t1 RIGHT JOIN customers t2 ON t1.customerNumber = t2.customerNumber;
```

- CROSS JOIN $table
> M x N rows
```sql
SELECT status, COUNT(customerName) FROM customers t1 CROSS JOIN orders t2 GROUP BY status;
```


## Authors

- [@hokamc](https://github.com/hokamc)

## Credit

- [sample database](https://www.mysqltutorial.org/mysql-sample-database.aspx)

