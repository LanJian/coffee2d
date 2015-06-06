$(document).ready ->
  init()

init = ->
  # Make a scene
  canvas = $('#canvas')[0]
  scene = new Scene canvas, '#222222'

  # make an instance of our custom Component and add it to the scene
  pong = new Pong scene.size.w, scene.size.h
  scene.addChild pong


# make a custom Component to represent the game
class Pong extends Component
  constructor: (@width, @height)->
    super()
    @playerPaddle = new Rect 5, 40, 20, 120, '#66AAAA'
    @compPaddle = new Rect @width - 25, 100, 20, 120, 'AA66AA'
    @ball = new Rect @width/2, @height/2, 15, 15, 'AABBAA'

    @addChild @playerPaddle
    @addChild @compPaddle
    @addChild @ball

    @vx = @vy = 0.2

    @accleration = 0.00005

    @playerScore = @compScore = 0

    # set up keyboard input
    @onKeyDown 38, => # up arrow
      @playerPaddle.position.y -= 10
    @onKeyDown 40, => # down arrow
      @playerPaddle.position.y += 10


  # override the update method with our custom logic
  update: (dt) ->
    # accelerate the ball
    if @vx > 0
      @vx += @accleration
    else
      @vx -= @accleration
    if @vy > 0
      @vy += @accleration
    else
      @vy -= @accleration

    # cap the speed
    if @vx > 0.5
      @vx = 0.5
    else if @vx < -0.5
      @vx = -0.5
    if @vy > 0.5
      @vy = 0.5
    else if @vy < -0.5
      @vy = -0.5

    # simple AI, make the computer try to move to match the ball's y position
    diff = @ball.position.y + @ball.size.h/2.0 -
      (@compPaddle.position.y + @compPaddle.size.h/2.0)
    if diff > 5
      @compPaddle.position.y += 5
    else if diff < -5
      @compPaddle.position.y -= 5

    # get the delta x and y
    dx = @vx * dt
    dy = @vy * dt

    # bounce off the top and bottom wall
    if (@ball.position.y + dy) < 0
      dy *= -1
      @vy *= -1
    else if (@ball.position.y + @ball.size.h + dy) > @height
      dy *= -1
      @vy *= -1

    # bounce off the player paddle
    if @playerPaddle.isPointInside(
      @ball.position.x + dx, @ball.position.y)
      dx *= -1
      @vx*= -1
    else if @playerPaddle.isPointInside(
      @ball.position.x + dx, @ball.position.y + @ball.size.h)
      dx *= -1
      @vx *= -1
    # bounce off the computer paddle
    else if @compPaddle.isPointInside(
      @ball.position.x + @ball.size.w + dx, @ball.position.y)
      dx *= -1
      @vx*= -1
    else if @compPaddle.isPointInside(
      @ball.position.x + @ball.size.w + dx, @ball.position.y + @ball.size.h)
      dx *= -1
      @vx *= -1

    # check for score and reset the ball if the 
    if (@ball.position.x + dx) < -@ball.size.w
      @ball.setPosition @width/2, @height/2
      @compScore += 1
    else if (@ball.position.x + @ball.size.w + dx) > @width + @ball.size.w
      @ball.setPosition @width/2, @height/2
      @playerScore += 1

    # update the ball's position
    @ball.position.x += dx
    @ball.position.y += dy

    # we need to call super
    super(dt)


  # override the draw method to add our custom drawing logic for the dashed
  # divider line and the scores
  draw: (ctx) ->
    # save the context
    ctx.save()

    # draw the scores
    ctx.fillStyle = 'orange'
    ctx.font = '48px monospace'
    ctx.fillText("#{@playerScore}", @width/2 - 80, 50)
    ctx.fillText("#{@compScore}", @width/2 + 50, 50)

    # draw a line in the middle
    ctx.lineWidth = 3
    ctx.setLineDash([15, 7])
    ctx.strokeStyle = 'orange'
    ctx.beginPath()
    ctx.moveTo(@width/2, 0)
    ctx.lineTo(@width/2, @height)
    ctx.stroke()

    # restore the context so we don't mess up subsequent drawing
    ctx.restore()

    # we need to call super
    super(ctx)
