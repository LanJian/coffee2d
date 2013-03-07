
class window.Tile extends Component
  constructor: (@spriteSheet, @index, @heightOffset=0) ->
    super()
    @heightTiles = []
    @baseTiles = []
    @baseTiles.push new SpriteImage spriteSheet, @index

    @addChild tile for tile in @baseTiles
    @size =  @baseTiles[0].size

    @addListener 'mouseMove', ((evt) ->
      console.log 'move'
      newEvt = {type:'tileMouseOver', x:evt.x, y:evt.y}
      @dispatchEvent newEvt
    ).bind this

  hidePoly: ->
    @removeChild @boundingPolygon

  showPoly: ->
    @children.splice 1, 0, @boundingPolygon


  addHeightIndex: (index) ->
    sprite = new SpriteImage @spriteSheet, index
    sprite.position.y = -@heightTiles.length*@heightOffset
    console.log sprite.position.y
    @heightTiles.push sprite

    @addChild sprite
