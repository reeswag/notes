# Manipulating Time

```
get '/what/time/is/it/in/:number/hours' do
number = params[:number].to_i
time = Time.now + number * 3600 # the hours is converted to seconds and added to the current time
"The time in #{number} hours will be #{time.strftime('%I:%M %p')}" end
```


### strftime(p1) public
Formats time according to the directives in the given format string.

The directives begin with a percent (%) character. Any text not listed as a directive will be passed through to the output string

### eg
```
t = Time.new(2007,11,19,8,37,48,"-06:00") #=> 2007-11-19 08:37:48 -0600
t.strftime("Printed on %m/%d/%Y")   #=> "Printed on 11/19/2007"
t.strftime("at %I:%M%p")            #=> "at 08:37AM"
```