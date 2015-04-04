The Build Process
-----------------

#### Build CheJS on the command line

```bash
npm run build
```

Which runs: 

```bash
cat src/*.litcoffee | coffee --stdio --literate --compile > build/che.js
```

#### Build with tests and watch for changes

```bash
npm run watch
```

Which runs: 

```bash
nodemon -x "cat src/*.litcoffee test/*.litcoffee | coffee -slc > build/test/che-with-test.js" -e litcoffee -w src -w test
```

Or verbosely: 

```bash
nodemon --exec "\
  cat src/*.litcoffee test/*.litcoffee |\
  coffee --stdio --literate --compile > build/test/che-with-test.js\
" --ext litcoffee --watch src --watch test
```

Which means: 

1.  Invoke `nodemon`, and pass it some doublequoted code to execute
2.  Concatenate litcoffee files in ‘src/’ and ‘test/’, and pipe that to...
3.  The CoffeeScript compiler:
    - `--stdio` Use stdin and stdout, instead of files
    - `--literate` Treat stdin as Literate CoffeeScript
    - `--compile` Compile stdin to stdout
    - `>` Send stdout to ‘build/test/che-with-test.js’
4.  Watch litcoffee files in ‘src/’ and ‘test/’ for changes



