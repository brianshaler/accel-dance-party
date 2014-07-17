path = require 'path'
should = require 'should'
requirejs = require 'requirejs'
require 'mocha'

requirejs.config
  nodeRequire: require

peaks = requirejs path.resolve __dirname, '../../public/js/peaks.js'

###
strRepeat = (str, ln) ->
  output = ''
  for i in [1..ln] by 1
    output += str
  output
###

describe 'peaks', ->
  
  it 'should return 13 peaks from 117 points (60 bpm)', ->
    recorded = @bpm60
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 117
    pks = peaks points
    should.exist pks
    pks.length.should.equal 13

  it 'should return 52 peaks from 453 points (60 bpm)', ->
    recorded = @bpm60
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 453
    pks = peaks points
    should.exist pks
    pks.length.should.equal 52

  it 'should return 20 peaks from 118 points (100 bpm)', ->
    recorded = @bpm100
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 118
    pks = peaks points
    should.exist pks
    pks.length.should.equal 20

  it 'should return 80 peaks from 457 points (100 bpm)', ->
    recorded = @bpm100
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 457
    pks = peaks points
    should.exist pks
    pks.length.should.equal 80

  it 'should return 24 peaks from 116 points (120 bpm)', ->
    recorded = @bpm120
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 116
    pks = peaks points
    should.exist pks
    pks.length.should.equal 24

  it 'should return 70 peaks from 448 points (120 bpm)', ->
    recorded = @bpm120
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 448
    pks = peaks points
    should.exist pks
    pks.length.should.equal 66

  it 'should return 34 peaks from 116 points (166 bpm)', ->
    recorded = @bpm166
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 118
    pks = peaks points
    should.exist pks
    pks.length.should.equal 34

  it 'should return 132 peaks from 448 points (166 bpm)', ->
    recorded = @bpm166
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 457
    pks = peaks points
    should.exist pks
    pks.length.should.equal 132
