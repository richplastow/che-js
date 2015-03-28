Set up `tudor`
==============

Create an instance of `Tudor`, to add tests to. 

    tudor = new Tudor
      format: if env.has.window then 'html' else 'plain'


Allow the `Tudor` instance’s `do()` method to be called using `Che.runTest()`. 

    Che.runTest = tudor.do




