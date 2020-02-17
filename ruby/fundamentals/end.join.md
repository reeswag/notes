# end.join()

This is method chaining. Methods in ruby might take zero arguments, some arguments and also some arguments and a block. The latter might be denoted by curly brackets:
```
#              ⇓            ⇓  HERE
[1, 2, 3].each { |e| puts e }

```
or by do-end:

```
#              ⇓⇓            ⇓⇓⇓  HERE
[1, 2, 3].each do |e| puts e end
```

There is some subtle difference between these notations, but it’s currently irrelevant to the subject.

So far so good, methods might be chained. That basically means that the latter method is being called on the result of the former one:
```
#                           ⇓  HERE
[1, 2, 3].map { |e| e ** e }.each { |e| puts e }
```
this is exactly the same as:
```
intermediate_result = [1, 2, 3].map { |e| e ** e }
intermediate_result.each { |e| puts e }
```
As well, methods might be chained while using do-end notation.

And, finally, ruby allows additional spaces [almost] anywhere in the code to improve code readability:
```
#                              ⇓  HERE
[1, 2, 3].map do |e| e ** e end.each do |e| puts e end
```
or
```
[1, 2, 3].map do |e|
  e ** e
end.each do |e|
  puts e
end
```