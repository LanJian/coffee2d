class window.SpriteSheet
  constructor: (@filename, @rowData) ->
    @data = []
    @image = new Image
    @image.src = @filename
    @image.onload = @onImageLoaded.bind this
    @loaded = false


  onImageLoaded: ->
    height = 0
    for i in [0..@rowData.length-1]
      row = @rowData[i]
      for j in [0..row.length-1]
        @data.push (
          x: j*row.cellWidth
          y: height
          w: row.cellWidth
          h: row.cellHeight
        )
      height += row.cellHeight

    @loaded = true
    Event.dispatchEvent(
      type: 'spriteImageLoaded'
      origin: this
      target: this
      x: 0
      y: 0)

  getStartFrameAndDuration: (row) ->
    startFrame = 0
    if row > 0
      for i in [0..row-1]
        startFrame += @rowData[i].length
    duration = @rowData[row].length
    return {startFrame: startFrame, duration: duration}


  getNumFrames: ->
    @data.length
