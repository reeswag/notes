## <a name='TestingforExceptions-LRTHW-Ex49'></a>Testing for Exceptions - LRTHW - Ex49

Use exception classes to raise exceptions:

```
class ParserError < Exception
end

def parse_verb(word_list)
    skip(word_list, 'stop')

    if peek(word_list) == 'verb'
        return match(word_list, 'verb')
    else
        raise ParserError.new("Expected a verb next.")
    end
end
```

Doing so is an important part of test driven development as it allows you to write a test that is expected to fail under a given scenario.

Check for an exception by using the function assert_raise from the Test::Unit as follows:

```
assert_raise do
  test_list_3 = [['stop', 'the'],['verb', 'drive'],['noun', 'car']]
  parse_object(test_list_3)
end
```
placing the block of code expected to raise an exception within assert_raise do ... end 

eg:

```
incorrect_sentences = [[['noun', 'car']], 
  [['noun', 'car'], ['noun', 'player']], 
  [['verb', 'eat'], ['verb', 'eat']]
]

incorrect_sentences.each do |x|
  assert_raise do
    parse_sentence(x)
  end
end
```

Here we are testing that each of the array elements returns an expection when the parse_sentence() method is called. 

----
