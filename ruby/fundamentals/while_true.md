## <a name='Whiletrue-infiniteloop'></a>While true - infinite loop

You can use while true to produce an infinite loop within a block. Eg:

``` 
    while true 
        print "> " 
        choice = $stdin.gets.chomp

        if choice == "take honey"
            dead("The bear looks at you then slaps your face off.")
        elsif choice == "taunt bear" && !bear_moved
            puts "The bear has moved from the door. You can go through it now." 
            bear_moved = true
        elsif choice == "taunt bear" && bear_moved 
            dead("The bear gets pissed off and chews your leg off.")
        elsif choice == "open door" && bear_moved 
            gold_room
        else 
            puts "I got no idea what that means."
        end 
    end

```
The above loops back to the user input until another function is called to exit the loop.

Some basic rules for looping:

1. Use a while-loop only to loop forever, and that means probably never. This only applies to Ruby; other languages are different
2. Use a for-loop for all other kinds of looping, especially if there is a fixed or limited number of things to loop over.
----
