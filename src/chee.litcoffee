Che
===

The base class for more specialized `Che` subclasses. 




Define the `Che` class
----------------------

    class Che
      I: 'Che'




Allow custom `toString()` renderer
----------------------------------

      toString: (renderer) ->
        if renderer then renderer.call @ else "[object #{@I}]"




Define the constructor
----------------------

      constructor: (opt={}) ->




Define public methods
---------------------

#### `reconnect()`
Xx. 

      reconnect: ->



