# Variables

CSS Variables are a powerful way to change many CSS style properties at once by changing only one value.

To create a CSS variable, you just need to give it a name with two hyphens in front of it and assign it a value like this:

```
--penguin-skin: gray;
```

After you create your variable, you can assign its value to other CSS properties by referencing the name you gave it.
```
background: var(--penguin-skin);
```

When using your variable as a CSS property value, you can attach a fallback value that your browser will revert to if the given variable is invalid.

Note: This fallback is not used to increase browser compatibility, and it will not work on IE browsers. Rather, it is used so that the browser has a color to display if it cannot find your variable.

Here's how you do it:
```
background: var(--penguin-skin, black);
```

This will set background to black if your variable wasn't set. Note that this can be useful for debugging.

## Root Variables and Inheritance

When you create a variable, it is available for you to use inside the selector in which you create it. It also is available in any of that selector's descendants. This happens because CSS variables are inherited, just like ordinary properties.

To make use of inheritance, CSS variables are often defined in the :root element.

:root is a pseudo-class selector that matches the root element of the document, usually the html element. By creating your variables in :root, they will be available globally and can be accessed from any other selector in the style sheet.

When you create your variables in :root they will set the value of that variable for the whole page.

You can then over-write these variables by setting them again within a specific element.