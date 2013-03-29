$(document).ready ->
  init()

init = ->
  # Make a scene
  canvas = $('#canvas')[0]
  scene = new Scene canvas, 'black'

  # Create a background.
  bg = new Coffee2D.Image 'images/bg.png'
  bg.position.y = 60
  scene.addChild bg

  # Create a sprite sheet of 2 rows.
  spriteSheet = new SpriteSheet 'images/hibiki.png', [
    {length: 25, cellWidth: 67, cellHeight: 97},
    {length: 12, cellWidth: 67, cellHeight: 101}
  ]

  # Create a sprite from the sprite sheet, add 'idle'
  # animation from first row of the spritesheet, and
  # add 'walk' from second row, both at 24 frames
  # per second.
  sprite = new Sprite spriteSheet
  sprite.addAnimation {id: 'idle', row: 0, fps: 1}
  sprite.addAnimation {id: 'walk', row: 1, fps: 24}
  sprite.playOnce 'walk'
  sprite.setPosition 100, 270

  # Add a mouse click listener to stop the animation
  tween = null
  sprite.addListener 'click', ->
    tween = sprite.animateTo {position: {x: sprite.position.x+200}}, 3000
    tween.onComplete ( -> sprite.animateTo {position: {x:100}}, 3000)
    console.log tween
    if sprite.isPlaying
      sprite.stop()
    else
      sprite.play()

  sprite.addListener 'tweenFinished', (evt) ->
    console.log evt.origin
    console.log (evt.origin == tween)

  # Add sprite to the scene
  scene.addChild sprite

  # Add key listeners to move the sprite
  scene.onKeyDown 37, -> # left arrow
    sprite.position.x -= 1
    sprite.play 'walk'
  scene.onKeyDown 39, -> # right arrow
    sprite.position.x += 1
    sprite.play 'walk'
  scene.addListener 'keyUp', ->
    sprite.playOnce 'idle'


  a = {foo: {bar: 2, barr: 3}}
  b = {foo: {bar: 5}}
  console.log a
  for k, v of b
    console.log v
    $.extend true, a[k], v

  console.log a
