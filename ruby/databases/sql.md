# SQL

## Talk to databases

Using SQL (Structured Query Language) we can talk to (relational) databases.

For example we can ask (query) the database to retrieve certain bits of information from tables, or we can insert, update or delete data. And SQL is also the language that is used to define the database structure in the first place.

SQL was invented in the 1970s, and it’s quite ugly to look at. However, lots of database systems support it, and so it’s quite common to use SQL in web applications in some way.

## Select 

For example, we could retrieve all fields in the first row from our members table like this:

```SELECT * FROM members WHERE id = 1;```

The statement SELECT tells the database that we’d like to retrieve data (as opposed to, for example, INSERT which inserts a new row, or UPDATE which updates an existing row). The star * means “all fields”. FROM specifies the table that we want to look at, and WHERE specifies a condition that this row needs to match: We’d like to retrieve the row where the value in the id column equals 1.

So our query above would return a result containing one row:
|   |   |   |
|---|---|---|
|1 | Anja | 2013-06-24|

However, when we ask for all rows that have the joined_on date 2013-06-24 we’d get back two rows:

```SELECT * FROM members WHERE joined_on = '2013-06-24';```

This would return:
|   |   |   |
|---|---|---|
|1 | Anja  | 2013-06-24|
|2 | Carla | 2013-06-24|

Instead of asking for all fields per row, we could also just ask for a certain column that we are interested in:

``` SELECT name FROM members WHERE joined_on = '2013-06-24';```

This would return just the names:
|   |
|---|
|Anja|
|Carla|

The where clause (optional) specifies which data values or rows will be returned or displayed, based on the criteria described after the keyword where.

Conditional selections used in the where clause:
```
=	Equal
>	Greater than
<	Less than
>=	Greater than or equal
<=	Less than or equal
<>	Not equal to
LIKE	*See note below
```
The LIKE pattern matching operator can also be used in the conditional selection of the where clause. Like is a very powerful operator that allows you to select only rows that are "like" what you specify. The percent sign "%" can be used as a wild card to match any possible character that might appear before or after the characters specified. For example:
```
select first, last, city
   from empinfo
   where first LIKE 'Er%';
```
## Insert

In order to insert a new row to the table we could use an SQL statement like this (assumning our id column auto-increments, i.e. automatically assigns the next number to the new row):
```
insert into "tablename"
 (first_column,...last_column)
  values (first_value,...last_value);
```

```INSERT INTO members (name, joined_at) VALUES('Maren', '2013-06-24');```

## Update

The update statement is used to update or change records that match a specified criteria. This is accomplished by carefully constructing a where clause.

```
update "tablename"
set "columnname" =  "newvalue" , ["nextcolumn" =  "newvalue2"...] where "columnname" OPERATOR "value" [and|or "column" 
  OPERATOR "value"];

 [] = optional
 ```
Examples:

```UPDATE members SET joined_on = '2013-06-24' WHERE id = 3;```
```
update phone_book
  set area_code = 623
  where prefix = 979;

update phone_book
  set last_name = 'Smith', prefix=555, suffix=9292
  where last_name = 'Jones';

update employee
  set age = age+1
  where first_name='Mary' and last_name='Williams';
```

## Delete

And deleting like this:

```DELETE FROM members WHERE id = 3; ```

As you can see these statements all look somewhat similar, starting with a certain command, naming the table, and ending with a semicolon. However, they also don’t really look very consistent. For example, why does the INSERT statement separate the column names and inserted values, while the UPDATE statement pairs them?

On the other hand, even though it’s a little weird, it’s also a very powerful language, and being able to figure out some SQL and manually writing it can be very useful when you have access to a database, and you want to find out some bits of information that cannot be retrieved with the application that is using the database: You’d just directly talk to the database, and ask it for the information you need.

Of course there are tools for this. We’ll look at libraries that make it easy to talk to databases in the chapter about ORMs.

Examples:

delete from employee;
Note: if you leave off the where clause, all records will be deleted!

```
delete from employee
  where lastname = 'May';

delete from employee
  where firstname = 'Mike' or firstname = 'Eric';
```
To delete an entire record/row from a table, enter "delete from" followed by the table name, followed by the where clause which contains the conditions to delete. If you leave off the where clause, all records will be deleted.


## Insert

Now let’s insert a row to the table:

```
sqlite> INSERT INTO members (name, joined_on) VALUES ('Anja', '2013-06-24');
```

Again, if this does not output anything, that means our command was successful.

We can now retrieve the data using a SELECT statement like so:

```
sqlite> SELECT * FROM members;
1|Anja|2013-06-24
```
So this displays on row.

## Drop a Table

The drop table command is used to delete a table and all rows in the table.

To delete an entire table including all of its rows, issue the drop table command followed by the tablename. drop table is different from deleting all of the records in the table. Deleting all of the records in the table leaves the table including column and constraint information. Dropping the table removes the table definition as well as all of its rows.

```
drop table "tablename"
```
--------

## SQLite

SQLite is a minimalistic implementation of a relational database that supports most of SQL, although not all of it. It is less powerful than, for example, PostgreSQL and MySQL, but it’s also super lightweight, and great for learning, experiments, and getting started quickly.

We are going to use the database SQLite in our examples, because it’s the least hassle to set it up. So you want to make sure you have it installed, many operating systems have it preinstalled.

Check if it’s installed by running this in your terminal:

```$ sqlite3 --version```

If that outputs a version string then SQLite is installed. If it’s not then you’ll see something like command not found: sqlite3. In that case Mislav has written up some nice instructions over here.

SQLite comes with a handy command line tool that one can use to create databases and interact with them. It also has an interactive shell: Just like with IRB (where we can execute Ruby code interactively) we can log into the SQLite database, and execute SQL statements interactively.

Let’s try it:

```$ sqlite3 members```

This should put you into the interactive SQLite shell, and look something like this:

```SQLite version 3.8.5 2014-08-15 22:37:57
Enter ".help" for usage hints.
sqlite>
```

The prompt ```sqlite>``` waits for your input. If you type an SQL command and hit return it will execute it.

## Create

Let’s create our members table:

```
sqlite> CREATE TABLE members (id INTEGER PRIMARY KEY, name VARCHAR(255), joined_on DATE);
```

If this does not output an error, then the command was successful.

The command says that we’d like to create a table member with 3 columns id, name, and joined_on. The column id is supposed to be an integer column, and we’d like to use it as our primary key (meaning that it will be unique, and it will autoincrement the id for us). The column name is a string column, and values can be 255 characters long. And joined_at is a date column.

Cool. So we’ve just created a table in our database.

We can list our tables like so:

```
sqlite> .tables
members
```
And we can check the structure (schema) of our members table like so:
```
sqlite> .schema members
CREATE TABLE members (id INTEGER PRIMARY KEY, name VARCHAR(255), joined_on DATE);
```

Here are some of the most commonly used Data Types:

| Name          | Data Type                                                                       |
|---------------|---------------------------------------------------------------------------------|
| char(size)    | Fixed-length character string. Size is specified in parenthesis. Max 255 bytes. |
| varchar(size) | Variable-length character string. Max size is specified in parenthesis.         |
| number(size)  | Number value with a max number of column digits specified in parenthesis.       |
| date          | Date value                                                                      |
### Constraints
When tables are created, it is common for one or more columns to have constraints associated with them. A constraint is basically a rule associated with a column that the data entered into that column must follow. For example, a "unique" constraint specifies that no two records can have the same value in a particular column. They must all be unique. The other two most popular constraints are "not null" which specifies that a column can't be left blank, and "primary key". A "primary key" constraint defines a unique identification of each record (or row) in a table. 

### Naming Conventions

IMPORTANT: When selecting a table name, it is important to select a unique name that no one else will use or guess. Your table names should have an underscore followed by your initials and the digits of your birth day and month. For example, Tom Smith, who was born on November 2nd, would name his table myemployees_ts0211 Use this convention for all of the tables you create. Your tables will remain on a shared database until you drop them, or they will be cleaned up if they aren't accessed in 4-5 days.

-----
## Exercises

```
CREATE TABLE myemployees_wr_0101 (firstname VARCHAR(255), lastname VARCHAR(255), title VARCHAR(255), age number(255), salary number(255)); 

INSERT INTO myemployees_wr_0101 (firstname, lastname, title, age, salary) VALUES ('Jonie', 'Weber', 'Secretary', 28, 19500.00);

INSERT INTO myemployees_wr_0101 (firstname, lastname, title, age, salary) VALUES ('Potsy', 'Weber', 'Programmer', 32, 45300.00);

INSERT INTO myemployees_wr_0101 (firstname, lastname, title, age, salary) VALUES ('Dirk', 'Smith', 'Programmer II', 45, 75020.00);
````

- Select all columns for everyone in your employee table.

``` 
SELECT * FROM myemployees_wr_0101;
```

- Select all columns for everyone with a salary over 30000.

```
SELECT * FROM myemployees_wr_0101 WHERE salary > 30000;
```

- Select first and last names for everyone that's under 30 years old.

```
SELECT firstname FROM myemployees_wr_0101 WHERE age < 30;
```

- Select first name, last name, and salary for anyone with "Programmer" in their title.
  
```
SELECT firstname, lastname, salary FROM myemployees_wr_0101 WHERE tile = 'Programmer';
```

- Select all columns for everyone whose last name contains "ebe".

```
SELECT * FROM myemployees_wr_0101 WHERE lastname LIKE '%ebe%';
```

- Select the first name for everyone whose first name equals "Potsy".

```
SELECT firstname FROM myemployees_wr_0101 WHERE firstname = 'Potsy';
```

- Select all columns for everyone over 80 years old.

```
SELECT * FROM myemployees_wr_0101 WHERE age > 80;
```

- Select all columns for everyone whose last name ends in "ith".

```
SELECT * FROM myemployees_wr_0101 WHERE lastname LIKE '%ith';
```
- Jonie Weber just got married to Bob Williams. She has requested that her last name be updated to Weber-Williams.

```
update myemployees_wr_0101 set lastname = 'Weber-Williams' where firstname = 'Jonie';
```

- Dirk Smith's birthday is today, add 1 to his age.
```
update myemployees_wr_0101 set age = age + 1 where firstname = 'Dirk';
```

- All secretaries are now called "Administrative Assistant". Update all titles accordingly.
```
update myemployees_wr_0101 set title = 'Administrative Assistant' where title = 'Secretary';
```
- Everyone that's making under 30000 are to receive a 3500 a year raise.
```
update myemployees_wr_0101 set salary = salary + 3500 where salary < 30000;
```
- Everyone that's making over 33500 are to receive a 4500 a year raise.
```
update myemployees_wr_0101 set salary = salary + 4500 where salary > 33500;
```

- All "Programmer II" titles are now promoted to "Programmer III".
```
update myemployees_wr_0101 set title = 'Programmer III' where title = 'Programmer II';
```
- All "Programmer" titles are now promoted to "Programmer II".
```
update myemployees_wr_0101 set tile = 'Programmer II' where tile = 'Programmer';
```
- Jonie Weber-Williams just quit, remove her record from the table.
```
delete from myemployees_wr_0101 where firstname = 'Jonie';
```
- It's time for budget cuts. Remove all employees who are making over 70000 dollars.

```
delete from myemployees_wr_0101 where salary > 70000;
```
- Drop your employee table.
```
drop table myemployees_wr_0101;
```