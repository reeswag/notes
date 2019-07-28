## <a name='ClassSyntax'></a>Class Syntax

A basic class consists only of the class keyword and the name of the class. Check it out:
```
    class NewClass
      # Class magic here
    end
```
Our NewClass has the ability to create new Ruby objects of class NewClass (just like "Hello!" is a String and 4 is a Fixnum). By convention, class names start with a capital letter and use CamelCase instead of relying_on_underscores.

### <a name='InstanceVariables'></a>Instance Variables
In Ruby, we use @ before a variable to signify that it's an instance variable. This means that the variable is attached to the instance of the class.
```
class Car
  def initialize(make, model) 
    @make = make
    @model = model
  end
end

kitt = Car.new("Pontiac", "Trans Am")
```

The code in the example above creates an instance, kitt, of the class Car. kitt has his own @make ("Pontiac") and @model ("Trans Am"). Those variables belong to the kitt instance, which is why they're called instance variables.

#### <a name='eg-1'></a>eg
```
class Person
  def initialize(name)
    @name = name
  end
end
```
This tells Ruby that whenever it creates a Person, it has to have a name, and each instance of Person will have its own @name.

To inspect the object, we use the terminal command : 

``` 
p 
```
### <a name='Attributereaders'></a>Attribute readers

#### <a name='Askingforinformation'></a>Asking for information

Remember how we initially said that people have the ability to remember their name, and tell it, when asked?

We’ve already implemented the first part of this. Our person instance now knows her name “Ada”.

Let’s look at the second part. You also remember that methods are either questions or commands. We want to add a method that implements answering the question “What’s your name?”.

And it is as simple as this:

class Person
```
def initialize(name)
    @name = name
  end

  def name
    @name
  end
end
```
Before we discuss what this does, let’s look at how we can use our new method. We can now call the method on the person object, like this:
```
person = Person.new("Ada")
puts person.name
```
So this prints the name Ada, and that’s what we want: we can create a new person object, passing a name to it. Once that person has been created we are able to ask for its name, and we’ll get the name back.

How does this work, exactly, under the microscope?

Let’s walk through it, step by step:

On the first line, the object that ends up being assigned to the variable person is an initialized, new instance of the class Person. By “intialized” we mean that the method initialize has already been called, and it already has assigned the string "Ada" to the instance variable @name.

Now this person object has the method name, as defined in the class definition of Person above, and in the second line we call this method: person.name.

When the method name is called, it does nothing else but evaluate the instance variable @name from the object scope. Because this has previously been set to "Ada" it will return this string. And because this is the last line in the method name the method also will return this string.

For that reason the method call person.name returns the string "Ada", which is then passed to puts, which prints it out.

Methods that do nothing else but return a value assigned to an instance variable with the same name are very common.

In fact they are so common that there’s a word for them: they are called “attribute readers”. By “attribute” the Ruby community means an instance variable, so an attribute reader is a method that reads an instance variable.

An attribute reader returns the value of an instance variable.

Another way of looking at this is that an attribute reader is a method that “exposes” an instance variable. It makes it accessible for others. I.e. it allows you to ask for the value of an instance variable with the same name, and does nothing but return its value. Once defined others can ask this object for knowledge that otherwise would be private, and unaccessible.

#### <a name='eg-1'></a>eg
```
class Person
  def initialize(name)
    @name = name
  end
  def name
    @name
  end
end 
matz = Person.new("Yukihiro")
puts "Hello #{matz.name}"
# -> Hello Yukihiro
```
### <a name='ScopeitOut'></a>Scope it Out
Another important aspect of Ruby classes is scope. The scope of a variable is the context in which it's visible to the program.

It may surprise you to learn that not all variables are accessible to all parts of a Ruby program at all times. When dealing with classes, you can have variables that are available everywhere (global variables), ones that are only available inside certain methods (local variables), others that are members of a certain class (class variables), and variables that are only available to particular instances of a class (instance variables).

The same goes for methods: some are available everywhere, some are only available to members of a certain class, and some are only available to particular instance objects.

```
class Computer
  $manufacturer = "Mango Computer, Inc."
  @@files = {hello: "Hello, world!"}
  
  def initialize(username, password)
    @username = username
    @password = password
  end
  
  def current_user
    @username
  end
  
  def self.display_files
    @@files
  end
end

# Make a new Computer instance:
hal = Computer.new("Dave", 12345)

puts "Current user: #{hal.current_user}"
# @username belongs to the hal instance.

puts "Manufacturer: #{$manufacturer}"
# $manufacturer is global! We can get it directly.

puts "Files: #{Computer.display_files}"
# @@files belongs to the Computer class.
```
returns:
```
Current user: Dave
Manufacturer: Mango Computer, Inc.
Files: {:hello=>"Hello, world!"}
```
#### <a name='eg-1'></a>eg
```
class Person
  def initialize(name)
    @name = name
  end
  def name
    @name
  end
end 
$matz = Person.new("Yukihiro")
def define
  puts "Hello #{$matz.name}"
end
define
```
returns
```
Hello Yukihiro
```
### <a name='Inheritance'></a>Inheritance

Inheritance is the process by which one class takes on the attributes and methods of another, and it's used to express an is-a relationship.

In Ruby, inheritance works like this:
```
class DerivedClass < BaseClass
  # Some stuff!
end
```
The derived class is the new class you're making and the base class is the class from which that new class inherits. You can read "<" as "inherits from."

### <a name='Override'></a>Override!
Sometimes you'll want one class that inherits from another to not only take on the methods and attributes of its parent, but to override one or more of them.

For instance, you might have an Email class that inherits from Message. Both classes might have a send method that sends them, but the e-mail version may have to identify valid e-mail addresses and use a bunch of e-mail protocols that Message knows nothing about. Rather than add a send_email method to your derived class and inherit a send method you'll never use, you can instead just explicitly create a send method in the Email class and have it do all the email-sending work.

This new version of send will override (that is, replace) the inherited version for any object that is an instance of Email.

#### <a name='eg-1'></a>eg

```
class Creature
  def initialize(name)
    @name = name
  end
  
  def fight
    puts "#{@name} gives a punch to the chops!"
  end
end

# Add your code below!
class Dragon < Creature
  def fight
    puts "#{@name} breathes fire!"
  end
end
  
carl = Creature.new("Carl")
carl.fight
bruce = Dragon.new("Bruce")
bruce.fight
```
returns:
```
Carl gives a punch to the chops!
Bruce breathes fire!
```

Any given Ruby class can have only one superclass. Some languages allow a class to have more than one parent, which is a model called multiple inheritance. This can get really ugly really fast, which is why Ruby disallows it.

### <a name='AccessingClassAttributes'></a>Accessing Class Attributes
Ruby needs methods in order to access attributes.

#### <a name='eg-1'></a>eg
```
class Person
  def initialize(name, job)
    @name = name
    @job = job
  end
  
  def name
    @name
  end
  
  def job=(new_job)
    @job = new_job
  end
end

new_person = Person.new("Greg", "Builder")
p new_person
new_person.job=("Plumber")
p new_person
```
returns
```
# <Context::Person:0x000000015d7f90 @name="Greg", @job="Builder">
# <Context::Person:0x000000015d7f90 @name="Greg", @job="Plumber">
```
(That name= might look funny, but you're allowed to put an = sign in a method name. That's just a Ruby convention saying, "hey, this method sets a value!")

We can use attr_reader to access a variable and attr_writer to change it. If we write
```
class Person
  attr_reader :name
  attr_writer :name
  def initialize(name)
    @name = name
  end
end
```
Ruby does something like this for us automatically:
```
def name
  @name
end

def name=(value)
  @name = value
end
```
Like magic, we can read and write variables as we please! We just pass our instance variables (as symbols) to attr_reader or attr_writer.

If we want to both read and write a particular variable, there's an even shorter shortcut than using attr_reader and attr_writer. We can use attr_accessor to make a variable readable and writeable in one fell swoop.

```
class Person
  attr_accessor :name
  attr_accessor :job
  
  def initialize(name, job)
    @name = name
    @job = job
  end
end

person = Person.new("greg", "builder")
p person
person.name = "julie"
p person
```
returns
```
# <Context::Person:0x000000015c3658 @name="greg", @job="builder">
# <Context::Person:0x000000015c3658 @name="julie", @job="builder">
```
### <a name='OptionalParameters'></a>Optional Parameters
```
    def initialize(name, balance=100)
      @name = name
      @balance = balance
```

What's that balance=100 doing? It's signifying an optional parameter. Ruby is saying that you can pass one or two arguments to initialize; if you pass two, it uses your balance argument to set @balance; if you only pass a name, balance gets a default value of 100, and that's what gets stored in @balance.

----

## <a name='ClassesandObjects-Ex42'></a>Classes and Objects - Ex 42

A Ruby object has three components: a set of flags, some instance variables, and an associated class. A Ruby class is an object of class Class, which contains all the object things plus a list of methods and a reference to a superclass (which is itself another class). All method calls in Ruby nominate a receiver (which is by default self, the current object). Ruby finds the method to invoke by looking at the list of methods in the receiver's class. If it doesn't find the method there, it looks in the superclass, and then in the superclass's superclass, and so on. If the method cannot be found in the receiver's class or any of its ancestors, Ruby invokes the method method_missing on the original receiver.

### <a name='Object-SpecificClasses'></a>Object-Specific Classes

Ruby allows you to create a class tied to a particular object. In the following example, we create two String objects. We then associate an anonymous class with one of them, overriding one of the methods in the object's base class and adding a new method.

```
a = "hello"
b = a.dup
class <<a
  def to_s
    "The value is '#{self}'"
  end
  def twoTimes
    self + self
  end
end
a.to_s	»	"The value is 'hello'"
a.twoTimes	»	"hellohello"
b.to_s	»	"hello"
```
This example uses the \``class << obj'' notation, which basically says `` build me a new class just for object obj.'' We could also have written it as:

```
a = "hello"
b = a.dup
def a.to_s
  "The value is '#{self}'"
end
def a.twoTimes
  self + self
end
a.to_s	»	"The value is 'hello'"
a.twoTimes	»	"hellohello"
b.to_s	»	"hello"

```
The effect is the same in both cases: a class is added to the object ``a''. This gives us a strong hint about the Ruby implementation: a singleton class is created and inserted as a's direct class. a's original class, String, is made this singleton's superclass.

### <a name='TheSuperMethod'></a>The Super Method

#### <a name='Implicitarguments'></a>Implicit arguments
When a method with arguments is overridden by one of its child classes then a call to super without any argument in the child method will automatically pass the arguments of the child method to the parent method.

Let’s have a look to the following example:
```
class Parent
    def say(message)
        p message
    end
end

class Child < Parent
    def say(message)
        super
    end
end

Child.new.say('Hi Rubyist!') #=> "Hi Rubyist!"
```

1. Here the Child class inherits from the Parent class.

2. The Child class overrides the Parent#say method.

3. Within the Child#say method, we call super without any argument.

4. So, Ruby tries to find a method #say in the ancestor chain of the Child class.

5. Then it passes the message argument to the freshly found method.

But, what if the Parent#say method doesn’t expect any argument ?

#### <a name='supervssuper'></a>super vs super()

Let’s redefine the Parent#say method by removing the message argument

```
class Parent
    def say
        p "I'm the parent"
    end
end

class Child < Parent
    def say(message)
        super
    end
end

Child.new.say('Hi Rubyist!') #=> ArguementError (wrong number of arguments (given 1, expected 0))

```

An ArgumentError is raised because the Parent#say method doesn’t expect any argument.

In effect, the call to super in the Child#say method implicitly passes the message argument from the Child#say method to the Parent#say method.

To avoid this problem, we can explicitly indicate to super to don’t take any argument from the Child#say method.

To do so, we can add parentheses to the super keyword — super()

```
class Parent
    def say
        p "I'm the parent"
    end
end

class Child < Parent
    def say(message)
        super()
    end
end

Child.new.say('Hi!') #=> "I'm the parent"
```

So let’s try to pass a block to our Parent#say method.

#### <a name='Superwithblocks'></a>Super with blocks

Let’s redefine the Parent#say method by adding a yield keyword in it

```
class Parent
    def say
        yield
    end
end

class Child < Parent
    def say
        super
    end
end

Child.new.say {p 'Hi! Glad to know you Parent'} #=> "Hi! Glad to know you Parent"
```

The block passed to the Child.new.say method is implicitly passed to the Parent#say method through the super keyword.

Then we use the yield keyword to catch the block and execute it in the Parent#say method.

#### <a name='Superwiththeancestorschain'></a>Super with the ancestors chain
Let’s make the Parent class inherit from the GrandParent class — which defines the #say method
```
class GrandParent
    def say(message)
        p "GrandParent: #{message}"
    end
end

class Parent < GrandParent
end

class Child < Parent
    def say(message)
        super
    end
end

Child.new.say('Hi Rubyist!') # => "GrandParent: Hi Rubyist!"

```
Here we can see that the super keyword tries to find the #say method in the Parent class.

The Parent class doesn’t define this method.

So super tries to find the #say method in the superclass of the Parent class — the GrandParent class.

The GrandParent class defines the #say method.

So, The 'Hi Rubyist!' argument passed to the Child.new.say method call is implicitly passed to the GrandParent#say method through the super keyword.

Voilà!

####  <a name='Usingsuperwithinitialize'></a>Using super() with initialize
The most common use of super() is actually in initialize functions in base classes. This is usually the only place where you need to do some things in a child, then complete the initialization in the parent. Here's a quick example of doing that in the Child from these examples:

```
class Child < Parent
    def initialize(stuff)
        @stuff = stuff
        super()
    end
end
```

This is the same as the Child.altered example above, except I'm setting some variables in the initialize before having the Parent initialize with its Parent.initialize.

###  <a name='InheritanceVSCompositionLRTHWEx44'></a>Inheritance VS Composition LRTHW Ex 44

Inheritance is useful, but another way to do the exact same thing is just to use other classes and modules, rather than rely on implicit inheritance. If you look at the three ways to exploit inheritance, two of the three involve writing new code to replace or alter functionality. This can easily be replicated by just calling functions in a module. Here's an example of doing this:

```
class Other

  def override()
    puts "OTHER override()"
  end

  def implicit()
    puts "OTHER implicit()"
  end

  def altered()
    puts "OTHER altered()"
  end
end

class Child

  def initialize()
    @other = Other.new()
  end

  def implicit()
    @other.implicit()
  end

  def override()
    puts "CHILD override()"
  end

  def altered()
    puts "CHILD, BEFORE OTHER altered()"
    @other.altered()
    puts "CHILD, AFTER OTHER altered()"
  end
end

son = Child.new()

son.implicit()
son.override()
son.altered()

```

In this code I'm not using the name Parent, since there is not a parent-child is-a relationship. This is a has-a relationship, where Child has-a Other that it uses to get its work done. When I run this I get the following output:

```
$ ruby ex44e.rb
OTHER implicit()
CHILD override()
CHILD, BEFORE OTHER altered()
OTHER altered()
CHILD, AFTER OTHER altered()
```

You can see that most of the code in Child and Other is the same to accomplish the same thing. 

Ruby has another way to do composition using modules and a concept called mixins. You simply create a module with functions that are common to classes and then include them in your class similar to using a require. Here's this same composition example done using modules and mixins.

```

module Other

  def override()
    puts "OTHER override()"
  end

  def implicit()
    puts "OTHER implicit()"
  end

  def Other.altered()
    puts "OTHER altered()"
  end
end

class Child
  include Other

  def override()
    puts "CHILD override()"
  end

  def altered()
    puts "CHILD, BEFORE OTHER altered()"
    Other.altered()
    puts "CHILD, AFTER OTHER altered()"
  end
end

son = Child.new()

son.implicit()
son.override()
son.altered()

```
This is similar to the previous composition example. 

### <a name='WhentoUseInheritanceorComposition'></a>When to Use Inheritance or Composition

The question of "inheritance versus composition" comes down to an attempt to solve the problem of reusable code. You don't want to have duplicated code all over your software, since that's not clean and efficient. Inheritance solves this problem by creating a mechanism for you to have implied features in base classes. Composition solves this by giving you modules and the capability to call functions in other classes.

If both solutions solve the problem of reuse, then which one is appropriate in which situations? The answer is incredibly subjective, but I'll give you my three guidelines for when to do which:

1. Avoid something called "meta-programming" at all costs, as it is too complex to be useful reliably. If you're stuck with it, then be prepared to know the class hierarchy and spend time determining where everything is coming from.
2. Use composition to package up code into modules that are used in many different unrelated places and situations.
3. Use inheritance only when there are clearly related reusable pieces of code that fit under a single common concept or if you have to because of something you're using.

Do not be a slave to these rules. The thing to remember about object-oriented programming is that it is entirely a social convention programmers have created to package and share code. Because it's a social convention, but one that's codified in Ruby, you may be forced to avoid these rules because of the people you work with. In that case, find out how they use things and then just adapt to the situation.

----

