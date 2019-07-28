## <a name='BasicVirtualComputershowcasingtheuseofClasses'></a>Basic Virtual Computer showcasing the use of Classes
```
class Computer
  @@users = {}
  
  def initialize(username, password)
    @username = username
    @password = password
    @files = {}
    @@users[username] = password
  end
  
  def create(filename)
    time = Time.now
    @files = {filename: time}
    puts "A new file was created: #{filename}, at #{time}."
  end
  
  def Computer.get_users
    return @@users
  end
end

my_computer= Computer.new("wr",1234)
my_computer.create("read_me.txt")
puts "Users and Passwords: #{Computer.get_users}"
```
returns:
```
A new file was created: read_me.txt, at 2018-12-31 17:32:35 +0000.
Users and Passwords: {"wr"=>1234}
```
----- 

