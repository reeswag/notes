# Basic CSS

## Color

The property that is responsible for the color of an element's text is the color style property.

Here's how you would set your h2 element's text color to blue:
```
<h2 style="color: blue;">CatPhotoApp</h2>
```
Note that it is a good practice to end inline style declarations with a ```;``` .

This is an example of inline CSS.

## Font Size

Font size is controlled by the font-size CSS property, like this:
```
h1 {
  font-size: 30px;
}
```

## Style Blocks

Instead of inline CSS we can use style blocks to increase the readability of our code.

```
<style>
    h2 {
        color:red;
    }
</style>
```
Note that it's important to have both opening and closing curly braces ({ and }) around each element's style rule(s). You also need to make sure that your element's style definition is between the opening and closing style tags. Finally, be sure to add a semicolon to the end of each of your element's style rules.

## Classes

Classes are reusable syles that can be added to HTML elements.

```
<style>
  .blue-text {
    color: blue;
  }
</style>
```
You can apply a class to an HTML element like this: 
```
<h2 class="blue-text">CatPhotoApp</h2> 
```
Note that in your CSS style element, class names start with a period. In your HTML elements' class attribute, the class name does not include the period.

Classes allow you to assign your classes to multiple elements.