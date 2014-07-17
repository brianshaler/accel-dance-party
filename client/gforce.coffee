define ->
  (xyz, minForce = 0.5) ->
    {x, y, z} = xyz
    if minForce > Math.abs x
      x = 0
    if minForce > Math.abs y
      y = 0
    if minForce > Math.abs z
      z = 0
    g = Math.sqrt x * x + y * y + z * z
    g /= 9.81
    dir =
      lng: Math.atan2 y, x
      lat: Math.atan2 z, Math.sqrt x * x + y * y
    {g: g, dir: dir}
