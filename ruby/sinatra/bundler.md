# Bundler

Bundler is a program that helps manage all the gems used by an application. It is particularly useful at ensuring that the gems used are the same in development and production. 

Bundler uses a Gemfile to keep track of all the gems used by the application. Create an empty file and save it as Gemfile (no extension). Inside this file, list all the gems that our application uses, like so:

```
source :rubygems
gem "sinatra" 
gem "slim" 
gem "sass"
gem "dm-core"
gem "dm-migrations" gem "thin"
gem "pg", :group => :production
gem "dm-postgres-adapter", :group => :production gem "dm-sqlite-adapter", :group => :development
```

You can specify a certain version or place some gems in groups. Here, we’re using production and development groups to differentiate between the fact that you may be using SQLite locally, while something like Heroku uses PostgreSQL.

Once the Gemfile has been created, we use Bundler to install all these gems, then lock them down to the versions being used with the following command:

```
bundle install --without production
```
This should create a new file called Gemfile.lock that contains all the gems we are using, as well as their dependencies. The --without production flag ensures that any gems that were placed in the production group aren’t installed locally
