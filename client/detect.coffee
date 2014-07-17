define ['lodash', './peaks.js', './removeoutliers.js'], (_, peaks, removeoutliers) ->
  (points) ->
    pks = peaks points
    bpm = 100
    hits = _.filter pks, (peak) ->
      peak.g > 1
    drops = _.filter pks, (peak) ->
      peak.g < 1
    
    deltas = []
    
    hitDeltas = []
    for hit, index in hits
      nextHit = hits[index+1]
      continue unless nextHit
      between = _.filter drops, (drop) ->
        drop.time > hit.time and drop.time < nextHit.time
      delta = nextHit.time - hit.time
      if between.length == 2
        delta /= 2
      hitDeltas.push delta
    hitDeltas = removeoutliers hitDeltas
    
    dropDeltas = []
    for drop, index in drops
      nextDrop = drops[index+1]
      continue unless nextDrop
      between = _.filter hits, (hit) ->
        hit.time > drop.time and hit.time < nextDrop.time
      delta = nextDrop.time - drop.time
      if between.length == 2
        delta /= 2
      deltas.push delta
    dropDeltas = removeoutliers dropDeltas
    
    deltas = hitDeltas.concat dropDeltas
    
    deltas = removeoutliers deltas
    average = (items) ->
      _.reduce(items, ((memo, item) -> memo + item), 0) / items.length
    bpm = 60 / (average(deltas) / 1000)
    Math.round(bpm * 10) / 10
