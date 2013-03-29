window.Coffee2D or= {}

class window.Coffee2D.Text extends Component
  
  # Draw text 
  constructor: (@text, @color='black', @style='12px Arial') ->
    super()

  draw: (ctx) ->
    super ctx
    ctx.font = @style
    ctx.fillStyle = @color
    ctx.fillText @text, @position.x, @position.y
