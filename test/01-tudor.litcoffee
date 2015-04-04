Tudor
=====

The easy-to-write, easy-to-read test framework. 




Define the `Tudor` class
------------------------

    class Tudor
      I: 'Tudor'
      toString: -> "[object #{I}]"

      jobs: []




Define the constructor
----------------------

      constructor: (opt={}) ->
        switch opt.format
          when 'html'
            @header =   '<a href="#end" id="top">\u2b07</a>'
            @footer = '\n<a href="#top" id="end">\u2b06</a>'
          else
            @header =   '\u2b07'
            @footer = '\n\u2b06'




Define public methods
---------------------

#### `do()`
Run the tests and return the result in markdown format. 

      do: =>
        md = [] # initialize markdown lines
        tallies = [ 0, 0 ] # pass, fail
        double = null
        for job in @jobs
          switch toType job
            when 'function' # replace the previous `double`
              double = job(double)
            when 'string' # eg a '- - -' rule, or a page or section heading
              md.push job
            when 'array' # tests in the form `[ runner, name, expect, actual ]`
              [ runner, name, expect, actual ] = job # dereference
              result = runner(expect, actual, double) # run the test
              if ! result
                md.push "\u2713 #{name}  " # Unicode CHECK MARK
                tallies[0]++ # pass tally
              else
                md.push "\u2718 #{name}  " # Unicode HEAVY BALLOT X
                md.push "    #{result}  "
                tallies[1]++ # fail tally

Generate a summary message.

          summary  = "  passed #{tallies[0]}/#{tallies[0] + tallies[1]} "
          summary += if tallies[1] then '\u2718' else '\u2714'

Return the result as a string. 

        md.unshift @header + summary
        md.push    @footer + summary
        md.join '\n'




#### `page()`
Add a page heading. 

      page: (text) ->
        @jobs.push "\n\n#{text}\n=" + ( new Array(text.length).join '=' )




#### `section()`
Add a section heading. 

      section: (text) ->
        @jobs.push "\n\n#{text}\n-" + ( new Array(text.length).join '-' ) + '\n'




#### `custom()`
Schedule a custom test. 

      custom: (tests, runner) ->
        i = 0
        while i < tests.length
          if 'function' == toType tests[i]
            @jobs.push tests[i]
          else
            @jobs.push [
              runner     # <function>  runner  Function which will run the test
              tests[i]   # <string>    name    A short description of the test
              tests[++i] # <mixed>     expect  Defines a successful test
              tests[++i] # <function>  actual  Produces the result to test
            ]
          i++
        @jobs.push '- - -' # http://goo.gl/TWH3W3




#### `fail()`
Format a typical fail message. 

      fail: (result, delivery, expect, types) ->
        if types
          result = "#{invisibles result} (#{toType result})"
          expect = "#{invisibles expect} (#{toType expect})"
        "#{invisibles result}\n    ...was #{delivery}, but expected...\n    #{invisibles expect}"




#### `invisibles()`
Convert to string, and reveal invisible characters. @todo not just space

      invisibles = (value) ->
        value?.toString().replace /^\s+|\s+$/g, (match) ->
          '\u00b7' + (new Array match.length).join '\u00b7'




#### `throws()`
Expect `actual()` to throw an exception. 

      throws: (tests) ->
        @custom tests, (expect, actual, double) =>
          error = false
          try actual(double) catch e then error = e.message
          if ! error
            "No exception thrown, expected...\n    #{expect}"
          else if expect != error
            @fail error, 'thrown', expect




#### `equal()`
Expect `actual()` and `expect` to be equal. 

      equal: (tests) ->
        @custom tests, (expect, actual, double) =>
          error = false
          try result = actual(double) catch e then error = e.message
          if error
            "Unexpected exception...\n    #{error}"
          else if expect != result
            @fail result, 'returned', expect, (result + '' == expect + '')




#### `is()`
Expect `toType( actual() )` and `expect` to be equal. 

      is: (tests) ->
        @custom tests, (expect, actual, double) =>
          error = false
          try result = actual(double) catch e then error = e.message
          if error
            "Unexpected exception...\n    #{error}"
          else if expect != toType result
            @fail "type #{toType result}", 'returned', "type #{expect}"




#### `toType()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://goo.gl/WlpBEx) instead of JavaScript’s 
familiar `typeof` operator. 

      toType = (x) ->
        ({}).toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()




