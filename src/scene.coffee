class window.Scene extends Component
  constructor: (@canvas, @bgColor='none') ->
    super()
    # A scene should take up the whole canvas
    @setPosition 0, 0
    @setSize @canvas.width, @canvas.height

    if @bgColor != 'none'
      bg = new Rect @position.x, @position.y,
        @size.w, @size.h, @bgColor
      @addChild bg

    # Listen for all js events and convert into our events
    for type of Event.TYPES
      @canvas.addEventListener type, @onEvent.bind this

    # handle mouse move on canvas, to generate mouse over and mouse outs
    @addListener 'mouseMoveScene', ((evt) ->
      evt.type = 'mouseMove'
      @dispatchEvent evt).bind this

    # handle keyboard events
    @addListener 'keyDown', (evt) -> Event.keyDown evt.which
    @addListener 'keyUp', (evt) -> Event.keyUp evt.which

    @context = @canvas.getContext '2d'
    @lastTime = new Date().getTime()
    @gameLoop()


  onEvent: (evt) ->
    newEvt =
      origin: @canvas
      type: Event.TYPES[evt.type]
      button: evt.button
      which: evt.which || evt.keyCode || evt.charCode
      x: evt.offsetX
      y: evt.offsetY
    @dispatchEvent newEvt


  gameLoop: ->
    requestAnimationFrame @gameLoop.bind this
    curTime = new Date().getTime()
    dt = curTime - @lastTime
    @lastTime = curTime

    # handle inputs/events
    while not Event.isEmpty()
      evt = Event.removeFromQueue()
      @handle evt

    # update and draw
    @update dt
    @draw @context


  clear: ->
    @context.clearRect 0, 0, @size.w, @size.h


  draw: (ctx) ->
    @clear()
    super ctx
