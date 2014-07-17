path = require 'path'
should = require 'should'
require 'mocha'

getHue = require '../../server/getHue'

describe 'getHue', ->

  it 'should return 0 for first hue', ->
    hue = getHue []
    hue.should.equal 0

  it 'should return hues[0]+50 for second hue', ->
    hue = getHue [0]
    hue.should.equal 50
    hue = getHue [50]
    hue.should.equal 0

  it 'should return most distinct hue for third', ->
    hue = getHue [0, 49]
    hue.should.equal 49 + 26

  it 'should return most distinct hue for third', ->
    hue = getHue [0, 51]
    hue.should.equal 26
