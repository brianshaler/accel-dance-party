define ['lodash', './gforce.js', './clusterpeaks.js'], (_, gforce, clusterpeaks) ->
  (points, above = 1.2, below = 0.9) ->
    items = _.map points, (point) ->
      {g, dir} = gforce point
      {g: g, dir: dir, time: point.time}
    items = _.filter items, (item) ->
      item.g < below or item.g > above
    _items = _.map items, (item) ->
      {g: Math.round(item.g*1000)/1000, time: item.time - items[0].time}
    clusterpeaks items, 800
