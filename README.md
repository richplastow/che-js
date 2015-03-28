CheJS 0.0.3
===========

Literate CoffeeScript implementation of Che, the ‘Collection of Hot Endpoints’. 

See [che-js.richplastow.com](http://che-js.richplastow.com/) for documentation 
and live usage examples. 




Build
-----

Build CheJS on the command line:  
`$ coffee -j build/che.js -wc src/*.litcoffee`

Build with tests:  
`$ coffee -j build/test/che-with-test.js -wc src/*.litcoffee test/*.litcoffee`




Test
----

Test with [npm](http://goo.gl/UYupZI):  
`$ npm test`

Test on the client:  
Open `test/run-test.html` in a web browser




Install
-------

Node install using CommonJS:
```javascript
var Che = require('che');
console.log( new Che().I ); // -> 'Che'
```

Old fashioned browser install, providing `window.Che`: 
```html
<script src="http://che-js.richplastow.com/build/che.js"></script>
<script>console.log( new window.Che().I ); // -> 'Che'</script>
```

Inline browser install using RequireJS, providing `Che` as an argument: 
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



