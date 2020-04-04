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

## Font Family

You can set which font an element should use, by using the font-family property.

For example, if you wanted to set your h2 element's font to sans-serif, you would use the following CSS:
```
h2 {
  font-family: sans-serif;
}
```
In addition to specifying common fonts that are found on most operating systems, we can also specify non-standard, custom web fonts for use on our website. There are many sources for web fonts on the Internet. For this example we will focus on the Google Fonts library.

Google Fonts is a free library of web fonts that you can use in your CSS by referencing the font's URL.

To import a Google Font, you can copy the font(s) URL from the Google Fonts library and then paste it in your HTML. 

To do this, copy the following code snippet and paste it into the top of your code editor (before the opening style element):

```
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet" type="text/css">
```

Now you can use the Lobster font in your CSS by using Lobster as the FAMILY_NAME as in the following example:
```font-family: FAMILY_NAME, GENERIC_NAME;```.

The GENERIC_NAME is optional, and is a fallback font in case the other specified font is not available. This is covered in the next challenge.

Family names are case-sensitive and need to be wrapped in quotes if there is a space in the name. For example, you need quotes to use the "Open Sans" font, but not to use the Lobster font.

There are several default fonts that are available in all browsers. These generic font families include monospace, serif and sans-serif

When one font isn't available, you can tell the browser to "degrade" to another font.

For example, if you wanted an element to use the Helvetica font, but degrade to the sans-serif font when Helvetica isn't available, you will specify it as follows:
```
p {
  font-family: Helvetica, sans-serif;
}
```

Generic font family names are not case-sensitive. Also, they do not need quotes because they are CSS keywords.

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

Remember that you can apply multiple classes to an element using its class attribute, by separating each class name with a space. For example:
```
<img class="class1 class2">
```
## Sizing Images

CSS has a property called width that controls an element's width. Just like with fonts, we'll use px (pixels) to specify the image's width.

For example, if we wanted to create a CSS class called larger-image that gave HTML elements a width of 500 pixels, we'd use:

```
<style>
  .larger-image {
    width: 500px;
  }
</style>
```

## Borders

CSS borders have properties like style, color and width.

For example, if we wanted to create a red, 5 pixel border around an HTML element, we could use this class:
```
<style>
  .thin-red-border {
    border-color: red;
    border-width: 5px;
    border-style: solid;
  }
</style>
```
You can specify a border-radius with pixels. 

```
border-radius: 10px;
```
or
```
border-radius: 50%;
```
produces a circular border.

## Background Color

