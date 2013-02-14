class window.Sprite extends Component
  constructor: (spriteSheet) ->
    super()

    @spriteSheets = {default: spriteSheet}
    @animations = {}

    @playingAnimation = 'none'
    @isPlaying = false
    @loop = true

    @addListener 'spriteImageLoaded', @onSpriteImageLoaded.bind this

    @reset()


  onSpriteImageLoaded: (evt) ->
    found = false
    for key, val of @spriteSheets
      if val == evt.target
        found = true
        break
    if not found
      return

    # Set size
    if w != 0 or h != 0
      return
    w = h = 0
    for key, spr of @spriteSheets
      for f in spr.data
        if f.w > w
          w = f.w
        if f.h > h
          h = f.h
    @setSize w, h


  addSpriteSheet: (id, spriteSheet) ->
    @spriteSheets[id] = spriteSheet


  # Can either specify row, or start frame and duration
  addAnimation: (a) ->
    if not a.id then return
    if isNaN a.row and isNaN a.startFrame then return
    if not a.fps then a.fps = 60
    if not a.spriteSheetId then a.spriteSheetId = 'default'

    id = a.id
    row = a.row
    startFrame = a.startFrame
    duration = a.duration
    fps = a.fps
    spriteSheetId = a.spriteSheetId

    ss = @spriteSheets[spriteSheetId]
    if 0 <= row <= ss.rowData.length
      data = ss.getStartFrameAndDuration row
      startFrame = data.startFrame
      duration = data.duration
    @animations[id] =
      spriteSheet: spriteSheetId
      startFrame: startFrame
      duration: duration
      frameInterval: 1000/fps



  reset: ->
    anim = @animations[@playingAnimation]
    if anim then @frameIndex = anim.startFrame else 0
    @curInterval = 0


  playOnce: (id) ->
    if id and @playingAnimation != id
      @playingAnimation = id
      @reset()
      @loop = false

    @isPlaying = true


  play: (id) ->
    if id and @playingAnimation != id
      @playingAnimation = id
      @reset()
      @loop = true

    @isPlaying = true


  stop: ->
    @isPlaying = false


  update: (dt) ->
    anim = @animations[@playingAnimation]
    if not anim
      return
    spriteSheet = @spriteSheets[anim.spriteSheet]
    if spriteSheet and  @isPlaying and spriteSheet.loaded
      @curInterval += dt
      if @curInterval >= anim.frameInterval
        @frameIndex++
        if (@frameIndex >= anim.duration) and not @loop
          @stop()
        @frameIndex = anim.startFrame + (@frameIndex - anim.startFrame) % anim.duration
        @curInterval = @curInterval % anim.frameInterval

    super dt


  draw: (ctx) ->
    anim = @animations[@playingAnimation]
    if not anim
      return
    spriteSheet = @spriteSheets[anim.spriteSheet]
    if spriteSheet and spriteSheet.loaded
      f = spriteSheet.data[@frameIndex]
      dw = if @size.w == 0 then f.w else @size.w
      dh = if @size.h == 0 then f.h else @size.h
      ctx.drawImage spriteSheet.image, f.x, f.y, f.w, f.h,
        @position.x, @position.y, dw, dh

    super ctx
