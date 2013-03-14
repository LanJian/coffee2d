
class window.Tile extends Component
  constructor: (@spriteSheet, @index, @heightOffset=0) ->
    super()
    @heightTiles = []
    @baseTiles = []
    @baseTiles.push new SpriteImage spriteSheet, @index

    @addChild tile for tile in @baseTiles
    @size =  @baseTiles[0].size


  setup: ->
    @children.splice 1, 0, @boundingPolygon
    @boundingPolygon.hide()


  hidePoly: ->
    @boundingPolygon.hide()

  showPoly: ->
    @boundingPolygon.show()


  addHeightIndex: (index) ->
    sprite = new SpriteImage @spriteSheet, index
    sprite.position.y = -@heightTiles.length*@heightOffset
    @heightTiles.push sprite

    @addChild sprite

