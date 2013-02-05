Coffee2D
========

Coffee2D is a HTML5 game engine that abstracts a lot of the things one would need to make a game with HTML5 canvas. It leverages some of the CoffeeScript features like the `class` keyword to integrate better with games written in CoffeeScript.

Coffee2D currently provides:

* Simple scene graphs
* Sprite rendering
* Event handling
* Isometric maps

To get started, check out the code in the [example](https://github.com/LanJian/coffee2d/tree/master/example) folder.

### Usage

Component is the base class for every game object. Every game object should extend Component. Game objects can override `update` and `draw` functions. Every component can add child components. Once added, the components will be automatically added to the game loop to be updated and drawn every frame:

```coffeescript
class Card extends Component
  constructor: (@suit, @value) ->
    super()
    @setSize(50, 80)
    # the rectangle will be drawn automatically
    @addChild new Rect 0, 0, @size.w, @size.h, 'white'

  update: (dt) ->
    # dt is delta time passed since last update
    # (update stuff...)
    super()

  draw: (ctx) ->
    # ctx is the canvas context associated with this scene
    # (draw additional stuff other than the rectangle...)
    super()
```

Scene is a Component. It is the top level component and contains everything else, you can create a scene by passing in the canvas object:

```coffeescript
$(document).ready ->
  canvas = $('#canvas')[0]
  scene = new Scene canvas
```

DOM events on the canvas are handled by the Scene. You can simply add listeners for them:

```coffeescript
unit.addListener 'click', -> unit.select()
# keys are a little different
unit.onKeyDown 39, -> unit.move()
```

Any component can fire events. Non-components can also fire events from the Event class:

```coffeescript
# event origin is automatically set to unit
unit.dispatchEvent {type: 'kill', target: enemy}
enemy.addListener 'kill', (evt) -> if evt.target == enemy then enemy.die()

# can also fire events from Event class, origin will not be set
Event.dispatchEvent {type: 'init'}
```


Todo:
* Audio
* Tweening
* More geometric shapes
* Collision detection
* Physics
