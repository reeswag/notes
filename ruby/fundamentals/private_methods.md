# Private and Protected Methods

http://ruby-for-beginners.rubymonstas.org/advanced/private_methods.html 

https://medium.com/@tjoye20/ruby-access-control-basics-public-vs-private-vs-protected-methods-7788b26e04a7 

Instance variables store data that is “private” to the object. Instance variables are only made accessible to the outside world (we say “it is exposed”) if we add attribute accessors to the class.

In the same way classes sometimes want to keep certain methods private: methods that aren’t supposed to be called from outside of the object. Only the object itself is supposed to use them internally, from other methods.

##Public methods: 

By default, all the methods you define will be public, unless you use the private 0r protected keyword/method to make them not public. Public methods describe the outside (outside of the class definition) behaviors of an object, and are called with the object as the explicit receiver(thing you’re calling the method on: receiver.method). Looking at our Person class below, our #speak method is public, so all instances of that class (read: objects) that you create, can call that #speak method.

### E.G
```
class Person 
  def speak
    puts "Hey, Tj!"
  end 
end 
you = Person.new 
you.speak # "Hey, Tj!" 
```

Private methods: are methods defined under the private keyword/method. Private methods can only be used within the class definition; they’re for internal usage. The only way to have external access to a private method is to call it within a public method. Also, private methods can not be called with an explicit receiver, the receiver is always implicitly self. Think of private methods as internal helper methods.

### E.G

```
class Person
  def speak
    puts "Hey, Tj!"
  end

  def whisper_louder
    whisper
  end 
  
  private 

  def whisper
    puts "His name's not really 'Tj'." 
  end 

end
you = Person.new 
you.speak # "Hey, Tj!"
a_hater = Person.new
a_hater.speak # "Hey, Tj!"
a_hater.whisper # NoMethodError
a_hater.whisper_louder # "His name's not really 'Tj'."
```

## Protected Methods

A protected method is similar to a private method, with the addition that it can be called with, or without, an explicit receiver, but that receiver is always self (it’s defining class) or an object that inherits from self (ex: is_a?(self)).

### E.G

```

class Person

  def speak
    puts "Hey, Tj!"
  end

  def whisper_louder
    whisper
  end
  
  private

  def whisper
    puts "His name's not really 'Tj'."
  end
  
  protected
  
  def greet
   puts "Hey, wassup!
  end

end

class Me < Person
  def be_nice
    greet 
  end
end

tj = Me.new
tj.be_nice # "Hey, wassup!"
tj.greet # NoMethodError
```

However, if the Me class didn’t inherit from Person, but we still wanted the Me class to have access to the #greet method from Person, what we could’ve done in our Person class was to define our #greet method to use self as #self.greet (see example below). This way, even without inheritance, we’re “protecting” this method to only be called explicitly with a receiver of self or any class that inherits from self:
```
class Person
  def speak
    puts "Hey, Tj!"
  end
  def whisper_louder
    whisper
  end

 privatE
 def whisper
    puts "His name's not really 'Tj'."
 end
 
 protected
 def self.greet
   puts "Hey, wassup!"
 end
end

class Me 
  def be_nice
    Person.greet
  end
end

tj = Me.new
tj.be_nice # "Hey, wassup!"
tj.greet # NoMethodError
```

In the Me class now, our #be_nice method can only call the #greet method by using its Person class as the explicit receiver.
Defining a protected method as self.method_name is especially useful when building a Ruby on Rails app and we want the bulk of our non-response related logic in our Models, as opposed to in our Controllers, following the “fat model, skinny controller” best practice. If you don’t know what I’m talking about right now, it’ll make sense later when you see Ruby on Rails.

In Summary, use private methods for internal usage without a receiver, and protected methods defined as self.method_name for internal usage in other classes whenever inheritance isn’t set up. 