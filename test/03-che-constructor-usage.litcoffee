`Che` Constructor Usage
=======================

Run passing unit tests on the `Che` constructor. 


    tudor.page    "`Che` Constructor Usage"

    tudor.section "No `opt` Argument"

    tudor.is [

      "Class is a function"
      'function'
      -> Che

      -> new Che

      "Instance is an object"
      'object'
      (c) -> c

    ]

    tudor.equal [

      "`toString()` is '[object Che]'"
      '[object Che]'
      (c) -> c.toString()

      "`toString(properties)` as expected"
      'I:Che'
      (c) -> c.toString properties

    ]



