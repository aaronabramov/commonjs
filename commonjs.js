// git@github.com:rutkovsky/commonjs.git
(function() {
  var cache, modules;

  modules = {};

  cache = {};

  this.require = function(name) {
    var fn, module;
    module = cache[name];
    if (module) {
      return module;
    }
    module = {
      id: name,
      exports: {}
    };
    cache[name] = module.exports;
    fn = modules[name] || (function() {
      throw new Error("module " + name + " not found");
    })();
    fn(module.exports, window.require, module);
    return cache[name] = module.exports;
  };

  this.require.define = function(bundle) {
    var key, value, _results;
    _results = [];
    for (key in bundle) {
      value = bundle[key];
      _results.push(modules[key] = value);
    }
    return _results;
  };

  this.require.modules = modules;

  this.require.cache = cache;

}).call(this);
