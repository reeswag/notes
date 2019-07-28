## <a name='RedactingUser-input'></a>Redacting User-input
What could you do to make sure your redactor redacts a word regardless of whether it's upper case or lower case?
```
puts "Input text to be redacted "
text = gets.chomp
puts "Word to be redacted "
redact = gets.chomp
words = text.split(" ")
words.each do |letter|
  if letter.downcase == redact.downcase
    print "REDACTED "
  else 
    print letter + " "
  end
end
```

## <a name='HowcouldyoumakeyourprogramtakemultipleseparatewordstoREDACT'></a>How could you make your program take multiple, separate words to REDACT?
```
puts "Input text to be redacted "
text = gets.chomp
puts "Input words to be redacted"
redact = gets.chomp
words = text.split(" ")
redacts = redact.split(" ")
words.each do |letter|
 if redact.include? letter
   print "REDACTED "
 else
   print letter + " "
 end
end
```
## <a name='Howmightyoumakeanewredactedstringandsaveitasavariableratherthanjustprintingittotheconsole'></a>How might you make a new redacted string and save it as a variable, rather than just printing it to the console? 

```
puts "Input text to be redacted "
text = gets.chomp
puts "Input words to be redacted"
redact = gets.chomp
words = text.split(" ")
redacts = redact.split(" ")
redacted_string = ""
words.each do |x|
  if redacts.include? x
    redacted_string << "REDACTED "
  else
    redacted_string << (x + " ")
  end
end
puts redacted_string
```