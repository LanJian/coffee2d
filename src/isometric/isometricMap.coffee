class window.IsometricMap extends Component
  constructor: (opts) ->
    super()
    # TODO: error checking
    @opts             = opts
    @spriteSheet      = opts.spriteSheet
    @tiles              = opts.tiles
    @tileWidth        = opts.tileWidth
    @tileHeight       = opts.tileHeight
    @tileXOffset      = opts.tileXOffset
    @tileYOffset      = opts.tileYOffset
    @tileBoundingPoly = opts.tileBoundingPoly

    @mapOffset = 0

    @init()

    @addListener 'mouseMove', ((evt) ->
      #ox = @tileXOffset
      #oy = @tileYOffset
      #om = @mapOffset

      #x = evt.x - (evt.x%ox)
      #y = evt.y - (evt.y%oy)

      #j = (y/oy - (om - x)/ox)/2
      #i = j + (om - x)/ox

      #i = (Math.floor i)
      #j = (Math.floor j)


      #@tiles[i][j].showPoly()

      for i in [0...@tiles.length-1]
        row = @tiles[i]
        for j in [0...row.length-1]
          tile = row[j]
          x = i*-@tileXOffset + j*@tileXOffset + @mapOffset
          y = i*@tileYOffset + j*@tileYOffset
          if tile.containsPoint evt.x-x+1, evt.y-y+1
            tile.showPoly()
          else
            tile.hidePoly()
    ).bind this


  # Override
  handle: (evt) ->
    if Event.isMouseEvent evt
      if not @containsPoint evt.x, evt.y
        return
      evt.target = this

    if evt.type == 'click'
      for child in @children
        # transform event coordinates
        evt.x = evt.x - child.position.x
        evt.y = evt.y - child.position.y
        child.handle evt
        # untransform event coordinates
        evt.x = evt.x + child.position.x
        evt.y = evt.y + child.position.y

    for listener in @listeners
      if evt.type == listener.type
        listener.handler evt

  init: ->
    minX = maxX = 0
    maxY = 0
    i       = 0
    j       = 0
    ii      = 0
    jj      = 0
    xOffset = 0
    yOffset = 0
    rows    = @tiles.length
    cols    = @tiles[0].length
    while i<rows and j<cols
      ii = i
      jj = j
      x = xOffset
      y = yOffset
      while ii<rows and jj<cols
        # check for out of bounds
        if ii<0 or ii>=rows or jj<0 or jj>=cols
          break
        t = @tiles[ii][jj]
        t.position = {x: x, y: y}
        poly = {}
        $.extend poly, @tileBoundingPoly
        t.setBoundingPolygon poly
        t.setup()
        @addChild t
        if x < minX
          minX = x
        if x > maxX
          maxX = x
        if y > maxY
          maxY = y
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
      
    # move the map to position
    for row in @tiles
      for t in row
        t.position.x += (-minX)
    @mapOffset = -minX
    @setSize maxX-minX, maxY


  addObject: (obj, i, j) ->
    x = i*-@tileXOffset + j*@tileXOffset + @mapOffset
    y = i*@tileYOffset + j*@tileYOffset
    obj.setPosition x, y
    @addChild obj
