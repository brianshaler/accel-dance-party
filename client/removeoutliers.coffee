define ['lodash'], (_) ->
  (values) ->
    tolerance = 0.1
    counts = []
    most = 0
    for value in values
      count = 0
      nearby = _.filter values, (v) ->
        tolerance > Math.abs 1 - v / value
      count = nearby.length
      counts.push
        count: count
        value: value
      if count > counts[most].count
        most = counts.length - 1
    _.filter values, (value) ->
      value > counts[most].value * (1 - tolerance) and value < counts[most].value * (1 + tolerance)