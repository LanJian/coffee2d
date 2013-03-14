class window.Tween
  constructor: (@obj, @props, @duration) ->
    @curTime = 0
    @initialProps = {}
    @finished = false

    @init()


  init: ->
   for k, v in @props
     @initialProps[k] = @obj[k]


  update: (dt) ->
    @curTime += dt
    if @curTime > duration
      @finished = true
    @updateProps @obj, @props, @initialProps


  updateProps: (obj, props, initProps) ->
    console.log 'update Tween'
    if @finished
      return
    for k, v in props
      ratio = @curTime*1.0/@duration
      if $.isNumeric v
        initialValue = initProps[k]
        obj[k] = ratio*(v-initialValue)
      else
        @updateProps obj[k], props[k], initProps[k]

