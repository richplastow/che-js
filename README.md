CheJS 0.0.4
===========

#### Literate CoffeeScript implementation of Che, the ‘Collection of Hot 
Endpoints’

See [che-js.richplastow.com](http://che-js.richplastow.com/) for documentation 
and live usage examples. 




Installing CheJS
----------------

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




Testing CheJS
-------------

Test with [npm](http://goo.gl/UYupZI):  
`$ npm test`

Test on the client:  
Open `test/run-test.html` in a web browser




Installing Build Tools
----------------------

Install `coffee` 1.9.1 on the command line: 
```bash
sudo npm install -g coffee-script
```

Install `nodemon` 1.3.7 on the command line: 
```bash
sudo npm install -g nodemon
```




The Build Process
-----------------

Build CheJS on the command line: 
```bash
cat src/*.litcoffee | coffee --stdio --literate --compile > build/che.js
```

Build with tests and watch for changes: 
```bash
nodemon --exec "\
  cat src/*.litcoffee test/*.litcoffee |\
  coffee --stdio --literate --compile > build/test/che-with-test.js\
" --ext litcoffee --watch src --watch test
```

Which means: 

1. Invoke `nodemon`, and pass it some doublequoted code to execute
2. Concatenate ‘src/*.mammouth’ and ‘test/*.mammouth’ files, and pipe to...
3. ...The CoffeeScript compiler, with:
    - `--stdio` Use stdin and stdout, instead of files
    - `--literate` Treat stdin as Literate CoffeeScript
    - `--compile` Compile stdin to stdout
    - `>` Send stdout to ‘build/test/che-with-test.js’
4. Watch ‘src/*.mammouth’ and ‘test/*.mammouth’ files for changes

Build with tests and watch for changes, all on one line: 
```bash
nodemon -x "cat src/*.litcoffee test/*.litcoffee | coffee -slc > build/test/che-with-test.js" -e litcoffee -w src -w test
```


