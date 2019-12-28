# Attribute Manipulation

There are many cases when you need to specify the properties of a class attribute, as in the below example. When you are using user input, it may be necessary to standardise it to a format that is readible by say a database. 

In the below example, a method parses any inputed date strings and converts it into a time object.
```
class Song
    include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :lyrics, Text
    property :length, Integer
    property :released_on, Date 

    def released_on=date
        super Date.strptime(date, '%m/%d/%Y')
    end
end
```
Within a slim form:

```
label for="title" Title:
input#title type="text" name="song[title]" value="#{@song.title}"
label for="length" Length:
input#length type="number" name="song[length]" value="#{@song.length}"
label for="released_on" Date(mm/dd/yyyy):
input#released_on type="text" name="song[released_on]" value="#{@song.released_on.strftime("%e %B %Y") if @song.released_on}"
label for="lyrics" Lyrics:
textarea#lyrics name="song[lyrics]" == @song.lyrics
input type="submit" value="Save Song"
```