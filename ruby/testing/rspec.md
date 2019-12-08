# Rspec

http://www.betterspecs.org/#describe 

## Background

One of the most popular ruby testing frameworks.

**Domain specific testing** framework - using additional testing language ontop of the Ruby to efficiently test. 

It is a **Behaviour Driven Development** testing framework.

## Installation
```
gem install rpec

cd # project directory

rspec --init
```

## . rspec config

The below config provides a detailed readout of the testing process when rspec is called.

```
--require spec_helper
--format documentation
--color
```

## Rspec Matchers

https://relishapp.com/rspec/rspec-expectations/v/3-8/docs/built-in-matchers 

## Refactoring Tips and Tricks

## Rspec Syntax

### Implicitly Defined Subject Syntax: 
```
require 'car.rb'

describe Car do
  it 'responds to drive' do
    expect(subject).to respond_to :drive
  end
end
```
### One-liner syntax:

```
require 'car.rb'

describe Car do
  it { is_expected.to respond_to :drive }
end
```
vs
```
require 'car.rb'

describe Car do
  it 'responds to drive' do
    expect(subject.to respond_to(:drive))
  end
end
```

Both achieve the same result, but the first approach allows for a more streamlined and opaque test structure. 

### Instance methods

Instance methods are described inside a class body. 

Be clear about what method you are describing. For instance, use the Ruby documentation convention of . (or ::) when referring to a class method's name and # when referring to an instance method's name.

### Doubles

Isolating Tests is crucial to an effiecient and transparent testing framework.

The Double approach uses a dummy object, a double, Unit Tests that interact with other classes. We can define them to act predictably. They will not be affected by bugs that might arise in the classes they're 'standing in' for. You could think of them as 'stunt doubles' for the actual classes they represent.

RSpec provides a sophisticated framework for creating test doubles using the method double(:class). eg:

```
describe 'dock' do
  it 'raises an error when full' do
    subject.capacity.times { subject.dock double :bike }
    expect { subject.dock double(:bike) }.to raise_error 'Docking station full'
  end
end
```
We can add behaviour to these doubles when we create them.

A little secret: it doesn't matter what symbol you use when creating a double using double :symbol. However, we tend to use the name of the doubled class in the symbol. 

#### Syntax:

There are two approaches to double syntax, long and shorthand:

Long:
```
student1 = double(:student) 
allow(student1).to receive(:name) { 'John Smith'}
```
Short:
```
student1 = double(:student, name: 'John Smith )
```

Below is an example of a series of Unit test where interactions between classes are isolated using doubles:

```

describe DockingStation do 
    
    it { is_expected.to respond_to(:release_bike) }
    it { is_expected.to respond_to(:dock_bike).with(1).argument }
    it { is_expected.to respond_to(:bikes) }
  
    describe 'initialization' do

        it 'has a default capacity' do
            expect(subject.capacity).to eq(DockingStation::DEFAULT_DOCK_CAPACITY)
        end

        it 'has an adjustable capacity' do
            test_dock = DockingStation.new(10)
            expect(test_dock.capacity).to eq(10)
        end
    end

    describe '#release_bike' do
        
        it 'releases working bike when available' do
            test_bike = double(:bike, working?: true)
            subject.dock_bike(test_bike)
            expect(subject.release_bike).to eq test_bike
        end

        it 'skips broken bikes' do 
            test_bikes = [double(:bike, working?: true), double(:bike, working?: false), double(:bike, working?: false), double(:bike, working?: true)] 
            test_bikes.each {|x| subject.dock_bike(x)}
            test_working_array = []

            2.times do
                test_working_array.push((subject.release_bike).working?)
            end

            expect(test_working_array).to all(be true)
        end

        it 'raises exception when only broken bikes available' do
            subject.dock_bike(double(:bike, working?: false)) 
            expect{subject.release_bike}.to raise_error 'No Working Bikes Available'
        end

        it 'raises exception when the dock is empty' do
            expect{subject.release_bike}.to raise_error 'Docking Station Empty'
        end  
    end

    describe '#dock_bike' do
        
        it 'docks bike' do
            test_dock_bike = double(:bike, working?: true)
            expect(subject.dock_bike(test_dock_bike)).to include(test_dock_bike)
        end

        it 'fails when number of docked bikes exceedes default capacity' do
            subject.capacity.times { subject.dock_bike(double(:bike)) }
            expect{ subject.dock_bike(double(:bike)) }.to raise_error 'Docking Station Full' 
        end

        it 'assigns docked bikes to an array' do
            test_docked_bike = double(:bike, working?: true) 
            test_docked_bike_2 = double(:bike, working?: true)
            subject.dock_bike(test_docked_bike)
            subject.dock_bike(test_docked_bike_2)
            expect(subject.bikes).to include test_docked_bike && test_docked_bike_2
        end 
    end
    
end

describe Bike do 
   
    it { is_expected.to respond_to :working? }  
    it { is_expected.to respond_to :condition }  

    describe 'initialization' do
        it 'has a default working condition' do
            expect(subject.condition).to eq(Bike::DEFAULT_CONDITION)
        end
    end

    describe '#working?' do
        
        it 'is working by default' do
            expect(subject).to be_working
        end

        it 'returns false for broken bike' do
            subject = Bike.new('broken')
            expect(subject).not_to be_working
        end
    end

end


describe User do

    subject = User.new('Default Username')

    describe 'initialization' do
        
        it 'has a username' do 
            expect(subject.username).to eq('Default Username')
        end

        it 'has a default capacity' do
            expect(subject.capacity).to eq(User::DEFAULT_USER_CAPACITY)
        end
    end


    describe '#hire_bike' do
        
        it 'user accepts released bike from dock' do
            test_bike_3 = double(:bike, working?: true) 
            test_dock_2 = double(:dock, release_bike: test_bike_3)
            subject.hire_bike(test_dock_2)
            expect(subject.user_bikes).to eq([test_bike_3]) # here I am testing that the hire bike method requests a bike from a specific dock and assigns the released bike to the user_bikes array
        end
    end

    describe '#return_bike' do
        
        it 'user returns bike to dock' do
            test_bike_4 = double(:bike, working?: true) 
            test_dock_3 = double(:dock, release_bike: test_bike_4)
            expect(test_dock_3).to receive(:dock_bike).with(test_bike_4)  # tests that the return_bike method call dock_bike for the given dock with the rented bike as an argument
            subject.hire_bike(test_dock_3)
            subject.return_bike(test_dock_3)
        end

        it 'raises exception when the user does not have a bike to return' do
            expect{User.new('Greg)').return_bike(double(:dock))}.to raise_error 'No Bikes Currently Under Hire' 
        end  
    end
end
```

This particular style of testing - where every dependency is mocked out using doubles is called the 'London' style. There is another style called the 'Chicago' style.


#### Chicago Style 

https://blog.ncrunch.net/post/london-tdd-vs-detroit-tdd.aspx 

Chicago style focuses on results. London style focuses on behavior. 

### Before and After Hooks

Use before and after hooks to execute arbitrary code before and/or after
the body of an example is run:
```
before(:example) # run before each example
before(:context) # run one time only, before all of the examples in a group

after(:example) # run after each example
after(:context) # run one time only, after all of the examples in a group

```

eg 

```
require "rspec/expectations"

class Thing
  def widgets
    @widgets ||= []
  end
end

RSpec.describe Thing do
  before(:example) do
    @thing = Thing.new
  end

  describe "initialized in before(:example)" do
    it "has 0 widgets" do
      expect(@thing.widgets.count).to eq(0)
    end

    it "can accept new widgets" do
      @thing.widgets << Object.new
    end

    it "does not share state across examples" do
      expect(@thing.widgets.count).to eq(0)
    end
  end
end
```

before and after blocks are called in the following order:

```
before :suite
before :context
before :example
after  :example
after  :context
after  :suite
```
eg 

```
require "rspec/expectations"

RSpec.configure do |config|
  config.before(:suite) do
    puts "before suite"
  end

  config.before(:context) do
    puts "before context"
  end

  config.before(:example) do
    puts "before example"
  end

  config.after(:example) do
    puts "after example"
  end

  config.after(:context) do
    puts "after context"
  end

  config.after(:suite) do
    puts "after suite"
  end
end

RSpec.describe "ignore" do
  example "ignore" do
  end
end

```
the output should contain:
```
before suite
before context
before example
after example
.after context
after suite
```

## Rspec Sinatra Testing





