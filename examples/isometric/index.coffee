$(document).ready ->
  init()

init = ->
  # Make a scene
  canvas = $('#canvas')[0]
  scene = new Scene canvas, 'black'

  # TODO: more at the end but not same size
  spriteSheet = new SpriteSheet 'images/tileset.png', [
    {length: 7  , cellWidth: 64 , cellHeight: 64} ,
    {length: 8  , cellWidth: 64 , cellHeight: 64} ,
    {length: 4  , cellWidth: 64 , cellHeight: 64} ,
    {length: 9  , cellWidth: 64 , cellHeight: 64} ,
    {length: 4  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64} ,
    {length: 3  , cellWidth: 64 , cellHeight: 64} ,
    {length: 10 , cellWidth: 64 , cellHeight: 64}
  ]

  map = []
  for i in [0..9]
    map[i] = []
    for j in [0..9]
      map[i][j] = Math.floor(Math.random()*60)

  console.log map

  isoMap = new IsometricMap
    spriteSheet : spriteSheet
    map         : map
    tileWidth   : 64
    tileHeight  : 64
    tileXOffset : 32
    tileYOffset : 16

  isoMap.position.x = 300

  scene.addChild isoMap
