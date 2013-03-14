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


  onComplete: (func) ->
    @onCompleteFunc = func


  update: (dt) ->
    @curTime += dt
    if @curTime > @duration
      @curTime = @duration
      @updateProps @obj, @props, @initialProps
      @finished = true
    else
      @updateProps @obj, @props, @initialProps

    if @finished
      evt = {type:'tweenFinished', origin:this}
      Event.dispatchEvent evt
      if @onCompleteFunc
        @onCompleteFunc()
      return


  updateProps: (obj, props, initProps) ->
    for k, v of props
      ratio = @curTime*1.0/@duration
      if $.isNumeric v
        initialValue = initProps[k]
        obj[k] = initialValue + ratio*(v-initialValue)
      else
        @updateProps obj[k], props[k], initProps[k]

