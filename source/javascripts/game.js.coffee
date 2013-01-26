window.App = {
  init: ->
    if !me.video.init("app", 800, 640, false, 1)
      alert "your browser does not support the canvas"

    me.audio.init("ogg")
    me.loader.onload = this.loaded.bind(this)
    me.loader.preload([{
      name: "TowerBG",
      type: "image",
      src: "images/TowerBG.jpg"
    }, {
      name: "Tower_BlurBG",
      type: "image",
      src: "images/Tower_BlurBG.jpg"
    } ,{
      name: "bullets",
      type: "image",
      src: "images/bullets.png"
    }, {
      name: "player",
      type: "image",
      src: "images/player.png"
    }, {
      name: "gunshot_a",
      type: "audio",
      src: "sound/",
      channel: 2
    }, {
      name: "112bpm_fade_in_intro",
      type: "audio",
      src: "sound/",
      channel: 1
    }
    , {
      name: "112bpm_1_layer_loop",
      type: "audio",
      src: "sound/"
    }, {
      name: "112bpm_2_layer_loop",
      type: "audio",
      src: "sound/"
    }, {
      name: "112bpm_3_layer_loop",
      type: "audio",
      src: "sound/"
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
    this.backgrounds = [
      new Entities.Background(0, 0, {}),
      new Entities.Background(0, 1280, {})
    ]
    this.bottomBackground = 0
    me.game.add(this.backgrounds[0], 0)
    me.game.add(this.backgrounds[1], 0)

    player = new Entities.Player()
    me.game.add(player, this.spriteZIndex)
    this.musicController = new MusicController()
    this.musicController.init()
    #me.debug.renderHitBox = true

  spriteZIndex: 50
  bulletZIndex: 49
  bulletZEnemyIndex: 51

  update: ->
    me.video.clearSurface(me.video.getScreenCanvas().getContext("2d"), "#000")
    this.musicController.update()
      
})

PlayScreen = me.ScreenObject.extend({
  onDestroyEvent: ->
    me.game.disableHUD()
    window.App.game.musicController.cleanup()

  onResetEvent: ->
    window.App.game = new Game()
    me.game.add(window.App.game, 0)
    me.game.addHUD(0, 0, 800, 640)
    me.game.HUD.addItem("score", new HUD.ScoreHUD(650, 10))
    me.game.sort()
})

window.onReady ->
  App.init()