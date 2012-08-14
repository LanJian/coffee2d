class window.Component
  constructor: (x=0, y=0, w=0, h=0) ->
    @position = {x:x, y:y}
    @size = {w:w, h:h}
    # bit hacky, but dispatch a resize event
    @setSize w, h
    @isMouseOver = false
    @children = []
    @listeners = []
    @keyDownHandlers = []
    @zIndex = 0

    @addListener 'resize', @onResize.bind this
    @addListener 'mouseMoveScene', @onMouseMove.bind this


  onResize: ->
    w = @size.w
    h = @size.h
    for c in @children
      cw = c.position.x + c.size.w
      ch = c.position.y + c.size.h
      if  cw > w
        w = cw
      if  ch > h
        h = ch
    @size = {w:w, h:h}

  Array::remove = (e) -> @[t..t] = [] if (t = @indexOf(e)) > -1


  onMouseMove: (evt) ->
    if not @isMouseOver and @containsPoint evt.x, evt.y
      @isMouseOver = true
      newEvt = {type:'mouseOver', x:evt.x, y:evt.y}
      @dispatchEvent newEvt
    else if @isMouseOver and not @containsPoint evt.x, evt.y
      @isMouseOver = false
      newEvt = {type:'mouseOut', x:evt.x, y:evt.y}
      @dispatchEvent newEvt


  addChild: (child) ->
    @children.push child


  removeChild: (childToRemove) ->
    @children.remove childToRemove


  addListener: (type, handler) ->
    @listeners.push(
      type: type
      handler: handler
    )


  dispatchEvent: (evt) ->
    if not evt.x then evt.x = 0
    if not evt.y then evt.y = 0
    if not evt.origin then evt.origin = this
    if not evt.target then evt.target = this
    Event.addToQueue evt


  onKeyDown: (which, handler) ->
    @keyDownHandlers.push {which: which, handler: handler}


  setPosition: (x, y) ->
    @position.x = x
    @position.y = y


  setSize: (w, h) ->
    if w != @size.w or h != @size.w
      @dispatchEvent {type: 'resize'}
    @size.w = w
    @size.h = h


  handle: (evt) ->
    if Event.isMouseEvent evt
      if not @containsPoint evt.x, evt.y
        return
      evt.target = this

    for child in @children
      # transform event coordinates
      evt.x = evt.x - child.position.x
      evt.y = evt.y - child.position.y
      child.handle evt
      # untransform event coordinates
      evt.x = evt.x + child.position.x
      evt.y = evt.y + child.position.y

    #if evt.type == 'click'
      #console.log [this, evt.target, evt.x, evt.y]
    for listener in @listeners
      if evt.type == listener.type
        listener.handler evt



  # x and y are in local coordinates
  containsPoint: (x, y) ->
    rect = new Rect(0, 0, @size.w, @size.h)
    rect.isPointInside x, y


  update: (dt) ->
    for k in @keyDownHandlers
      if Event.isKeyDown k.which
        k.handler()
    child.update dt for child in @children


  draw: (ctx) ->
    ctx.save()
    ctx.translate @position.x, @position.y
    child.draw ctx for child in @children
    ctx.restore()
