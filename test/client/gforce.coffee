path = require 'path'
should = require 'should'
requirejs = require 'requirejs'
require 'mocha'

requirejs.config
  nodeRequire: require

gforce = requirejs path.resolve __dirname, '../../public/js/gforce.js'

describe 'gforce', ->
  
  it 'should snap to zero', ->
    obj = gforce {x: 0.1, y: -0.1, z: 0.01}
    should.exist obj
    obj.g.should.equal 0
    
    obj = gforce {x: 10.1, y: -10.1, z: 10.01}
    should.exist obj
    obj.g.should.be.greaterThan 0
  
  it 'should be lat:0;lng:0 when x:1', ->
    obj = gforce {x: 1, y: 0, z: 0}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal 0
    obj.dir.lng.should.equal 0
  
  it 'should be lat:0;lng:180 when x:-1', ->
    obj = gforce {x: -1, y: 0, z: 0}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal 0
    Math.abs(obj.dir.lng).should.equal Math.PI
  
  it 'should be lat:90;lng:0 when z:1', ->
    obj = gforce {x: 0, y: 0, z: 1}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal Math.PI / 2

  it 'should be lat:-90;lng:0 when z:-1', ->
    obj = gforce {x: 0, y: 0, z: -1}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal -Math.PI / 2

  it 'should be lat:0;lng:90 when y:1', ->
    obj = gforce {x: 0, y: 1, z: 0}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal 0
    obj.dir.lng.should.equal Math.PI / 2

  it 'should be lat:0;lng:-90 when y:-1', ->
    obj = gforce {x: 0, y: -1, z: 0}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal 0
    obj.dir.lng.should.equal -Math.PI / 2

  it 'should be lat:0;lng:45 when x:1;y:1', ->
    obj = gforce {x: 1, y: 1, z: 0}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal 0
    obj.dir.lng.should.equal Math.PI / 4

  it 'should be lat:45;lng:90 when y:1;z:1', ->
    obj = gforce {x: 0, y: 1, z: 1}
    should.exist obj
    should.exist obj.dir
    obj.dir.lat.should.equal Math.PI / 4
    obj.dir.lng.should.equal Math.PI / 2
