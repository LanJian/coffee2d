class window.IsometricMap extends Component
  constructor: (opts) ->
    super()
    # TODO: error checking
    @opts             = opts
    @spriteSheet      = opts.spriteSheet
    @map              = opts.map
    @tileWidth        = opts.tileWidth
    @tileHeight       = opts.tileHeight
    @tileXOffset      = opts.tileXOffset
    @tileYOffset      = opts.tileYOffset
    @tileBoundingPoly = opts.tileBoundingPoly

    @poly = new Polygon [[-300,0], [500,0], [500,600], [-300,600]] #TODO hardcoded
    @setBoundingPolygon @poly

    @tiles = []
    @init()

    @addListener 'tileMouseOver', ((evt) ->
      for row in @map
        for tile in row
          tile.hidePoly()
          if (tile == evt.origin)
            tile.showPoly()
    ).bind this

  init: ->
    i       = 0
    j       = 0
    ii      = 0
    jj      = 0
    xOffset = 0
    yOffset = 0
    rows    = @map.length
    cols    = @map[0].length
    while i<rows and j<cols
      ii = i
      jj = j
      x = xOffset
      y = yOffset
      console.log '-----'
      while ii<rows and jj<cols
        # check for out of bounds
        if ii<0 or ii>=rows or jj<0 or jj>=cols
          break
        t = @map[ii][jj]
        t.position = {x: x, y: y}
        t.setBoundingPolygon @tileBoundingPoly
        @addChild t
        ii-=1
        jj+=1
        x += @tileWidth
      
      # increment for next level
      if i+1<cols
        i++
        xOffset -= @tileXOffset
      else
        j++
        xOffset += @tileXOffset
      yOffset += @tileYOffset

