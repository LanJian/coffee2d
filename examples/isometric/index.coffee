$(document).ready ->
  init()

# Request fullscreen. On Firefox, it will stretch the canvas to fit the screen,
# on Chrome, the canvas is kept at same size.
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

  # Make a spritesheet for the tileset. We take 13 rows of cells. Each row has
  # 10 cells, where each cell is 64x64.(There is more stuff at the bottom of
  # the tileset image, but we won't be using those)
  spriteSheet = new SpriteSheet 'images/tileset.png', [
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64},
    {length: 10, cellWidth: 64, cellHeight: 64}
  ]

  # Make a 10x10 map and fill it with the first tile sprite from the tile set.
  map = []
  for i in [0..9]
    map[i] = []
    for j in [0..9]
      # The first argument is the tile index in the tile set, the second
      # argument is the number of pixels to shift up by to raise the height
      # of a tile
      map[i][j] = new Tile spriteSheet, 1, 32


  # Add additional height tiles
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

  poly = new Polygon [[32,32], [64,48], [32,64], [0,48]]
  isoMap = new IsometricMap
    spriteSheet      : spriteSheet
    tiles            : map
    tileWidth        : 64
    tileHeight       : 64
    # tileXOffset and tileYOffset are the number of pixels to move the
    # next tile when tiling
    tileXOffset      : 32
    tileYOffset      : 16
    # Bounding polygon for a tile
    tileBoundingPoly : poly

  # Add the isometric map to the scene
  scene.addChild isoMap

  charSpriteSheet = new SpriteSheet 'images/hibiki.png', [
    {length: 25, cellWidth: 67, cellHeight: 97},
    {length: 12, cellWidth: 67, cellHeight: 101}
  ]

  # Create a sprite
  sprite = new Sprite charSpriteSheet
  sprite.addAnimation {id: 'idle', row: 0, fps: 24}
  sprite.play 'idle'
  sprite.setSize 30, 45
  # Add the sprite to a Component so we can set its position. This way we can
  # center the sprite in the middle of a tile
  sprite.setPosition 15, 5
  c = new Component
  c.addChild sprite
  # Add the object to the isometric map at the specified coordinates
  isoMap.addObject(c, 0, 0)

  sprite2 = new Sprite charSpriteSheet
  sprite2.addAnimation {id: 'idle', row: 0, fps: 24}
  sprite2.play 'idle'
  sprite2.setPosition 160, 120
  sprite2.setSize 30, 45
  sprite2.setPosition 15, 5
  c2 = new Component
  c2.addChild sprite2
  isoMap.addObject(c2, 1, 0)

  sprite3 = new Sprite charSpriteSheet
  sprite3.addAnimation {id: 'idle', row: 0, fps: 24}
  sprite3.play 'idle'
  sprite3.setPosition 285, 53
  sprite3.setSize 30, 45
  sprite3.setPosition 15, 5
  c3 = new Component
  c3.addChild sprite3
  isoMap.addObject(c3, 2, 0)

  # Move the map towards the center
  isoMap.position.x += 100
