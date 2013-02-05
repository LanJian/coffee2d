class window.IsometricMap extends Component
  constructor: (opts) ->
    super()
    console.log this
    # TODO: error checking
    @opts        = opts
    @spriteSheet = opts.spriteSheet
    @map         = opts.map
    @tileWidth   = opts.tileWidth
    @tileHeight  = opts.tileHeight
    @tileXOffset = opts.tileXOffset
    @tileYOffset = opts.tileYOffset

    @tiles = []
    @init()

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
        index = @map[ii][jj]
        t = new Tile @opts.spriteSheet, index
        console.log ii, jj
        console.log index
        console.log x, y
        t.position = {x: x, y: y}
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

