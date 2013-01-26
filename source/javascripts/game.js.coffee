window.App = {
  init: ->
    if !me.video.init("app", 800, 640, false, 1)
      alert "your browser does not support the canvas"

    me.loader.onload = this.loaded.bind(this)
    me.loader.preload([{
      name: "04b03_font",
      type: "image",
      src: "images/04b03.font.png"
    }, {
      name: "TowerBG",
      type: "image",
      src: "images/TowerBG.jpg"
    }])

    me.state.change(me.state.LOADING)

  loaded: ->
    me.state.set(me.state.PLAY, new PlayScreen())
    me.input.bindKey(me.input.KEY.X, "shoot")
    me.input.bindMouse(me.input.mouse.LEFT, me.input.KEY.X)
    me.state.change(me.state.PLAY)
}

Game = me.InvisibleEntity.extend({
  init: ->
    #player = new Entities.Player(500, 500, {})
    #me.game.add(player, this.spriteZIndex)
    this.backgrounds = [
      new Entities.Background(0, 0, {}),
      new Entities.Background(0, 1280, {})
    ]
    this.bottomBackground = 0
    me.game.add(this.backgrounds[0], 10)
    me.game.add(this.backgrounds[1], 10)

  spriteZIndex: 50
  bulletZIndex: 51

  update: ->
    me.video.clearSurface(me.video.getScreenCanvas().getContext("2d"), "#000")
    this.updateBackgrounds()

  updateBackgrounds: ->
    for b, i in this.backgrounds
      b.pos.y -= 40
      if b.pos.y < -1280
        b.pos.y = 1280
        if i == 0
          this.bottomBackground = 1
        else if i == 1
          this.bottomBackground = 0
})

PlayScreen = me.ScreenObject.extend({
  onDestroyEvent: ->
    me.game.disableHUD()

  onResetEvent: ->
    window.App.game = new Game()
    me.game.add(window.App.game, 0)
    me.game.addHUD(0, 0, 800, 640)
    me.game.HUD.addItem("score", new HUD.ScoreHUD(650, 10))
    me.game.sort()
})

window.onReady ->
  App.init()