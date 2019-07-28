**Refactoring** is just a fancy way of saying we're improving the structure or appearance of our code without changing what it actually does.

----

**Constants**: A Ruby constant is like a variable, except that its value is supposed to remain constant for the duration of the program. The Ruby interpreter does not actually enforce the constancy of constants, but it does issue a warning if a program changes the value of a constant.
```
A_CONST = 10  
A_CONST = 20  
```
Produces a warning:
```
warning: already initialized constant A_CONST  
```
Lexically, the names of constants look like the names of local variables, except that they begin with a capital letter. By convention, most constants are written in all uppercase with underscores to separate words, LIKE_THIS. Ruby class and module names are also constants, but they are conventionally written using initial capital letters and camel case, LikeThis.