# Recursive Countdown

We have defined a function called countdown with one parameter (n). The function should use recursion to return an array containing the integers n through 1 based on the n parameter. If the function is called with a number less than 1, the function should return an empty array. For example, calling this function with n = 5 should return the array [5, 4, 3, 2, 1]. Your function must use recursion by calling itself and must not use loops of any kind.

## Solution:

function countdown(n, Array = []) { // Declares an empty local Array variable to push recursive 
  if (n <= 0) {
  return [];
  } else {
    Array.push(n); // pushes n to the array before initiating the recursive funtion
    countdown(n - 1, Array);
    return Array; 
  } 
}