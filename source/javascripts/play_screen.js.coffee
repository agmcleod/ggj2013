Screens.PlayScreen = me.ScreenObject.extend({
  onDestroyEvent: ->
    me.game.disableHUD()
    # window.musicController.cleanup()
    me.input.unbindMouse(me.input.mouse.LEFT)
    me.input.unbindKey(me.input.KEY.X)
    me.input.unbindTouch()

  onResetEvent: ->
    me.game.addHUD(0, 0, 800, 640)
    me.game.HUD.addItem("score", new HUD.ScoreHUD(650, 10, 'yellow'))
    window.App.game = new window.App.Game()
    me.input.bindKey(me.input.KEY.X, "shoot")
    me.input.bindMouse(me.input.mouse.LEFT, me.input.KEY.X)
    me.input.bindTouch(me.input.KEY.X)
    me.game.add(window.App.game, 0)
    me.game.sort()
})