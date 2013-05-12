Screens.GameOverScreen = me.ScreenObject.extend({
  init: ->
    this.parent(true)
    this.overImage = null

  draw: (context) ->
    context.drawImage(this.overImage, 0, 0)
    context.font = "30px Verdana"
    context.fillStyle = "yellow"
    context.fillText("Final Score: " + App.playScreen.score, 500, 50)

  onDestroyEvent: ->
    me.input.unbindKey(me.input.KEY.ENTER)
    me.input.unbindMouse(me.input.mouse.LEFT)
    me.input.unbindTouch()

  onResetEvent: ->
    this.overImage = me.loader.getImage("youlost")
    me.input.bindKey(me.input.KEY.ENTER, "enter", true)
    me.input.bindTouch(me.input.KEY.ENTER)
    r = Math.round(Math.random() * 2) + 1
    me.audio.play("lex_screams_#{r}")

  update: ->
    if me.input.isKeyPressed('enter')
      me.state.change(me.state.PLAY)
    true

})