# Box-shadow

The box-shadow property applies one or more shadows to an element.

The box-shadow property takes values for:

- offset-x (how far to push the shadow horizontally from the element),
- offset-y (how far to push the shadow vertically from the element),
- blur-radius,
- spread-radius and
- color, in that order.

The blur-radius and spread-radius values are optional.

Multiple box-shadows can be created by using commas to separate properties of each box-shadow element.

Here's an example of the CSS to create multiple shadows with some blur, at mostly-transparent black colors:
```
box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
```
![](img/2020-05-21-10-21-11.png)