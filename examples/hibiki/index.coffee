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
  sprite.addAnimation {id: 'idle', row: 0, fps: 18}
  sprite.addAnimation {id: 'walk', row: 1, fps: 24}
  sprite.play 'idle'
  sprite.setPosition 100, 270

  # Add a mouse click listener to stop the animation
  sprite.addListener 'click', ->
    if sprite.isPlaying
      sprite.stop()
    else
      sprite.play()

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
    sprite.play 'idle'

