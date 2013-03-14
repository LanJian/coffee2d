
class window.Tile extends Component
  constructor: (@spriteSheet, @index, @heightOffset=0) ->
    super()
    @heightTiles = []
    @baseTiles = []
    @baseTiles.push new SpriteImage spriteSheet, @index

    @addChild tile for tile in @baseTiles
    @size =  @baseTiles[0].size

    #@addListener 'mouseOver', ((evt) ->
      ##newEvt = {type:'tileMouseOver', x:evt.x, y:evt.y}
      ##@dispatchEvent newEvt
      #console.log 'sup'
    #).bind this

  setup: ->
    @addChild @boundingPolygon
    @boundingPolygon.hide()

  #handle: (evt) ->
    ## do nothing

  hidePoly: ->
    @boundingPolygon.hide()

  showPoly: ->
    @boundingPolygon.show()


  addHeightIndex: (index) ->
    sprite = new SpriteImage @spriteSheet, index
    sprite.position.y = -@heightTiles.length*@heightOffset
    console.log sprite.position.y
    @heightTiles.push sprite

    @addChild sprite

