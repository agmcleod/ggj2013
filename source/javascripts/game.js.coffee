App = {
  init: ->
    if !me.video.init("app", 800, 640, false, 1)
      alert "your browser does not support the canvas"

    me.loader.onload = this.loaded.bind(this)
    me.loader.preload([])

    me.state.change(me.state.LOADING)

  loaded: ->
    me.state.set(me.state.PLAY, new PlayScreen())
    me.input.bindKey(me.input.KEY.X, "shoot")
    me.input.bindMouse(me.input.mouse.LEFT, me.input.KEY.X)
    me.state.change(me.state.PLAY)
}

Game = me.InvisibleEntity.extend({
  init: ->
    # player = new Entities.Player(500, 500, {})
    # me.game.add(player, 100)

  update: ->
    me.video.clearSurface(me.video.getScreenCanvas().getContext("2d"), "#000")
})

PlayScreen = me.ScreenObject.extend({
  onResetEvent: ->
    me.game.add(new Game(), 0)
    me.game.sort()
})

window.onReady ->
  App.init()