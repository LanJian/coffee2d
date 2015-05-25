Coffee2D
========

Coffee2D is a HTML5 game engine that abstracts a lot of the things one would need to make a game with HTML5 canvas. It leverages some of the CoffeeScript features like the `class` keyword to integrate better with games written in CoffeeScript.

Coffee2D currently provides:

* Simple scene graphs
* Sprite rendering
* Event handling
* Tweening
* Isometric maps

To get started, check out the code in the [example](https://github.com/LanJian/coffee2d/tree/master/example) folder.

To build, run `make clean && make build`. This creates the file `build/engine-all.js`, which can be dropped into any project that wants to use Coffee2D

### Usage

#### Component

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

#### Scene

Scene is a Component. It is the top level component and contains everything else, you can create a scene by passing in the canvas object:

```coffeescript
$(document).ready ->
  canvas = $('#canvas')[0]
  scene = new Scene canvas
```

#### Coordinates

Coordinates are relative to the parent. In this case the rectangle would be draw at x = 20, y = 40 relative to the canvas, but its position is x = 10, y = 20 in its parent component:

```coffeescript
class Parent extends Component
  constructor: ->
    super()

    # add a rectangle
    rect = new Rect 0, 0, 50, 80, 'white'
    @addChild rect

    # set the position of the rectangle
    rect.setPosition 10, 20


$(document).ready ->
  canvas = $('#canvas')[0]
  scene = new Scene canvas

  parent = new Parent
  scene.addChild parent

  # set the position of the parent
  parent.setPosition 10, 20
```

#### DOM Events

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

# Shapes

Rectangles and polygons are supported:

```coffeescript
class Card extends Component
  constructor: (@suit, @value) ->
    super()
    # add a rectangle
    @addChild new Rect 0, 0, 50, 80, 'white'
    # add a diamond shape
    @addChild new Polygon [[25, 0], [50, 40], [25, 80], [0, 40]], 'red'
```

# Sprites

Sprite can be created be created from a sprite sheet. You can assign different sets of animations to the sprite. Please refer to the [hibiki example](https://github.com/LanJian/coffee2d/blob/master/examples/hibiki/index.coffee) for details.

# Isometric Map

You can create isometric maps from a tileset. The tileset is a sprite sheet where each cell is a tile. Please refer to the [isometric map example](https://github.com/LanJian/coffee2d/blob/master/examples/isometric/index.coffee) for details

# Tweening

Create simple animations with tweening. You can tween any numeric property of a Component. You can provide a callback when creating the tween that will be invoked when the tween finishes. On completion, the tween will also create a 'tweenFinished' event:

```coffeescript
# create a tween that animates the unit 200 pixels to the right in 3 seconds
tween = unit.animateTo {position: {x: unit.position.x + 200}}, 3000
# set a onComplete callback
tween.onComplete ( -> unit.attack(enemy))
# you can also listen on the tweenComplete event
commander.addListener 'tweenFinished', (evt) ->
  # tween.obj is the object that the tween was animating, in this case it would
  # be unit
  if evt.origin.obj == tween.obj
    console.log "unit #{tween.obj.name} is in position"
```


Todo:
* Audio
* More geometric shapes
* Collision detection
* Physics
