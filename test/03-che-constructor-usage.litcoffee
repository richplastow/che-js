`Che` Constructor Usage
=======================

Run passing unit tests on the `Che` constructor. 


    test.page    "`Che` Constructor Usage"

    test.section "No `opt` Argument"

    test.is [

      "Class is a function"
      'function'
      -> Che

      -> new Che

      "Instance is an object"
      'object'
      (c) -> c

    ]

    test.equal [

      "`toString()` is '[object Che]'"
      '[object Che]'
      (c) -> c.toString()

      "`toString(properties)` as expected"
      'I:Che'
      (c) -> c.toString properties

    ]



