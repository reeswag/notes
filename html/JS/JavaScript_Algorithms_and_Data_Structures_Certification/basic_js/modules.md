# Modules, introduction

https://javascript.info/modules-intro 

As our application grows bigger, we want to split it into multiple files, so called “modules”. A module may contain a class or a library of functions for a specific purpose.

For a long time, JavaScript existed without a language-level module syntax. That wasn’t a problem, because initially scripts were small and simple, so there was no need.

But eventually scripts became more and more complex, so the community invented a variety of ways to organize code into modules, special libraries to load modules on demand.

To name some (for historical reasons):

-   AMD – one of the most ancient module systems, initially implemented by the library require.js.
-   CommonJS – the module system created for Node.js server.
-   UMD – one more module system, suggested as a universal one, compatible with AMD and CommonJS.
-   Now all these slowly become a part of history, but we still can find them in old scripts.

The language-level module system appeared in the standard in 2015, gradually evolved since then, and is now supported by all major browsers and in Node.js. So we’ll study the modern JavaScript modules from now on.

## What is a module?
A module is just a file. One script is one module. As simple as that.

Modules can load each other and use special directives export and import to interchange functionality, call functions of one module from another one:

export keyword labels variables and functions that should be accessible from outside the current module.
import allows the import of functionality from other modules.
For instance, if we have a file sayHi.js exporting a function:
```
// 📁 sayHi.js
export function sayHi(user) {
  alert(`Hello, ${user}!`);
}
```
…Then another file may import and use it:
```
// 📁 main.js
import {sayHi} from './sayHi.js';

alert(sayHi); // function...
sayHi('John'); // Hello, John!
```
The import directive loads the module by path ./sayHi.js relative to the current file, and assigns exported function sayHi to the corresponding variable.

Let’s run the example in-browser.

As modules support special keywords and features, we must tell the browser that a script should be treated as a module, by using the attribute ```<script type="module">```.

Like this:
```
Resultsay.jsindex.html
<!doctype html>
<script type="module">
  import {sayHi} from './say.js';

  document.body.innerHTML = sayHi('John');
</script>
```
The browser automatically fetches and evaluates the imported module (and its imports if needed), and then runs the script.

Modules work only via HTTP(s), not in local files
If you try to open a web-page locally, via file:// protocol, you’ll find that import/export directives don’t work. Use a local web-server, such as static-server or use the “live server” capability of your editor, such as VS Code Live Server Extension to test modules.

## Core module features
What’s different in modules, compared to “regular” scripts?

There are core features, valid both for browser and server-side JavaScript.

### Always “use strict”
Modules always use strict, by default. E.g. assigning to an undeclared variable will give an error.
```
<script type="module">
  a = 5; // error
</script>
```
### Module-level scope
Each module has its own top-level scope. In other words, top-level variables and functions from a module are not seen in other scripts.

In the example below, two scripts are imported, and hello.js tries to use user variable declared in user.js, and fails:
```
Resulthello.jsuser.jsindex.html
<!doctype html>
<script type="module" src="user.js"></script>
<script type="module" src="hello.js"></script>
```
Modules are expected to export what they want to be accessible from outside and import what they need.

So we should import user.js into hello.js and get the required functionality from it instead of relying on global variables.

This is the correct variant:
```
Resulthello.jsuser.jsindex.html
import {user} from './user.js';

document.body.innerHTML = user; // John
In the browser, independent top-level scope also exists for each <script type="module">:

<script type="module">
  // The variable is only visible in this module script
  let user = "John";
</script>

<script type="module">
  alert(user); // Error: user is not defined
</script>
```
If we really need to make a window-level global variable, we can explicitly assign it to window and access as window.user. But that’s an exception requiring a good reason.

### A module code is evaluated only the first time when imported
If the same module is imported into multiple other places, its code is executed only the first time, then exports are given to all importers.

That has important consequences. Let’s look at them using examples:

First, if executing a module code brings side-effects, like showing a message, then importing it multiple times will trigger it only once – the first time:
```
// 📁 alert.js
alert("Module is evaluated!");
// Import the same module from different files

// 📁 1.js
import `./alert.js`; // Module is evaluated!

// 📁 2.js
import `./alert.js`; // (shows nothing)
```

In practice, top-level module code is mostly used for initialization, creation of internal data structures, and if we want something to be reusable – export it.

Now, a more advanced example.

Let’s say, a module exports an object:
```
// 📁 admin.js
export let admin = {
  name: "John"
};
```
If this module is imported from multiple files, the module is only evaluated the first time, admin object is created, and then passed to all further importers.

All importers get exactly the one and only admin object:
```
// 📁 1.js
import {admin} from './admin.js';
admin.name = "Pete";

// 📁 2.js
import {admin} from './admin.js';
alert(admin.name); // Pete

// Both 1.js and 2.js imported the same object
// Changes made in 1.js are visible in 2.js
```
So, let’s reiterate – the module is executed only once. Exports are generated, and then they are shared between importers, so if something changes the admin object, other modules will see that.

Such behavior allows us to configure modules on first import. We can setup its properties once, and then in further imports it’s ready.

For instance, the admin.js module may provide certain functionality, but expect the credentials to come into the admin object from outside:
```
// 📁 admin.js
export let admin = { };

export function sayHi() {
  alert(`Ready to serve, ${admin.name}!`);
}
```
In init.js, the first script of our app, we set admin.name. Then everyone will see it, including calls made from inside admin.js itself:
```
// 📁 init.js
import {admin} from './admin.js';
admin.name = "Pete";
Another module can also see admin.name:

// 📁 other.js
import {admin, sayHi} from './admin.js';

alert(admin.name); // Pete

sayHi(); // Ready to serve, Pete!
### import.meta
```
The object import.meta contains the information about the current module.

Its content depends on the environment. In the browser, it contains the url of the script, or a current webpage url if inside HTML:
```
<script type="module">
  alert(import.meta.url); // script url (url of the html page for an inline script)
</script>
```
### In a module, “this” is undefined
That’s kind of a minor feature, but for completeness we should mention it.

In a module, top-level this is undefined.

Compare it to non-module scripts, where this is a global object:
```
<script>
  alert(this); // window
</script>

<script type="module">
  alert(this); // undefined
</script>
```
## Browser-specific features
There are also several browser-specific differences of scripts with type="module" compared to regular ones.

You may want skip this section for now if you’re reading for the first time, or if you don’t use JavaScript in a browser.

### Module scripts are deferred
Module scripts are always deferred, same effect as defer attribute (described in the chapter Scripts: async, defer), for both external and inline scripts.

In other words:

-   downloading external module scripts ```<script type="module" src="..."> ``` doesn’t block HTML processing, they load in parallel with other resources.
-   module scripts wait until the HTML document is fully ready (even if they are tiny and load faster than HTML), and then run.
-   relative order of scripts is maintained: scripts that go first in the document, execute first.
-   As a side-effect, module scripts always “see” the fully loaded HTML-page, including HTML elements below them.

For instance:
```
<script type="module">
  alert(typeof button); // object: the script can 'see' the button below
  // as modules are deferred, the script runs after the whole page is loaded
</script>
```

Compare to regular script below:
```
<script>
  alert(typeof button); // button is undefined, the script can't see elements below
  // regular scripts run immediately, before the rest of the page is processed
</script>

<button id="button">Button</button>
```
Please note: the second script actually runs before the first! So we’ll see undefined first, and then object.

That’s because modules are deferred, so we wait for the document to be processed. The regular script runs immediately, so we see its output first.

When using modules, we should be aware that the HTML page shows up as it loads, and JavaScript modules run after that, so the user may see the page before the JavaScript application is ready. Some functionality may not work yet. We should put “loading indicators”, or otherwise ensure that the visitor won’t be confused by that.

### Async works on inline scripts
For non-module scripts, the async attribute only works on external scripts. Async scripts run immediately when ready, independently of other scripts or the HTML document.

For module scripts, it works on inline scripts as well.

For example, the inline script below has async, so it doesn’t wait for anything.

It performs the import (fetches ./analytics.js) and runs when ready, even if the HTML document is not finished yet, or if other scripts are still pending.

That’s good for functionality that doesn’t depend on anything, like counters, ads, document-level event listeners.
```
<!-- all dependencies are fetched (analytics.js), and the script runs -->
<!-- doesn't wait for the document or other <script> tags -->
<script async type="module">
  import {counter} from './analytics.js';

  counter.count();
</script>
```
###External scripts
External scripts that have type="module" are different in two aspects:

External scripts with the same src run only once:
```
<!-- the script my.js is fetched and executed only once -->
<script type="module" src="my.js"></script>
<script type="module" src="my.js"></script>
```
External scripts that are fetched from another origin (e.g. another site) require CORS headers, as described in the chapter Fetch: Cross-Origin Requests. In other words, if a module script is fetched from another origin, the remote server must supply a header Access-Control-Allow-Origin allowing the fetch.
```
<!-- another-site.com must supply Access-Control-Allow-Origin -->
<!-- otherwise, the script won't execute -->
<script type="module" src="http://another-site.com/their.js"></script>
```
That ensures better security by default.

### No “bare” modules allowed
In the browser, import must get either a relative or absolute URL. Modules without any path are called “bare” modules. Such modules are not allowed in import.

For instance, this import is invalid:
```
import {sayHi} from 'sayHi'; // Error, "bare" module
// the module must have a path, e.g. './sayHi.js' or wherever the module is
```
Certain environments, like Node.js or bundle tools allow bare modules, without any path, as they have their own ways for finding modules and hooks to fine-tune them. But browsers do not support bare modules yet.

### Compatibility, “nomodule”
Old browsers do not understand type="module". Scripts of an unknown type are just ignored. For them, it’s possible to provide a fallback using the nomodule attribute:
```
<script type="module">
  alert("Runs in modern browsers");
</script>

<script nomodule>
  alert("Modern browsers know both type=module and nomodule, so skip this")
  alert("Old browsers ignore script with unknown type=module, but execute this.");
</script>
```
## Build tools
In real-life, browser modules are rarely used in their “raw” form. Usually, we bundle them together with a special tool such as Webpack and deploy to the production server.

One of the benefits of using bundlers – they give more control over how modules are resolved, allowing bare modules and much more, like CSS/HTML modules.

Build tools do the following:

-   Take a “main” module, the one intended to be put in ```<script type="module">``` in HTML.
-   Analyze its dependencies: imports and then imports of imports etc.
-   Build a single file with all modules (or multiple files, that’s tunable), replacing native import calls with bundler functions, so that it works. “Special” module types like HTML/CSS modules are also supported.
-   In the process, other transformations and optimizations may be applied:
    -   Unreachable code removed.
    -   Unused exports removed (“tree-shaking”).
    -   Development-specific statements like console and debugger removed.
    -   Modern, bleeding-edge JavaScript syntax may be transformed to older one with similar functionality using Babel.
    -   The resulting file is minified (spaces removed, variables replaced with shorter names, etc).

If we use bundle tools, then as scripts are bundled together into a single file (or few files), import/export statements inside those scripts are replaced by special bundler functions. So the resulting “bundled” script does not contain any import/export, it doesn’t require type="module", and we can put it into a regular script:
```
<!-- Assuming we got bundle.js from a tool like Webpack -->
<script src="bundle.js"></script>
```
That said, native modules are also usable. So we won’t be using Webpack here: you can configure it later.

## Summary
To summarize, the core concepts are:

1. A module is a file. To make import/export work, browsers need ```<script type="module">```. Modules have several differences:
    -   Deferred by default.
    -   Async works on inline scripts.
    -   To load external scripts from another origin (domain/protocol/port), CORS headers are needed.
    -   Duplicate external scripts are ignored.
2. Modules have their own, local top-level scope and interchange functionality via import/export.
3. Modules always use strict.
4. Module code is executed only once. Exports are created once and shared between importers.

When we use modules, each module implements the functionality and exports it. Then we use import to directly import it where it’s needed. The browser loads and evaluates the scripts automatically.

In production, people often use bundlers such as Webpack to bundle modules together for performance and other reasons.

------

# Export and Import

https://javascript.info/import-export 

Export and import directives have several syntax variants.

In the previous article we saw a simple use, now let’s explore more examples.
Export before declarations

We can label any declaration as exported by placing export before it, be it a variable, function or a class.

For instance, here all exports are valid:
```
// export an array
export let months = ['Jan', 'Feb', 'Mar','Apr', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

// export a constant
export const MODULES_BECAME_STANDARD_YEAR = 2015;

// export a class
export class User {
  constructor(name) {
    this.name = name;
  }
}
```
<b>No semicolons after export class/function</b>

Please note that export before a class or a function does not make it a function expression. It’s still a function declaration, albeit exported.

Most JavaScript style guides don’t recommend semicolons after function and class declarations.

That’s why there’s no need for a semicolon at the end of export class and export function:
```
export function sayHi(user) {
  alert(`Hello, ${user}!`);
}  // no ; at the end
```

## Export apart from declarations

Also, we can put export separately.

Here we first declare, and then export:
```
// 📁 say.js
function sayHi(user) {
  alert(`Hello, ${user}!`);
}

function sayBye(user) {
  alert(`Bye, ${user}!`);
}

export {sayHi, sayBye}; // a list of exported variables
```
…Or, technically we could put export above functions as well.

## Import *

Usually, we put a list of what to import in curly braces import {...}, like this:
```
// 📁 main.js
import {sayHi, sayBye} from './say.js';

sayHi('John'); // Hello, John!
sayBye('John'); // Bye, John!
```
But if there’s a lot to import, we can import everything as an object using import * as <obj>, for instance:
```
// 📁 main.js
import * as say from './say.js';

say.sayHi('John');
say.sayBye('John');
```
At first sight, “import everything” seems such a cool thing, short to write, why should we ever explicitly list what we need to import?

Well, there are few reasons.

-   Modern build tools (webpack and others) bundle modules together and optimize them to speedup loading and remove unused stuff.

-   Let’s say, we added a 3rd-party library say.js to our project with many functions:

```
// 📁 say.js
export function sayHi() { ... }
export function sayBye() { ... }
export function becomeSilent() { ... }
```

Now if we only use one of say.js functions in our project:
```
    // 📁 main.js
    import {sayHi} from './say.js';
```
…Then the optimizer will see that and remove the other functions from the bundled code, thus making the build smaller. That is called “tree-shaking”.

-   Explicitly listing what to import gives shorter names: sayHi() instead of say.sayHi().

-   Explicit list of imports gives better overview of the code structure: what is used and where. It makes code support and refactoring easier.

## Import “as”

We can also use as to import under different names.

For instance, let’s import sayHi into the local variable hi for brevity, and import sayBye as bye:
```
// 📁 main.js
import {sayHi as hi, sayBye as bye} from './say.js';

hi('John'); // Hello, John!
bye('John'); // Bye, John!
```
## Export “as”

The similar syntax exists for export.

Let’s export functions as hi and bye:
```
// 📁 say.js
...
export {sayHi as hi, sayBye as bye};
```
Now hi and bye are official names for outsiders, to be used in imports:
```
// 📁 main.js
import * as say from './say.js';

say.hi('John'); // Hello, John!
say.bye('John'); // Bye, John!
```
## Export default

In practice, there are mainly two kinds of modules.

-   Modules that contain a library, pack of functions, like say.js above.
-   Modules that declare a single entity, e.g. a module user.js exports only class User.

Mostly, the second approach is preferred, so that every “thing” resides in its own module.

Naturally, that requires a lot of files, as everything wants its own module, but that’s not a problem at all. Actually, code navigation becomes easier if files are well-named and structured into folders.

Modules provide a special export default (“the default export”) syntax to make the “one thing per module” way look better.

Put export default before the entity to export:
```
// 📁 user.js
export default class User { // just add "default"
  constructor(name) {
    this.name = name;
  }
}
```
There may be only one export default per file.

…And then import it without curly braces:
```
// 📁 main.js
import User from './user.js'; // not {User}, just User

new User('John');
```
Imports without curly braces look nicer. A common mistake when starting to use modules is to forget curly braces at all. So, remember, import needs curly braces for named exports and doesn’t need them for the default one.

|Named export| 	Default export|
|-----|-----|
|```export class User {...}``` |```export default class User {...}```|
|```import {User} from ...```|```import User from ...```|

Technically, we may have both default and named exports in a single module, but in practice people usually don’t mix them. A module has either named exports or the default one.

As there may be at most one default export per file, the exported entity may have no name.

For instance, these are all perfectly valid default exports:
```
export default class { // no class name
  constructor() { ... }
}

export default function(user) { // no function name
  alert(`Hello, ${user}!`);
}

// export a single value, without making a variable
export default ['Jan', 'Feb', 'Mar','Apr', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
```
Not giving a name is fine, because there is only one export default per file, so import without curly braces knows what to import.

Without default, such an export would give an error:
```
export class { // Error! (non-default export needs a name)
  constructor() {}
}
```
## The “default” name

In some situations the default keyword is used to reference the default export.

For example, to export a function separately from its definition:
```
function sayHi(user) {
  alert(`Hello, ${user}!`);
}

// same as if we added "export default" before the function
export {sayHi as default};
```
Or, another situation, let’s say a module user.js exports one main “default” thing, and a few named ones (rarely the case, but it happens):
```
// 📁 user.js
export default class User {
  constructor(name) {
    this.name = name;
  }
}

export function sayHi(user) {
  alert(`Hello, ${user}!`);
}
```
Here’s how to import the default export along with a named one:
```
// 📁 main.js
import {default as User, sayHi} from './user.js';

new User('John');
```
And, finally, if importing everything * as an object, then the default property is exactly the default export:
```
// 📁 main.js
import * as user from './user.js';

let User = user.default; // the default export
new User('John');
```
A word against default exports

Named exports are explicit. They exactly name what they import, so we have that information from them; that’s a good thing.

Named exports force us to use exactly the right name to import:
```
import {User} from './user.js';
// import {MyUser} won't work, the name must be {User}
```
…While for a default export, we always choose the name when importing:
```
import User from './user.js'; // works
import MyUser from './user.js'; // works too
// could be import Anything... and it'll still work
```
So team members may use different names to import the same thing, and that’s not good.

Usually, to avoid that and keep the code consistent, there’s a rule that imported variables should correspond to file names, e.g:
```
import User from './user.js';
import LoginForm from './loginForm.js';
import func from '/path/to/func.js';
```
...

Still, some teams consider it a serious drawback of default exports. So they prefer to always use named exports. Even if only a single thing is exported, it’s still exported under a name, without default.

That also makes re-export (see below) a little bit easier.
## Re-export

“Re-export” syntax export ... from ... allows to import things and immediately export them (possibly under another name), like this:
```
export {sayHi} from './say.js'; // re-export sayHi

export {default as User} from './user.js'; // re-export default
```
Why would that be needed? Let’s see a practical use case.

Imagine, we’re writing a “package”: a folder with a lot of modules, with some of the functionality exported outside (tools like NPM allow us to publish and distribute such packages, but we don’t have to use them), and many modules are just “helpers”, for internal use in other package modules.

The file structure could be like this:
```
auth/
    index.js
    user.js
    helpers.js
    tests/
        login.js
    providers/
        github.js
        facebook.js
        ...
```
We’d like to expose the package functionality via a single entry point, the “main file” auth/index.js, to be used like this:
```
import {login, logout} from 'auth/index.js'
```
The idea is that outsiders, developers who use our package, should not meddle with its internal structure, search for files inside our package folder. We export only what’s necessary in auth/index.js and keep the rest hidden from prying eyes.

As the actual exported functionality is scattered among the package, we can import it into auth/index.js and export from it:
```
// 📁 auth/index.js

// import login/logout and immediately export them
import {login, logout} from './helpers.js';
export {login, logout};

// import default as User and export it
import User from './user.js';
export {User};
...
```

Now users of our package can import {login} from "auth/index.js".

The syntax export ... from ... is just a shorter notation for such import-export:
```
// 📁 auth/index.js
// import login/logout and immediately export them
export {login, logout} from './helpers.js';

// import default as User and export it
export {default as User} from './user.js';
...
```
## Re-exporting the default export

The default export needs separate handling when re-exporting.

Let’s say we have user.js with the export default class User and would like to re-export it:
```
// 📁 user.js
export default class User {
  // ...
}
```
We can come across two problems with it:

-   export User from './user.js' won’t work. That would lead to a syntax error.

-   To re-export the default export, we have to write export {default as User}, as in the example above.

-   export * from './user.js' re-exports only named exports, but ignores the default one.

-   If we’d like to re-export both named and the default export, then two statements are needed:
```
    export * from './user.js'; // to re-export named exports
    export {default} from './user.js'; // to re-export the default export
```
Such oddities of re-exporting a default export are one of the reasons why some developers don’t like default exports and prefer named ones.

## Summary

Here are all types of export that we covered in this and previous articles.

You can check yourself by reading them and recalling what they mean:

|Before declaration of a class/function/…:|Standalone export:|Re-export|
|----|-----|----|
|``` export [default] class/function/variable ...```|``` export {x [as y], ...}.```|```export {x [as y], ...} from "module"``` <br> ```export * from "module" (doesn’t re-export default)``` <br> ```export {default [as y]} from "module" (re-export default)```|

Import:

|Named exports from module:|Default export:|Everything:|Import the module (its code runs), but do not assign it to a variable:|
|----|-----|----|----|
|```import {x [as y], ...} from "module"```|``` import x from "module"```<br>``` import {default as x} from "module"```|``` import * as obj from "module"```|``` import "module"```|

We can put import/export statements at the top or at the bottom of a script, that doesn’t matter.

So, technically this code is fine:
```
sayHi();

// ...

import {sayHi} from './say.js'; // import at the end of the file
```

In practice imports are usually at the start of the file, but that’s only for more convenience.

Please note that import/export statements don’t work if inside {...}.

A conditional import, like this, won’t work:
```
if (something) {
  import {sayHi} from "./say.js"; // Error: import must be at top level
}
```
…But what if we really need to import something conditionally? Or at the right time? Like, load a module upon request, when it’s really needed?