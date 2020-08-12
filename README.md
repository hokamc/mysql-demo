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

- SELECT $columns FROM $table
```sql
SELECT * FROM employees;
SELECT lastName, firstName FROM employees;
```

## Sorting

- SELECT $columns FROM $table ORDER BY $column [ASC|DESC], ...
```sql
SELECT customerName, creditLimit FROM customers ORDER BY creditLimit ASC;
SELECT customerName, creditLimit FROM customers ORDER BY customerName DESC, creditLimit ASC;
```

- ORDER BY *expresssion
```sql
SELECT orderNumber, quantityOrdered * priceEach FROM orderdetails ORDER BY quantityOrdered * priceEach DESC;
```


## Authors

- [@hokamc](https://github.com/hokamc)

## Credit

- [sample database](https://www.mysqltutorial.org/mysql-sample-database.aspx)

