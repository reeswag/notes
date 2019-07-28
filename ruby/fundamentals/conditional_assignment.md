## <a name='ConditionalAssignment'></a>Conditional Assignment

We've seen that we can use the = operator to assign a value to a variable. But what if we only want to assign a variable if it hasn't already been assigned? 
For this, we can use the conditional assignment operator: ||=. It's made up of the or (||) logical operator and the normal = assignment operator.

#### <a name='Eg-1'></a>Eg
```
favorite_language ||= "ruby"
puts favorite_language
```
---
