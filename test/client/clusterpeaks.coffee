path = require 'path'
should = require 'should'
requirejs = require 'requirejs'
require 'mocha'

requirejs.config
  nodeRequire: require

clusterpeaks = requirejs path.resolve __dirname, '../../public/js/clusterpeaks.js'

strRepeat = (str, ln) ->
  output = ''
  for i in [1..ln] by 1
    output += str
  output

describe 'clusterpeaks', ->
  
  it 'should return 1 item', ->
    points = [
      {time: 1, g: 0.9}
      {time: 100, g: 0.8}
      {time: 101, g: 0.7}
      {time: 200, g: 0.6}
      {time: 300, g: 0.8}
      {time: 400, g: 0.9}
    ]
    points = clusterpeaks points
    should.exist points
    points.length.should.equal 1

  it 'should return 1 item', ->
    points = [
      {
        time: 1405531514355
        g: 0.6921206073121441
      },
      {
        time: 1405531514403
        g: 0.6921206073121441
      }
    ]
    points = clusterpeaks points
    should.exist points
    points.length.should.equal 1

  it 'should not suck', ->
    data = require path.resolve @fixtures, './peaks.json'
    data.length.should.equal 108
    clustered = clusterpeaks data
    for item in data
      console.log strRepeat '=', item.g*10
    for item in clustered
      console.log strRepeat '=', item.g*10
    clustered.length.should.equal 33
