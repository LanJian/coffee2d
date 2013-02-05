
class window.Tile extends Component
  constructor: (@spriteSheet, index) ->
    super()
    @heightTiles = []
    @baseTiles = []
    @baseTiles.push new SpriteImage spriteSheet, index

    @addChild tile for tile in @baseTiles

  addHeightIndex: (index) ->
    sprite = new SpriteImage @spriteSheet, index
    sprite.position.y = -@heightTiles.length*32 #TODO: hardcoded magic number
    console.log sprite.position.y
    @heightTiles.push sprite

    @addChild sprite
