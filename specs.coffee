mocha.ui('bdd')
mocha.reporter('html')
chai.should()
expect = chai.expect

describe "commonjs", ->
  beforeEach ->
    require.modules = {}
    require.cache = {}

  describe "#define", ->
    it "defines module", ->
      require.define 'a': (exports, require, module) ->
        exports.test = 'test'
      module = require('a')
      module.test.should.be.equal 'test'

  describe "#require", ->
    it "throws error if module is not defined", ->
      expect(-> require('does not exist')).to.throw(/not found/)

    it "does not evaluat module until it is required", ->
      spy = sinon.spy()
      require.define "b": (exports, require, module) ->
        spy()
      spy.called.should.not.be.ok
      require "b"
      spy.calledOnce.should.be.ok

    it "evauates only once", ->
      spy = sinon.spy()
      require.define "c": (exports, require, module) ->
        spy()
      require "c"
      spy.calledOnce.should.be.ok
      require "c"
      spy.calledOnce.should.be.ok

    it "registers the name of the module", ->
      require.define "e": (exports, require, module) ->
        module.exports.name = module.id
      e = require "e"
      e.name.should.be.equal "e"
