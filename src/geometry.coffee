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
