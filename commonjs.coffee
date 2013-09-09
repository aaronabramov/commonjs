modules = {}
cache = {}

@require = (name) ->
  module = cache[name]
  return module if module
  module = {id: name, exports: {}}
  cache[name] = module.exports
  fn = modules[name] or throw new Error "module #{name} not found"
  fn(module.exports, window.require, module)
  cache[name] = module.exports

@require.define = (bundle) ->
  for key, value of bundle
    modules[key] = value

@require.modules = modules
@require.cache = cache
