App Scope
=========

Define variables and functions with application-level scope. These are only 
visible to code defined in ‘/src/’ and ‘/test/’. 




Version, licence and homepage notice
------------------------------------

Begin with a comment-block which will be preserved after compilation. The ‘!’ 
tells minifiers to preserve this comment. 

    ###! CheJS 0.0.2 //// MIT licence //// che-js.richplastow.com ////###




Define helper functions
-----------------------

#### `log()`
A handy shortcut for `console.log()`. Note [`bind()`](http://goo.gl/66ffgl). 

    log = console.log.bind console




#### `toType()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://goo.gl/WlpBEx) instead of JavaScript’s 
familiar `typeof` operator.

    toType = (x) ->
      ({}).toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase()




#### `simplify()`
Used by `properties()` to simplify stringified property values. 

    simplify = (value) ->
      switch toType value
        when 'string'
          value
        when 'undefined', 'null'
          "[#{value}]"
        when 'error'
          "#{location value} #{value.message}"
        when 'array'
          "[..#{value.length}..]"
        when 'function'
          "[function]"
        else
          "#{value}"




#### `properties()`
Dump a list of an object’s properties, but not its methods. For example, after 
overriding an object’s `toString()` method like this:  
`toString: (renderer) -> if renderer then cb.call @ else "[object Foo]"`  
...you can dump its properties using:  
`foo.toString properties`

    properties = ->
      out = []
      for key,value of @
        if 'function' != toType value then out.push "#{key}:#{simplify value}"
      out.join '  '




#### `validate()`
Checks whether an object’s keys and values conform to a given set of rules. 
Returns `undefined` if `subject` conforms to the rules. Otherwise, returns an 
array of error messages, one for each broken rule. 

    validate = (subject, rules) ->

      if 'object' != toType subject
        return ["`subject` is type '#{toType subject}' not 'object'"]

Every `rule` must contain four elements:
- `key  <string> ` Specifies the key to be tested
- `mand <boolean>` Whether the key is mandatory
- `type <string> ` The expected result when `toType()` is called on the value
- `test <regexp> ` An object with `test()` and `toString()` methods

Step through each `rule` in the `rules` array. 

      errors = []
      for rule in rules
        [key,mand,type,test] = rule
        value = subject[key]
        if undefined == value
          if mand then errors.push "Key '#{key}' is mandatory" else continue
        else if type != toType value
          errors.push "Key '#{key}' is type '#{toType value}' not '#{type}'"
        else if ! test.test value
          errors.push "Key '#{key}' fails #{test.toString()}"

Return `undefined` for a valid object, or else an array of error messages. 

      if errors.length then errors




