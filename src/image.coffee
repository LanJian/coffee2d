window.Coffee2D or= {}

class window.Coffee2D.Image extends Component
  constructor: (filename) ->
    super()
    @image = new window.Image
    @image.src = filename
    @image.onload = @onImageLoaded.bind this
    @loaded = false


  onImageLoaded: ->
    @loaded = true
    @setSize @image.width, @image.height


  draw: (ctx) ->
    super ctx
    if @loaded
      ctx.drawImage @image, @position.x, @position.y,
        @size.w, @size.h

