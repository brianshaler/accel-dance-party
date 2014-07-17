define ['jquery'], ($) ->
  class Ring
    constructor: (@hue, time = 100) ->
      @el = $ '<div>'
      size = 200
      
      @el
      .addClass 'ring'
      .css
        position: 'absolute'
        top: (40 + Math.random()*20) + '%'
        left: (40 + Math.random()*20) + '%'
        width: size + 'px'
        height: size + 'px'
        'border-radius': size + 'px'
        border: "solid 5px hsl(#{@hue}, 95%, 55%)"
        transition: "all #{time / 2000}s ease-out"
        transform: 'scale3d(0, 0, 1)'
        'transform-origin': '50% 50%'
      $ 'body'
      .append @el
      setTimeout =>
        @start time
      , time / 2
    
    start: (time) =>
      @el
      .css
        transform: 'scale3d(1, 1, 1)'
      setTimeout @stop, time / 2
    
    stop: =>
      @el
      .css
        transition: "all 0.5s ease-in"
        transform: "scale3d(2, 2, 1)"
      setTimeout =>
        @el
        .remove()
      , 500
  
  Ring