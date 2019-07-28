## <a name='ModuleSyntax'></a>Module Syntax
###  16.1. <a name='WhatsaModule'></a>What's a Module?
You can think of a module as a toolbox that contains a set methods and constants. There are lots and lots of Ruby tools you might want to use, but it would clutter the interpreter to keep them around all the time. For that reason, we keep a bunch of them in modules and only pull in those module toolboxes when we need the constants and methods inside!

You can think of modules as being very much like classes, only modules can't create instances and can't have subclasses. They're just used to store things!

You can pull in pre-existing modules (we'll show you how soon!), but you can also make your own. Modules are super easy to make! You just use the module keyword, like so:
```
module ModuleName
  # Bits 'n pieces
end
```

Like class names, module names are written in CapitalizedCamelCase, rather than lowercase_with_underscores.

It doesn't make sense to include variables in modules, since variables (by definition) change (or vary). Constants, however, are supposed to always stay the same, so including helpful constants in modules is a great idea.

Ruby doesn't make you keep the same value for a constant once it's initialized, but it will warn you if you try to change it. Ruby constants are written in ALL_CAPS and are separated with underscores if there's more than one word.

An example of a Ruby constant is PI, which lives in the Math module and is approximately equal to 3.141592653589793

One of the main purposes of modules is to separate methods and constants into named spaces. This is called (conveniently enough) namespacing, and it's how Ruby doesn't confuse Math::PI and Circle::PI.

See that double colon we just used? That's called the scope resolution operator, which is a fancy way of saying it tells Ruby where you're looking for a specific bit of code. If we say Math::PI, Ruby knows to look inside the Math module to get that PI, not any other PI (such as the one we created in Circle).

### <a name='RequireandInclude'></a>Require and Include
Some modules, like Math, are already present in the interpreter. Others need to be explicitly brought in, however, and we can do this using require. We can do this simply by typing

require 'module'
We want to use the Ruby Date module to show today's date, but we haven't required it yet!
```
require 'date'

puts Date.today
```
returns:
```
2019-01-01
```
We can do more than just require a module, however. We can also include it!

Any class that includes a certain module can use those module's methods!

A nice effect of this is that you no longer have to prepend your constants and methods with the module name. Since everything has been pulled in, you can simply write PI instead of Math::PI.

#### <a name='eg-1'></a>eg
```
class Angle
  include Math
  attr_accessor :radians
  
  def initialize(radians)
    @radians = radians
  end
  
  def cosine
    cos(@radians)
  end
end

acute = Angle.new(1)
acute.cosine
```

### <a name='TheMarriageofModulesandClasses'></a>The Marriage of Modules and Classes
What we did in the last exercise might not have seemed strange to you, but think about it: we mixed together the behaviors of a class and a module!

When a module is used to mix additional behavior and information into a class, it's called a mixin. Mixins allow us to customize a class without having to rewrite code!

#### <a name='eg-1'></a>eg

```
module Action
  def jump
    @distance = rand(4) + 2
    puts "I jumped forward #{@distance} feet!"
  end
end

class Rabbit
  include Action
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Cricket
  include Action
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

peter = Rabbit.new("Peter")
jiminy = Cricket.new("Jiminy")

peter.jump
jiminy.jump
```
returns:
```
I jumped forward 5 feet!
I jumped forward 2 feet!
```

Mixins could give us the ability to mimic inheriting from more than one class: by mixing in traits from various modules as needed, we can add any combination of behaviors to our classes we like!

### <a name='Extend'></a>Extend

Whereas include mixes a module's methods in at the instance level (allowing instances of a particular class to use the methods), the extend keyword mixes a module's methods at the class level. This means that class itself can use the methods, as opposed to instances of the class.

#### <a name='eg-1'></a>eg
```
module ThePresent
  def now
    puts "It's #{Time.new.hour > 12 ? Time.new.hour - 12 : Time.new.hour}:#{Time.new.min} #{Time.new.hour > 12 ? 'PM' : 'AM'} (GMT)."
  end
end

class TheHereAnd
  extend ThePresent
end

TheHereAnd.now

# --> It's 10:56 AM (GMT).
```
## <a name='Ex25-ImportingFunctionsthroughModules'></a>Ex25 - Importing Functions through Modules

Modules can be used to carry across functions between scripts. EG:

```
module Ex25 # saved within ex25.rb
    
    # This function will break up words for us. 
    def Ex25.break_words(stuff)
        words = stuff.split(' ') 
        return words
    end

    # Sorts the words. 
    def Ex25.sort_words(words) 
        return words.sort
    end

    # Prints the first word after shifting it off. 
    def Ex25.print_first_word(words)
        word = words.shift 
        puts word
    end
    # Prints the last word after popping it off. 
    def Ex25.print_last_word(words) 
        word = words.pop 
        puts word
    end

    # Takes in a full sentence and returns the sorted words. 
    def Ex25.sort_sentence(sentence) 
        words = Ex25.break_words(sentence) 
        return Ex25.sort_words(words)
    end
    # Prints the first and last words of the sentence. 
    def Ex25.print_first_and_last(sentence) 
        words = Ex25.break_words(sentence) 
        Ex25.print_first_word(words) 
        Ex25.print_last_word(words)
    end
    # Sorts the words then prints the first and last one. 
    def Ex25.print_first_and_last_sorted(sentence)
        words = Ex25.sort_sentence(sentence) 
        Ex25.print_first_word(words) 
        Ex25.print_last_word(words)
    end 
end
```
Then in the follow up script you 'require' the ruby script to access the functions located within the module. EG:

```
require "./ex25.rb"
sentence = "All good things come to those who wait." 
words = Ex25.break_words(sentence) 
words 
sorted_words = Ex25.sort_words(words)
sorted_words 
Ex25.print_first_word(words) 
Ex25.print_last_word(words) 
words 
Ex25.print_first_word(sorted_words) 
Ex25.print_last_word(sorted_words) 
sorted_words sorted_words = Ex25.sort_sentence(sentence) 
sorted_words Ex25.print_first_and_last(sentence) 
Ex25.print_first_and_last_sorted(sentence)
```
----


