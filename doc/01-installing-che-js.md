Installing CheJS
----------------

Old fashioned browser install, providing `window.Che`: 
```html
<script src="http://che-js.richplastow.com/build/che.js"></script>
<script>console.log( new window.Che().I ); // -> 'Che'</script>
```

Install as a [CommonJS Module](http://goo.gl/ZrbaB0), eg for 
[Node](https://nodejs.org/): 
```javascript
var Che = require('che');
console.log( new Che().I ); // -> 'Che'
```

Install using [RequireJS inline-style](http://goo.gl/mp7Snw), providing `Che` 
as an argument: 
```html
<script src="lib/require.js"></script>
<script>
  require(['path/to/che'], function(Che) {
    console.log( new Che().I ); // -> 'Che'
  })
</script>
```

See [Browser Install](http://che-js.richplastow.com/usage/browser-install.html) 
for installation examples. 

@todo more installation examples, including `$ npm install che`, etc. 




