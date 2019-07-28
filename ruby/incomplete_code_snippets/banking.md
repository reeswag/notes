## <a name='Banking'></a>Banking
The aim is to produce a script that offers the user two choices. 
1. Open a new account --> save this account to a file or database
2. Access a pre-existing account --> read balance/ withdraw / deposit --> Save balance to database
3. Close a pre-existing account --> delete all records of the account on the database, without removing records of other accounts and balances. 
```
puts "Please Select Option.\n 1. Open Account\n 2. Access Account\n 3. Close Account"
splash_screen_selection = gets.chomp.to_i

class Account
  attr_reader :name
  attr_reader :balance
  def initialize(name, balance=100)
    @name = name
    @balance = balance
  end
  
  public
  
  def display_balance(pin_number)
    puts pin_number == pin ? "Balance: $#{@balance}." : pin_error
  end
  
  def withdraw(pin_number, amount)
    if pin_number == pin
      @balance -= amount
      puts "Withdrew #{amount}. New balance: $#{@balance}." 
		else	puts pin_error
		end 
  end
  
  private
  
  def pin 
    @pin = 1234
  end
  
 	def pin_error
    return "Access denied: incorrect PIN."
  end
end

if splash_screen_selection == 1
  puts "Username:..."
  user = gets.chomp
  user2 = 
  puts "Opening Balance..."
  opening_balance = gets.chomp.to_i
  checking_account = Account.new(user, opening_balance)
else if splash_screen_selection == 2

checking_account = Account.new("wr", 6000000)
```
--------