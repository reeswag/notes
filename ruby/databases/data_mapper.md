# DataMapper

DataMapper is a relatively new entrant into the ORM stable, but is already a popular
option and fits well with Sinatra. It’s written in Ruby and has a really simple syntax that’s easy to come to grips with while allowing you to manipulate the data in your database with ease.


All the data interactions are written in Ruby and don’t require you to get your hands dirty writing any SQL statements (a definite plus—believe me!).
Installing DataMapper is easy; being a Ruby gem, all that’s required is to type the following line into a command prompt:
```
$ gem install data_mapper
```

Since we’ll be using SQLite, we also need to install the adapter for it: 

```
$ gem install dm-sqlite-adapter
```
----
## Usage

At the top of your .rb file :
```
require 'dm-core' 
require 'dm-migrations'
```
The first gem, dm-core, is the main DataMapper gem. 

dm-migrations is an extension that we’ll use later to give us extra functionality.

Next, we need to connect to the database using the following line of code:

```
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
```

This will create a file called development.db in the same location as your .rb file (if it doesn’t already exist), which will store all the database information. 

-----

### Integrating Data_Mapper into Ruby Classes
```
class Song
    include DataMapper::Resource property :id, Serial 
    property :title, String
    property :lyrics, Text
    property :length, Integer
    property :released_on, Date
end 

DataMapper.finalize
```

The line ```include DataMapper::Resource``` links the Song class to DataMapper, which includes the Resource module from the DataMapper gem as a mixin. This is how you make any Ruby class a DataMapper resource.

Our :id uses a special type called Serial, which gives each song an identifier that auto-increments.

The :title is used to store short song titles, which means a string is fine.

As the lyrics could end up being longer than 256 characters for some songs, we’ll use the text type for :lyrics.

:length stores the length of the song in seconds, so we can store this as an integer (we can convert it into minutes and seconds manually if we wish).

:released_on keeps a record of the date of release. The most convenient way to store such information is by using Ruby’s built-in Date class.

The DataMapper.finalize method is required after all classes using DataMapper to check their integrity. It needs to be called before the app starts interacting with any classes. We only have one Song class at the moment, so it can just go at the end of this class definition.

## Updating the database

If at anytime we want to update the database, ie add another property, we simply adapt the relevant class, require the relevant file and run:

```
DataMapper.auto_upgrade!
```
-------