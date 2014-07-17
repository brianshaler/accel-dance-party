require.config
  paths:
    lodash: '/vendor/lodash/dist/lodash'
    jquery: '/vendor/jquery/dist/jquery'
  
define ['jquery', 'lodash', '/js/bounce.js'], ($, _, Bounce) ->
  clients = []
  
  output = document.getElementById 'debug'
  print = ->
    output.innerHTML = JSON.stringify clients, null, 2
  
  primus = new Primus "#{window.location.protocol}://#{window.location.host}"
  
  bounces = []
  updateClients = ->
    for client in clients
      selector = "client-#{client.ip.replace /\./g, '-'}"
      el = $ ".#{selector}"
      bounce = _.find bounces, (b) -> b.ip == client.ip 
      unless bounce
        bounce = new Bounce client.ip, client.hue, client.bpm, $ '#clients'
        bounces.push bounce
      bounce.bpm = client.bpm
      bounce.animate()
  
  _updateClients = _.debounce updateClients, 2000, {maxWait: 2000}
  
  primus.on 'data', (data) ->
    if data.type == 'clients'
      clients = data.clients
      _updateClients()
      print()
