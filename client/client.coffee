window.onMotion = ->

require.config
  paths:
    lodash: '/vendor/lodash/dist/lodash'
    jquery: '/vendor/jquery/dist/jquery'
  
define ['jquery', 'lodash', '/js/detect.js', '/js/gforce.js'], ($, _, detect, gforce) ->
  values = []
  
  debug = document.getElementById 'debug'
  print = (str) ->
    debug.innerHTML = "#{str}\n#{debug.innerHTML}"
  
  primus = new Primus "#{window.location.protocol}://#{window.location.host}"
  
  primus.write
    msg: 'Hello from client'
  
  primus.on 'data', (data) ->
    console.log 'data', data
    if data.type == 'setup'
      {hue} = data.client
      lum = Math.abs hue - 50
      r = .2126
      g = .7152
      b = .0722
      $ 'body'
      .css
        'background-color': "hsl(#{hue}, 95%, 55%)"
  
  sendData = ->
    try
      bpm = detect values
    catch ex
      print ex.message
      console.log ex
      primus.write
        type: 'error'
        error: ex.message
    try
      clear()
      draw _.sortBy values, (v) -> v.time
    catch ex
      print ex.message
      console.log ex
      primus.write
        type: 'error'
        error: ex.message
    bpmEl = document.getElementById 'bpm'
    bpmEl?.innerHTML = parseInt bpm
    
    primus.write
      type: 'data'
      data:
        bpm: bpm
    values = _.filter values, (value) ->
      value.time > Date.now() - 10000
  
  _sendData = _.debounce sendData, 1000, {maxWait: 1000}
  
  canvas = null
  ctx = null
  
  getCtx = ->
    canvas = document.getElementById 'canvas'
    canvas.width = window.innerWidth
    canvas.height = canvas.width / 2
    ctx = canvas.getContext '2d'
  
  clear = ->
    getCtx() unless ctx
    ctx.clearRect 0, 0, canvas.width, canvas.height
  
  draw = (data) ->
    console.log 'drawing'
    times = _.pluck data, 'time'
    gs = _.pluck data, 'g'
    debug.innerHTML = JSON.stringify data, null, 2
    #start = _.min times
    start = Date.now() - 10000
    #end = _.max times
    end = Date.now()
    
    getCtx() unless ctx
    
    #ctx.clearRect 0, 0, canvas.width, canvas.height
    ctx.beginPath()
    ctx.moveTo 0, canvas.height
    #ctx.lineTo w, 0
    maxValue = _.max gs
    return unless data?.length > 0
    for value in data
      x = (value.time - start) / (end-start) * canvas.width
      y = canvas.height - value.g / maxValue * canvas.height
      ctx.lineTo x, y
    ctx.stroke()
  
  setTimeout draw, 1000
  
  onMotion = (e) ->
    console.log 'onMotion', e
    console.log values.length
    valuesEl = document.getElementById 'values'
    valuesEl?.innerHTML = values.length
    {x, y, z} = e.accelerationIncludingGravity
    {g} = gforce e.accelerationIncludingGravity
    values.push
      time: Date.now()
      x: x
      y: y
      z: z
      g: g
    _sendData()
  window.onMotion = onMotion

if window.DeviceMotionEvent
  # Listen for the event and handle DeviceMotionEvent object
  window.addEventListener 'devicemotion', ((e) -> window.onMotion e), false

###
setTimeout ->
  if window.DeviceMotionEvent
    #document.write 'listening for Device motion'
  else
    #document.write 'Device motion not supported'
, 1000
###