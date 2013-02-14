
class window.SpriteImage extends Component
  constructor: (@spriteSheet, @index) ->
    super()
    @size = {w:64, h:64} #TODO hardcoded stuff

  draw: (ctx) ->
    super ctx
    if @spriteSheet and @spriteSheet.loaded
      f = @spriteSheet.data[@index]
      ctx.drawImage @spriteSheet.image, f.x, f.y, f.w, f.h,
        @position.x, @position.y, f.w, f.h
