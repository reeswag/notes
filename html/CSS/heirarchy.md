# Specificity Heirarchy

If there are two or more conflicting CSS rules that point to the same element, the browser follows some rules to determine which one is most specific and therefore wins out.

Inline styles - An inline style is attached directly to the element to be styled. 

```
Example: <h1 style="color: #ffffff;">.
```

IDs - An ID is a unique identifier for the page elements, such as #navbar.

Classes, attributes and pseudo-classes - This category includes .classes, [attributes] and pseudo-classes such as :hover, :focus etc.

Elements and pseudo-elements - This category includes element names and pseudo-elements, such as h1, div, :before and :after

Equal specificity: the latest rule counts - If the same rule is written twice into the external style sheet, then the lower rule in the style sheet is closer to the element to be styled, and therefore will be applied.

A class selector beats any number of element selectors - a class selector such as .intro beats h1, p, div etc.

NB: It doesn't matter which order the classes are listed in the HTML element. However, the order of the class declarations in the ```<style> ```section is what is important. 

## !important

In many situations, you will use CSS libraries. These may accidentally override your own CSS. So when you absolutely need to be sure that an element has specific CSS, you can use !important

```
  .pink-text {
    color: pink !important;
  }
```