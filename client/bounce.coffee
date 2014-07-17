define ['jquery', '/js/ring.js'], ($, Ring) ->
  class Bounce
    constructor: (@ip, @hue, @bpm, parent) ->
      @bpm = 0 unless @bpm > 0
      @el = $ '<div>'
      @tag = @ip.replace /\./g, '-'
      @el
      .css
        'background-color': "hsl(#{@hue}, 95%, 50%)"
        width: 0
      .addClass "client client-#{@tag}"
      parent.append @el
      @animating = false
      @animate()
    
    animate: =>
      return if @animating
      return unless @bpm > 0
      @animating = true
      if @bpm > 0
        
        ms = 60000 / @bpm
        ring = new Ring @hue, ms
        
        @el.css
          width: '90%'
          'transition-duration': ms * 0.4 + 'ms'
        setTimeout =>
          @el.css
            width: '0%'
            'transition-duration': ms * 0.6 + 'ms'
          setTimeout =>
            @animating = false
            @animate()
          , ms * 0.6
        , ms * 0.4
    bpm: (bpm) =>
      oldBpm = @bpm
      @bpm = bpm
      if oldBpm == 0 and bpm != 0
        @animate()
  
  Bounce