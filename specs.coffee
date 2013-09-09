mocha.ui('bdd')
mocha.reporter('html')
chai.should()
expect = chai.expect

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

