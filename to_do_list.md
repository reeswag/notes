# Ruby

## <a name='TestingwithRandomnessandUserInput'></a>Testing with Randomness and User Input

Explore how to test a scipt which requires user input/ includes exits (is this an issue with using require?)

-----

## <a name='Insertex37glossaryintonotes'></a>Insert ex37 glossary into notes
-----
## <a name='CreateLogicTruthTableindexcards'></a>Create Logic Truth Table index cards

See ex27 of LRTHW

-----

## <a name='SearchgithubforRubyprojects'></a>Search github for Ruby projects
See if you can interpret the scripts written in Ruby and use this to help understand how ruby is practically implimented. 

----
## <a name='Ex24'></a>Ex 24

Look into using % and the importance of the letter following the %. EG:
```
def secret_formula(started)
    jelly_beans = started * 500
    jars = jelly_beans / 1000
    crates = jars / 100
    return jelly_beans, jars, crates
end

start_point = 10000
beans, jars, crates = secret_formula(start_point)

puts "With a starting point of: #{start_point}"
puts "We'd have #{beans} beans. #{jars} jars, and #{crates} crates."

start_point = start_point / 10
puts "We can also do that this way:"
puts "We'd have %s beans, %s jars, and %s crates." % secret_formula(start_point)
```

-----

## <a name='Object-orientatedprogramming'></a>Object-orientated programming
Read about "object-oriented programming" online. Confused? I was too. Do not worry. You will learn enough to be dangerous, and you can slowly learn more later.

----