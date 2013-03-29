
class window.SpriteImage extends Component
  constructor: (@spriteSheet, @index) ->
    super()
    @loaded = false
    @addListener 'spriteImageLoaded', @onSpriteImageLoaded.bind this
    console.log 'spriteimage cons'


  hasSpriteSheet: (ss) ->
    return (@spriteSheet == ss)


  onSpriteImageLoaded: (evt) ->
    if @spriteSheet != evt.target
      return

    @loaded = true

    # Set size
    if @size.w != 0 or @size.h != 0
      return
    f = @spriteSheet.data[@index]
    @setSize f.w, f.h

  draw: (ctx) ->
    super ctx
    if @spriteSheet and @spriteSheet.loaded
      f = @spriteSheet.data[@index]
      ctx.drawImage @spriteSheet.image, f.x, f.y, f.w, f.h,
        @position.x, @position.y, f.w, f.h
