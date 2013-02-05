
class window.Tile extends Component
  constructor: (spriteSheet, index) ->
    super()
    @tile = new SpriteImage spriteSheet, index
    @addChild @tile

