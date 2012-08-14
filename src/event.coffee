class window.Event
   eventQueue = []
   keyDowns = {}

   # A map of js event types to our event types
   @TYPES =
     click: 'click',
     dblclick: 'dblClick',
     mousedown: 'mouseDown',
     mousemove: 'mouseMoveScene',
     mouseup: 'mouseUp',
     mouseover: 'mouseOverScene',
     mouseout: 'mouseOutScene',
     keydown: 'keyDown',
     keypress: 'keyPress',
     keyup: 'keyUp'

   # A list of mouse events that should be sent to
   # the deepest component
   @MOUSE_EVENT_TYPES = [
     'click', 'dblClick',
     'mouseDown', 'mouseMove',
     'mouseUp'
   ]


   @addToQueue: (evt) ->
     eventQueue.splice 0, 0, evt


   @removeFromQueue: ->
     eventQueue.pop()


   @isEmpty: ->
     eventQueue.length == 0


   @dispatchEvent: (evt) ->
     @addToQueue evt


   @isMouseEvent: (evt) ->
     (@MOUSE_EVENT_TYPES.indexOf evt.type) >= 0


   @keyDown: (keyCode) ->
     keyDowns[keyCode] = true


   @keyUp: (keyCode) ->
     delete keyDowns[keyCode]


   @isKeyDown: (keyCode) ->
     keyDowns[keyCode]
