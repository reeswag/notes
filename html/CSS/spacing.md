# Spacing Elements 

Three important properties control the space that surrounds each HTML element: padding, margin, and border.

## Padding

An element's padding controls the amount of space between the element's content and its border.

```
 .red-box {
    background-color: crimson;
    color: #fff;
    padding: 20px;
    margin: 20px;
  }
```
CSS allows you to control the padding of all four individual sides of an element with the padding-top, padding-right, padding-bottom, and padding-left properties.

Instead of specifying an element's padding-top, padding-right, padding-bottom, and padding-left properties individually, you can specify them all in one line, like this:
```
padding: 10px 20px 10px 20px;
```
These four values work like a clock: top, right, bottom, left, and will produce the exact same result as using the side-specific padding instructions.

----
## Margin
An element's margin controls the amount of space between an element's border and surrounding elements.

If you set an element's margin to a negative value, the element will grow larger.

CSS allows you to control the margin of all four individual sides of an element with the margin-top, margin-right, margin-bottom, and margin-left properties.

Instead of specifying an element's margin-top, margin-right, margin-bottom, and margin-left properties individually, you can specify them all in one line, like this:
```
margin: 10px 20px 10px 20px;
```
These four values work like a clock: top, right, bottom, left, and will produce the exact same result as using the side-specific margin instructions.

----
