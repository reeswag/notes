# Basic JS

## Comments

Comments are lines of code that JavaScript will intentionally ignore. Comments are a great way to leave notes to yourself and to other people who will later need to figure out what that code does.

There are two ways to write comments in JavaScript:

Using ```//``` will tell JavaScript to ignore the remainder of the text on the current line:

```// This is an in-line comment.```

You can make a multi-line comment beginning with ```/*``` and ending with ```*/```:

```
/* This is a
multi-line comment */
```

#### Best Practice
As you write code, you should regularly add comments to clarify the function of parts of your code. Good commenting can help communicate the intent of your code—both for others and for your future self.

----

## Declaring JS Variables

In computer science, data is anything that is meaningful to the computer. JavaScript provides eight different data types which are undefined, null, boolean, string, symbol, bigint, number, and object.

For example, computers distinguish between numbers, such as the number 12, and strings, such as "12", "dog", or "123 cats", which are collections of characters. Computers can perform mathematical operations on a number, but not on a string.

Variables allow computers to store and manipulate data in a dynamic fashion. They do this by using a "label" to point to the data rather than using the data itself. Any of the eight data types may be stored in a variable.

Variables are similar to the x and y variables you use in mathematics, which means they're a simple name to represent the data we want to refer to. Computer variables differ from mathematical variables in that they can store different values at different times.

We tell JavaScript to create or declare a variable by putting the keyword var in front of it, like so:

```var ourName;```

creates a variable called ourName. In JavaScript we end statements with semicolons. Variable names can be made up of numbers, letters, and $ or _, but may not contain spaces or start with a number.

In JavaScript, you can store a value in a variable with the assignment operator.

```myVariable = 5;```

This assigns the Number value 5 to myVariable.

Assignment always goes from right to left. Everything to the right of the = operator is resolved before the value is assigned to the variable to the left of the operator.
```
myVar = 5;
myNum = myVar;
```

This assigns 5 to myVar and then resolves myVar to 5 again and assigns it to myNum.


When JavaScript variables are declared, they have an initial value of undefined. If you do a mathematical operation on an undefined variable your result will be NaN which means "Not a Number". If you concatenate a string with an undefined variable, you will get a literal string of "undefined".

### Naming Variables

In JavaScript all variables and function names are case sensitive. This means that capitalization matters.

```MYVAR``` is not the same as ```MyVar``` nor ```myvar```. It is possible to have multiple distinct variables with the same name but different casing. It is strongly recommended that for the sake of clarity, you do not use this language feature.

#### Best Practice
Write variable names in JavaScript in camelCase. In camelCase, multi-word variable names have the first word in lowercase and the first letter of each subsequent word is capitalized.

Examples:
```
var someVariable;
var anotherVariableName;
var thisVariableNameIsSoLong;
```
-----

## Number

Number is a data type in JavaScript which represents numeric data.

Now let's try to add two numbers using JavaScript.

JavaScript uses the + symbol as an addition operator when placed between two numbers.

Example:

```myVar = 5 + 10; // assigned 15```

We can also subtract one number from another.

JavaScript uses the - symbol for subtraction.

Example

```myVar = 12 - 6; // assigned 6```

We can also multiply one number by another.

JavaScript uses the * symbol for multiplication of two numbers.

Example

```myVar = 13 * 13; // assigned 169```

We can also divide one number by another.

JavaScript uses the / symbol for division.

Example

```myVar = 16 / 2; // assigned 8```

You can easily increment or add one to a variable with the ++ operator.

```i++;```

is the equivalent of

```i = i + 1;```

#### Note
The entire line becomes i++;, eliminating the need for the equal sign.

You can easily decrement or decrease a variable by one with the -- operator.

```i--;```

is the equivalent of

```i = i - 1;```

#### Note
The entire line becomes ```i--;```, eliminating the need for the equal sign.

We can store decimal numbers in variables too. Decimal numbers are sometimes referred to as floating point numbers or floats.

#### Note
Not all real numbers can accurately be represented in floating point. This can lead to rounding errors. 