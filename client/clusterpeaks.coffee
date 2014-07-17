define ['lodash'], (_) ->
  (points, ms = 400) ->
    #console.log 'clusterpeaks', points
    _.filter points, (point, index) ->
      min = point.time - ms
      max = point.time + ms
      prevPoint = nextPoint = null
      isAbove = point.g > 1
      
      for i in [index-1..0] by -1
        if !prevPoint
          if (isAbove and points[i].g < 1) or (!isAbove and points[i].g > 1)
            prevPoint = points[i]
      
      for i in [index+1..points.length-1] by 1
        if !nextPoint
          if (isAbove and points[i].g < 1) or (!isAbove and points[i].g > 1)
            nextPoint = points[i]
      
      if prevPoint
        min = if min > prevPoint.time then min else prevPoint.time
      
      if nextPoint
        max = if max < nextPoint.time then max else nextPoint.time
      
      greater = _.find points, (p) ->
        if p.time >= min and p.time <= max
          if p.g == point.g and p.time > point.time
            return true
          else if point.g > 1 and p.g > point.g
            return true
          else if point.g < 1 and p.g < point.g
            return true
        false
      
      ###
      if !greater
        console.log 'keep', point.g
      else
        console.log 'filter out', point.g, greater.g
      ###
      
      !greater
