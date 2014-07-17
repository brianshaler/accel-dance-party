window.onMotion = ->

define ['/vendor/lodash/dist/lodash.js'], (_) ->
  primus = new Primus "#{window.location.protocol}://#{window.location.host}"
  
  primus.on 'data', (data) ->
    print 'data' + JSON.stringify data
  
  output = document.getElementById 'data'
  print = (str) ->
    output.innerHTML += str + '\n'
  
  onMotion = (e) ->
    print 'hi'
    print JSON.stringify e.accelerationIncludingGravity
    primus.write
      type: 'raw'
      data: e.accelerationIncludingGravity
  window.onMotion = onMotion
  
  setTimeout ->
    primus.write
      type: 'save'
    window.onMotion = ->
  , 30000
  print 'test'

if window.DeviceMotionEvent
  # Listen for the event and handle DeviceMotionEvent object
  window.addEventListener 'devicemotion', ((e) -> window.onMotion e), false
