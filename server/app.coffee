http = require 'http'
path = require 'path'
fs = require 'fs'
express = require 'express'
Primus = require 'primus'
_ = require 'lodash'
getHue = require './getHue'

app = express()
app.use express.static path.resolve __dirname, '../public'

server = http.createServer app

options =
  transformer: 'socket.io'
primus = new Primus server, options

loggedData = []

clients = []
clientTimeout = 10000

primus.on 'connection', (spark) ->
  ip = spark.address.ip
  client = _.find clients, (c) -> c.ip == ip
  unless client
    client =
      bpm: null
      ip: ip
      t: Date.now()
      hue: getHue _.pluck clients, 'hue'
    clients.push client
  
  spark.write
    type: 'setup'
    client: client
    clients: clients
  
  spark.on 'data', (data) ->
    if data.type == 'error'
      console.log 'Error', data.error
    else if data.type == 'data'
      console.log 'data', data.data
      client.bpm = data.data.bpm
      client.t = Date.now()
      
      clients = _.filter clients, (c) ->
        c.t > Date.now() - clientTimeout
      primus.write
        type: 'clients'
        clients: _.filter clients, (c) -> c.bpm and c.bpm > 0
    else if data.type == 'raw'
      data.data.time = Date.now()
      loggedData.push data.data
      console.log 'raw', JSON.stringify data.data
    else if data.type == 'save'
      console.log 'save', loggedData.length
      filename = path.resolve __dirname, '../data.json'
      str = JSON.stringify loggedData, null, 2
      fs.writeFile filename, str, (err) ->
        console.log 'saved', err
    else
      console.log 'unrecognized', data
    #spark.write msg: data.msg.toLowerCase()

#app.get '/', (req, res, next) ->
#  res.send 'oh yeah'

port = process.env.NODE_PORT ? 3000
console.log "listening on port #{port}"
server.listen port
