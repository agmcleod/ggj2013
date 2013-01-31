Screens.StartScreen = me.ScreenObject.extend({
  init: ->
    this.parent(true)
    this.titleImage = null
    this.screens = []
    this.currentScreen = 0
    this.viewStory = false

  draw: (context) ->
    if this.viewStory
      if me.timer.getTime() - this.timer > 6500
        this.currentScreen++
        this.timer = me.timer.getTime()
      if this.currentScreen >= this.screens.length
        me.state.change(me.state.PLAY)
      context.drawImage(this.screens[this.currentScreen], 0, 0)
    else
      context.drawImage(this.titleImage, 0, 0)
    

  onDestroyEvent: ->
    me.input.unbindKey(me.input.KEY.ENTER)
    me.input.unbindKey(me.input.KEY.X)
    me.input.unbindTouch()
    me.input.unbindMouse(me.input.mouse.LEFT)

  onResetEvent: ->
    window.musicController = new MusicController()
    window.musicController.init()
    this.titleImage = me.loader.getImage("title")
    me.input.bindKey(me.input.KEY.ENTER, "enter", true)
    me.input.bindKey(me.input.KEY.X, "x", true)
    me.input.bindMouse(me.input.mouse.LEFT, me.input.KEY.X)
    me.input.bindTouch(me.input.KEY.X)
    this.screens = [
      me.loader.getImage("frame1"),
      me.loader.getImage("frame2"),
      me.loader.getImage("frame3")
    ]

  update: ->
    if me.input.isKeyPressed('enter')
      if this.viewStory
        me.state.change(me.state.PLAY)
      else
        this.viewStory = true
        this.timer = me.timer.getTime()

    if me.input.isKeyPressed("x")
      if this.viewStory
        this.currentScreen++
        this.timer = me.timer.getTime()
      else
        this.viewStory = true
        this.timer = me.timer.getTime()

    true
})