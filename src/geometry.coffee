class window.Point2
  constructor: (@x, @y) ->

  plus: (v) ->
    @x += v.x
    @y += v.y
    this

class window.Vector2
  constructor: (@x, @y) ->

  plus: (v) ->
    @x += v.x
    @y += v.y
    this

  dot: (v) ->
    @x*v.x + @y*v.y

class window.Rect extends Component
  constructor: (x, y, w, h, @color='black') ->
    super x, y, w, h

  isPointInside: (x, y) ->
    x >= @position.x and x <= @position.x + @size.w and
      y >= @position.y and y <= @position.y + @size.h

  draw: (ctx) ->
    ctx.fillStyle = @color
    ctx.beginPath()
    ctx.rect @position.x, @position.y, @size.w, @size.h
    ctx.closePath()
    ctx.fill()
    super ctx

class window.Polygon extends Component
  constructor: (@points) ->
    super 0, 0, 100, 100
    @lineSegs = []
    for i in [0..@points.length-1]
      @lineSegs.push [@points[i], @points[(i+1)%@points.length]]

  containsPoint: (x, y) ->
    count = 0
    for seg in @lineSegs
      a = seg[0]
      b = seg[1]
      if b[1] != a[1]
        ix = (b[0]-a[0]) * (y-a[1]) / (b[1] - a[1]) + a[0]
        if ix >= x and (@inRange ix, a[0], b[0]) and (@inRange y, a[1], b[1])
          count += 1
    if count % 2 == 0
      return false
    return true

  inRange: (x, a, b) ->
    if x < a and x < b then return false
    if x > a and x > b then return false
    return true
    
  draw: (ctx) ->
    ctx.save()
    ctx.translate @position.x, @position.y
    ctx.fillStyle = 'rgba(50,20,240,0.4)'
    ctx.beginPath()
    p = @points[0]
    ctx.moveTo p[0], p[1]
    for i in [1..@points.length-1]
      p = @points[i]
      ctx.lineTo p[0], p[1]
    ctx.closePath()
    ctx.fill()
    ctx.restore()
    super ctx
