path = require 'path'
should = require 'should'
requirejs = require 'requirejs'
require 'mocha'

requirejs.config
  nodeRequire: require

detect = requirejs path.resolve __dirname, '../../public/js/detect.js'

describe 'detect', ->

  it 'should guess about 60 bpm (1)', ->
    recorded = @bpm60
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 117
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 55
    bpm.should.be.lessThan 65

  it 'should guess about 60 bpm (2)', ->
    recorded = @bpm60
    start = recorded.start + recorded.duration * 0.2
    end = recorded.start + recorded.duration * 0.5
    points = recorded.between start, end
    points.length.should.equal 176
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 55
    bpm.should.be.lessThan 65

  it 'should guess about 60 bpm (3)', ->
    recorded = @bpm60
    start = recorded.start + recorded.duration * 0.3
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 336
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 55
    bpm.should.be.lessThan 65
  
  it 'should guess about 100 bpm (1)', ->
    recorded = @bpm100
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 118
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 95
    bpm.should.be.lessThan 105
  
  it 'should guess about 100 bpm (1)', ->
    recorded = @bpm100
    start = recorded.start + recorded.duration * 0.2
    end = recorded.start + recorded.duration * 0.4
    points = recorded.between start, end
    points.length.should.equal 118
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 95
    bpm.should.be.lessThan 105

  it 'should guess about 100 bpm (2)', ->
    recorded = @bpm100
    start = recorded.start + recorded.duration * 0.5
    end = recorded.start + recorded.duration * 0.8
    points = recorded.between start, end
    points.length.should.equal 169
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 95
    bpm.should.be.lessThan 105

  it 'should guess about 100 bpm (3)', ->
    recorded = @bpm100
    start = recorded.start + recorded.duration * 0.2
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 398
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 95
    bpm.should.be.lessThan 105

  it 'should guess about 120 bpm (1)', ->
    recorded = @bpm120
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 116
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 115
    bpm.should.be.lessThan 130

  it 'should guess about 120 bpm (2)', ->
    recorded = @bpm120
    start = recorded.start + recorded.duration * 0.2
    end = recorded.start + recorded.duration * 0.5
    points = recorded.between start, end
    points.length.should.equal 174
    
    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 115
    bpm.should.be.lessThan 125

  it 'should guess about 120 bpm (3)', ->
    recorded = @bpm120
    start = recorded.start + recorded.duration * 0.3
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 332
    
    bpm = detect points
    should.exist bpm
    
    ###
    _ = require 'lodash'
    gforce = requirejs path.resolve __dirname, '../../public/js/gforce.js'
    console.log _.map points, (point) ->
      {g: gforce(point).g, t: point.time}
    peaks = requirejs path.resolve __dirname, '../../public/js/peaks.js'
    console.log _.map peaks(points), (peak) ->
      {g: peak.g, t: peak.time}
    ###
    
    bpm.should.be.greaterThan 115
    bpm.should.be.lessThan 125

  it 'should guess about 166 bpm (1)', ->
    recorded = @bpm166
    start = recorded.start + recorded.duration * 0.1
    end = recorded.start + recorded.duration * 0.3
    points = recorded.between start, end
    points.length.should.equal 118

    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 161
    bpm.should.be.lessThan 171

  it 'should guess about 166 bpm (2)', ->
    recorded = @bpm166
    start = recorded.start + recorded.duration * 0.2
    end = recorded.start + recorded.duration * 0.5
    points = recorded.between start, end
    points.length.should.equal 176

    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 161
    bpm.should.be.lessThan 171

  it 'should guess about 166 bpm (3)', ->
    recorded = @bpm166
    start = recorded.start + recorded.duration * 0.3
    end = recorded.start + recorded.duration * 0.9
    points = recorded.between start, end
    points.length.should.equal 339

    bpm = detect points
    should.exist bpm
    bpm.should.be.greaterThan 161
    bpm.should.be.lessThan 171
