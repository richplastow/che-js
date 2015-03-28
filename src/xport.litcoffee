Export Che
==========

Register for AMD, eg [RequireJS](http://requirejs.org/). 

    if F == typeof define and define.amd
      define -> Che

Export for CommonJS, eg [Node](http://goo.gl/Lf84YI). 

    else if O == typeof module and module and module.exports
      module.exports = Che

Otherwise, add Che to global scope, eg `myChe = new window.Che()`. 

    else env.global.Che = Che



