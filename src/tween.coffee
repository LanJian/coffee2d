class window.Tween
  constructor: (@obj, @props, @duration) ->
    @curTime = 0
    @initialProps = {}
    @finished = false

    @init()


  init: ->
   for k, v of @props
     @initialProps[k] = {}
     $.extend @initialProps[k], @obj[k]


  update: (dt) ->
    @curTime += dt
    if @curTime > @duration
      @curTime = @duration
      @updateProps @obj, @props, @initialProps
      @finished = true
    else
      @updateProps @obj, @props, @initialProps


  updateProps: (obj, props, initProps) ->
    if @finished
      evt = {type:'tweenFinished', origin:this}
      Event.dispatchEvent evt
      return
    for k, v of props
      ratio = @curTime*1.0/@duration
      if $.isNumeric v
        initialValue = initProps[k]
        obj[k] = initialValue + ratio*(v-initialValue)
      else
        @updateProps obj[k], props[k], initProps[k]

