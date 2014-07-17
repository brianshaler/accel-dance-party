_ = require 'lodash'

module.exports = (hues) ->
  if hues.length == 0
    return 0
  if hues.length == 1
    hue = hues[0] + 50
    hue -= 100 if hue >= 100
    return hue
  hues.sort (a, b) -> if a > b then 1 else -1
  diffs = _.map hues, (hue, index) ->
    nextHue = if index >= hues.length - 1
      hues[0] + 100
    else
      hues[index+1]
    diff = nextHue - hue
    {hue: hue, diff: diff}
  diffs.sort (a, b) -> if a.diff > b.diff then -1 else 1
  Math.round diffs[0].hue + diffs[0].diff/2
