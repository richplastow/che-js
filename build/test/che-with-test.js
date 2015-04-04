// Generated by CoffeeScript 1.9.1

/*! CheJS 0.0.4 //// MIT licence //// che-js.richplastow.com //// */

(function() {
  var A, Che, E, F, I, O, S, Tudor, U, VERSION, env, log, properties, simplify, toType, tudor, validate,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  I = 'CheJS';

  VERSION = '0.0.4';

  A = 'array';

  E = 'error';

  F = 'function';

  O = 'object';

  S = 'string';

  U = 'undefined';

  env = {
    has: {}
  };

  env.has.global = O === typeof global;

  env.has.window = !(O !== typeof window || (env.has.global && global.window));

  env.global = env.has.global && !env.has.window ? global : this;

  log = console.log.bind(console);

  toType = function(x) {
    return {}.toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
  };

  simplify = function(value) {
    switch (toType(value)) {
      case S:
        return value;
      case U:
      case 'null':
        return "[" + value + "]";
      case E:
        return (location(value)) + " " + value.message;
      case A:
        return "[.." + value.length + "..]";
      case F:
        return "[function]";
      default:
        return "" + value;
    }
  };

  properties = function() {
    var key, out, value;
    out = [];
    for (key in this) {
      value = this[key];
      if (F !== toType(value)) {
        out.push(key + ":" + (simplify(value)));
      }
    }
    return out.join('  ');
  };

  validate = function(subject, rules) {
    var errors, j, key, len, mand, rule, test, type, value;
    if (O !== toType(subject)) {
      return ["`subject` is type '" + (toType(subject)) + "' not 'object'"];
    }
    errors = [];
    for (j = 0, len = rules.length; j < len; j++) {
      rule = rules[j];
      key = rule[0], mand = rule[1], type = rule[2], test = rule[3];
      value = subject[key];
      if (void 0 === value) {
        if (mand) {
          errors.push("Key '" + key + "' is mandatory");
        } else {
          continue;
        }
      } else if (type !== toType(value)) {
        errors.push("Key '" + key + "' is type '" + (toType(value)) + "' not '" + type + "'");
      } else if (!test.test(value)) {
        errors.push("Key '" + key + "' fails " + (test.toString()));
      }
    }
    if (errors.length) {
      return errors;
    }
  };

  Che = (function() {
    Che.prototype.I = 'Che';

    Che.prototype.toString = function(renderer) {
      if (renderer) {
        return renderer.call(this);
      } else {
        return "[object " + this.I + "]";
      }
    };

    function Che(opt) {
      if (opt == null) {
        opt = {};
      }
    }

    Che.prototype.reconnect = function() {};

    return Che;

  })();

  if (F === typeof define && define.amd) {
    define(function() {
      return Che;
    });
  } else if (O === typeof module && module && module.exports) {
    module.exports = Che;
  } else {
    env.global.Che = Che;
  }

  Tudor = (function() {
    var invisibles;

    Tudor.prototype.I = 'Tudor';

    Tudor.prototype.toString = function() {
      return "[object " + I + "]";
    };

    Tudor.prototype.jobs = [];

    function Tudor(opt) {
      if (opt == null) {
        opt = {};
      }
      this["do"] = bind(this["do"], this);
      switch (opt.format) {
        case 'html':
          this.header = '<a href="#end" id="top">\u2b07</a>';
          this.footer = '\n<a href="#top" id="end">\u2b06</a>';
          break;
        default:
          this.header = '\u2b07';
          this.footer = '\n\u2b06';
      }
    }

    Tudor.prototype["do"] = function() {
      var actual, double, expect, j, job, len, md, name, ref, result, runner, summary, tallies;
      md = [];
      tallies = [0, 0];
      double = null;
      ref = this.jobs;
      for (j = 0, len = ref.length; j < len; j++) {
        job = ref[j];
        switch (toType(job)) {
          case 'function':
            double = job(double);
            break;
          case 'string':
            md.push(job);
            break;
          case 'array':
            runner = job[0], name = job[1], expect = job[2], actual = job[3];
            result = runner(expect, actual, double);
            if (!result) {
              md.push("\u2713 " + name + "  ");
              tallies[0]++;
            } else {
              md.push("\u2718 " + name + "  ");
              md.push("    " + result + "  ");
              tallies[1]++;
            }
        }
        summary = "  passed " + tallies[0] + "/" + (tallies[0] + tallies[1]) + " ";
        summary += tallies[1] ? '\u2718' : '\u2714';
      }
      md.unshift(this.header + summary);
      md.push(this.footer + summary);
      return md.join('\n');
    };

    Tudor.prototype.page = function(text) {
      return this.jobs.push(("\n\n" + text + "\n=") + (new Array(text.length).join('=')));
    };

    Tudor.prototype.section = function(text) {
      return this.jobs.push(("\n\n" + text + "\n-") + (new Array(text.length).join('-')) + '\n');
    };

    Tudor.prototype.custom = function(tests, runner) {
      var i;
      i = 0;
      while (i < tests.length) {
        if ('function' === toType(tests[i])) {
          this.jobs.push(tests[i]);
        } else {
          this.jobs.push([runner, tests[i], tests[++i], tests[++i]]);
        }
        i++;
      }
      return this.jobs.push('- - -');
    };

    Tudor.prototype.fail = function(result, delivery, expect, types) {
      if (types) {
        result = (invisibles(result)) + " (" + (toType(result)) + ")";
        expect = (invisibles(expect)) + " (" + (toType(expect)) + ")";
      }
      return (invisibles(result)) + "\n    ...was " + delivery + ", but expected...\n    " + (invisibles(expect));
    };

    invisibles = function(value) {
      return value != null ? value.toString().replace(/^\s+|\s+$/g, function(match) {
        return '\u00b7' + (new Array(match.length)).join('\u00b7');
      }) : void 0;
    };

    Tudor.prototype.throws = function(tests) {
      return this.custom(tests, (function(_this) {
        return function(expect, actual, double) {
          var e, error;
          error = false;
          try {
            actual(double);
          } catch (_error) {
            e = _error;
            error = e.message;
          }
          if (!error) {
            return "No exception thrown, expected...\n    " + expect;
          } else if (expect !== error) {
            return _this.fail(error, 'thrown', expect);
          }
        };
      })(this));
    };

    Tudor.prototype.equal = function(tests) {
      return this.custom(tests, (function(_this) {
        return function(expect, actual, double) {
          var e, error, result;
          error = false;
          try {
            result = actual(double);
          } catch (_error) {
            e = _error;
            error = e.message;
          }
          if (error) {
            return "Unexpected exception...\n    " + error;
          } else if (expect !== result) {
            return _this.fail(result, 'returned', expect, result + '' === expect + '');
          }
        };
      })(this));
    };

    Tudor.prototype.is = function(tests) {
      return this.custom(tests, (function(_this) {
        return function(expect, actual, double) {
          var e, error, result;
          error = false;
          try {
            result = actual(double);
          } catch (_error) {
            e = _error;
            error = e.message;
          }
          if (error) {
            return "Unexpected exception...\n    " + error;
          } else if (expect !== toType(result)) {
            return _this.fail("type " + (toType(result)), 'returned', "type " + expect);
          }
        };
      })(this));
    };

    toType = function(x) {
      return {}.toString.call(x).match(/\s([a-z|A-Z]+)/)[1].toLowerCase();
    };

    return Tudor;

  })();

  tudor = new Tudor({
    format: env.has.window ? 'html' : 'plain'
  });

  Che.runTest = tudor["do"];

  tudor.page("`Che` Constructor Usage");

  tudor.section("No `opt` Argument");

  tudor.is([
    "Class is a function", 'function', function() {
      return Che;
    }, function() {
      return new Che;
    }, "Instance is an object", 'object', function(c) {
      return c;
    }
  ]);

  tudor.equal([
    "`toString()` is '[object Che]'", '[object Che]', function(c) {
      return c.toString();
    }, "`toString(properties)` as expected", 'I:Che', function(c) {
      return c.toString(properties);
    }
  ]);

}).call(this);
