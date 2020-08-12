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

The remainder operator % gives the remainder of the division of two numbers.

#### Example
```
5 % 2 = 1 because
Math.floor(5 / 2) = 2 (Quotient)
2 * 2 = 4
5 - 4 = 1 (Remainder)
```

#### Usage
In mathematics, a number can be checked to be even or odd by checking the remainder of the division of the number by 2.
```
17 % 2 = 1 (17 is Odd)
48 % 2 = 0 (48 is Even)
```

#### Note
The remainder operator is sometimes incorrectly referred to as the "modulus" operator. It is very similar to modulus, but does not work properly with negative numbers.

### Compound Assignment

In programming, it is common to use assignments to modify the contents of a variable. Remember that everything to the right of the equals sign is evaluated first, so we can say:
```
myVar = myVar + 5;
```
to add 5 to myVar. Since this is such a common pattern, there are operators which do both a mathematical operation and assignment in one step.

One such operator is the ```+=``` operator.
```
var myVar = 1;
myVar += 5;
console.log(myVar); // Returns 6
```

Like the ```+=``` operator, -= subtracts a number from a variable.

The ```*=``` operator multiplies a variable by a number. 

The ```/=``` operator divides a variable by another number.

## String Variables

Previously we have used the code

```var myName = "your name";```

"your name" is called a string literal. It is a string because it is a series of zero or more characters enclosed in single or double quotes.

### Escaping within strings

When you are defining a string you must start and end with a single or double quote. What happens when you need a literal quote: " or ' inside of your string?

In JavaScript, you can escape a quote from considering it as an end of string quote by placing a backslash (\) in front of the quote.
```
var sampleStr = "Alan said, \"Peter is learning JavaScript\".";
```
This signals to JavaScript that the following quote is not the end of the string, but should instead appear inside the string. So if you were to print this to the console, you would get:

Alan said, "Peter is learning JavaScript".

String values in JavaScript may be written with single or double quotes, as long as you start and end with the same type of quote. Unlike some other programming languages, single and double quotes work the same in JavaScript.
```
doubleQuoteStr = "This is a string"; 
singleQuoteStr = 'This is also a string';
```
The reason why you might want to use one type of quote over the other is if you want to use both in a string. This might happen if you want to save a conversation in a string and have the conversation in quotes. Another use for it would be saving an ```<a>``` tag with various attributes in quotes, all within a string.
```
conversation = 'Finn exclaims to Jake, "Algebraic!"';
```
However, this becomes a problem if you need to use the outermost quotes within it. Remember, a string has the same kind of quote at the beginning and end. But if you have that same quote somewhere in the middle, the string will stop early and throw an error.
```
goodStr = 'Jake asks Finn, "Hey, let\'s go on an adventure?"'; 
badStr = 'Finn responds, "Let's go!"'; // Throws an error
```

In the goodStr above, you can use both quotes safely by using the backslash \ as an escape character. Note
The backslash ```\``` should not be confused with the forward slash ```/```. They do not do the same thing.

Quotes are not the only characters that can be escaped inside a string. There are two reasons to use escaping characters:

To allow you to use characters you may not otherwise be able to type out, such as a carriage return.
To allow you to represent multiple quotes in a string without JavaScript misinterpreting what you mean.
We learned this in the previous challenge.
```
Code	Output
\'	single quote
\"	double quote
\\	backslash
\n	newline
\r	carriage return
\t	tab
\b	word boundary
\f	form feed
```

### Concatenating String

In JavaScript, when the + operator is used with a String value, it is called the concatenation operator. You can build a new string out of other strings by concatenating them together.

Example
```
'My name is Alan,' + ' I concatenate.'
```
#### Note
Watch out for spaces. Concatenation does not add spaces between concatenated strings, so you'll need to add them yourself.

We can also use the += operator to concatenate a string onto the end of an existing string variable. This can be very helpful to break a long string over several lines.

#### Note
Watch out for spaces. Concatenation does not add spaces between concatenated strings, so you'll need to add them yourself.

Example:
```     
var ourStr = "I come first. ";
ourStr += "I come second.";
// ourStr is now "I come first. I come second."
```

Sometimes you will need to build a string, Mad Libs style. By using the concatenation operator (+), you can insert one or more variables into a string you're building.

```
var ourName = "freeCodeCamp";
var ourStr = "Hello, our name is " + ourName + ", how are you?";
// ourStr is now "Hello, our name is freeCodeCamp, how are you?"
```

Just as we can build a string over multiple lines out of string literals, we can also append variables to a string using the plus equals (+=) operator.

Example:
```
var anAdjective = "awesome!";
var ourStr = "freeCodeCamp is ";
ourStr += anAdjective;
// ourStr is now "freeCodeCamp is awesome!"
```

### String properties

#### Length

You can find the length of a String value by writing .length after the string variable or string literal.

```"Alan Peter".length; // 10```

For example, if we created a variable var firstName = "Charles", we could find out how long the string "Charles" is by using the firstName.length property.

#### Bracket Notation

Bracket notation is a way to get a character at a specific index within a string.

Most modern programming languages, like JavaScript, don't start counting at 1 like humans do. They start at 0. This is referred to as Zero-based indexing.

For example, the character at index 0 in the word "Charles" is "C". So if var firstName = "Charles", you can get the value of the first letter of the string by using firstName[0].

In order to get the last letter of a string, you can subtract one from the string's length.

For example, if var firstName = "Charles", you can get the value of the last letter of the string by using ```firstName[firstName.length - 1].```

You can use the same principle we just used to retrieve the last character in a string to retrieve the Nth-to-last character.

For example, you can get the value of the third-to-last letter of the var firstName = "Charles" string by using ```firstName[firstName.length - 3]```

#### String Immutablility 

In JavaScript, String values are immutable, which means that they cannot be altered once created.

For example, the following code:
```
var myStr = "Bob";
myStr[0] = "J";
```
cannot change the value of myStr to "Job", because the contents of myStr cannot be altered. Note that this does not mean that myStr cannot be changed, just that the individual characters of a string literal cannot be changed. The only way to change myStr would be to assign it with a new string, like this:
```
var myStr = "Bob";
myStr = "Job";
```