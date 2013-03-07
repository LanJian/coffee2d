$(document).ready ->
  init()

fullSreen = (canvas) ->
  if canvas.webkitRequestFullScreen
    canvas.webkitRequestFullScreen()
  else
    canvas.mozRequestFullScreen()

init = ->
  # Make a scene
  canvas = $('#canvas')[0]

  $('#fs').on 'click', -> fullSreen canvas

  scene = new Scene canvas, 'black'

  # TODO: more at the end but not same size
  spriteSheet = new SpriteSheet 'images/tileset.png', [
    {length: 10  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64},
    {length: 10 , cellWidth: 64 , cellHeight: 64}
  ]

  map = []
  for i in [0..9]
    map[i] = []
    for j in [0..9]
      map[i][j] = new Tile spriteSheet, 1, 32

  map[7][5].addHeightIndex 54

  map[6][5].addHeightIndex 55
  map[6][4].addHeightIndex 54
  map[5][4].addHeightIndex 55
  map[6][4].addHeightIndex 120

  map[5][5].addHeightIndex 54
  map[5][5].addHeightIndex 54
  map[5][5].addHeightIndex 51

  map[8][5].addHeightIndex 51
  map[8][6].addHeightIndex 50
  map[7][6].addHeightIndex 55

  map[7][4].addHeightIndex 53

  map[4][4].addHeightIndex 54

  # waterfall
  map[4][5].addHeightIndex 62
  map[4][5].addHeightIndex 61
  map[4][5].addHeightIndex 63

  # grass
  map[6][6].addHeightIndex 114
  map[5][6].addHeightIndex 115

  # pond
  map[4][6].addHeightIndex 91
  map[4][7].addHeightIndex 94

  map[8][2].addHeightIndex 120
  map[1][7].addHeightIndex 121

  console.log map

  poly = new Polygon [[32,32], [64,48], [32,64], [0,48]]
  isoMap = new IsometricMap
    spriteSheet      : spriteSheet
    map              : map
    tileWidth        : 64
    tileHeight       : 64
    tileXOffset      : 32
    tileYOffset      : 16
    tileBoundingPoly : poly

  #isoMap.position.x = 300
  console.log isoMap.position, isoMap.size

  scene.addChild isoMap

  #charSpriteSheet = new SpriteSheet 'images/char.png', [
    #{length: 8, cellWidth: 50, cellHeight: 50},
    #{length: 8, cellWidth: 50, cellHeight: 50}
    #{length: 8, cellWidth: 50, cellHeight: 50}
    #{length: 8, cellWidth: 50, cellHeight: 50}
    #{length: 8, cellWidth: 50, cellHeight: 50}
    #{length: 8, cellWidth: 50, cellHeight: 50}
    #{length: 8, cellWidth: 50, cellHeight: 50}
    #{length: 8, cellWidth: 50, cellHeight: 50}
  #]

  #charSprite = new Sprite charSpriteSheet
  #charSprite.addAnimation {id: 'bottomRight', row: 0, fps: 10}
  #charSprite.play 'bottomRight'
  #charSprite.setPosition 50, 160
  #scene.addChild charSprite

  #charSprite2 = new Sprite charSpriteSheet
  #charSprite2.addAnimation {id: 'walk', row: 2, fps: 10}
  #charSprite2.play 'walk'
  #charSprite2.setPosition 150, 100
  #scene.addChild charSprite2

  charSpriteSheet = new SpriteSheet 'images/hibiki.png', [
    {length: 25, cellWidth: 67, cellHeight: 97},
    {length: 12, cellWidth: 67, cellHeight: 101}
  ]

  # Create a sprite from the sprite sheet, add 'idle'
  # animation from first row of the spritesheet, and
  # add 'walk' from second row, both at 24 frames
  # per second.
  sprite = new Sprite charSpriteSheet
  sprite.addAnimation {id: 'idle', row: 0, fps: 24}
  sprite.play 'idle'
  #sprite.setPosition 30, 150
  sprite.setSize 30, 45

  isoMap.addObject(sprite, 0, 0)


  sprite2 = new Sprite charSpriteSheet
  sprite2.addAnimation {id: 'idle', row: 0, fps: 24}
  sprite2.play 'idle'
  sprite2.setPosition 160, 120
  sprite2.setSize 30, 45

  isoMap.addObject(sprite2, 1, 0)

  sprite3 = new Sprite charSpriteSheet
  sprite3.addAnimation {id: 'idle', row: 0, fps: 24}
  sprite3.play 'idle'
  sprite3.setPosition 285, 53
  sprite3.setSize 30, 45

  isoMap.addObject(sprite3, 2, 0)

  isoMap.position.x += 100
