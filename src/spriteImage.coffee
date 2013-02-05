
class window.SpriteImage extends Component
  constructor: (@spriteSheet, @index) ->
    super()

  draw: (ctx) ->
    super ctx
    if @spriteSheet and @spriteSheet.loaded
      f = @spriteSheet.data[@index]
      ctx.drawImage @spriteSheet.image, f.x, f.y, f.w, f.h,
        @position.x, @position.y, f.w, f.h
