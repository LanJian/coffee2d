window.Coffee2D or= {}

class window.Coffee2D.Text extends Component
  
  # Draw text 
  constructor: (@text, @color='black') ->
    super()

  draw: (ctx) ->
    super ctx
    ctx.font = '30px Arial'
    ctx.fillStyle = @color
    ctx.fillText @text, @position.x, @position.y
