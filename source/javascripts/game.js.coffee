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
      name: "green_monster",
      type: "image",
      src: "images/green_monster.png"
    },{
      name: "red_monster",
      type: "image",
      src: "images/red_monster.png"
    },{
      name: "frame1",
      type: "image",
      src: "images/Frame1.png"
    },{
      name: "frame2",
      type: "image",
      src: "images/Frame2.png"
    },{
      name: "frame3",
      type: "image",
      src: "images/Frame3.png"
    },{
      name: "youlost",
      type: "image",
      src: "images/YouLost.png"
    },{
      name: "title",
      type: "image",
      src: "images/Title1.jpg"
    },{
      name: "gunshot_a",
      type: "audio",
      src: "sound/",
      channel: 2
    },{
      name: "112bpm_fade_in_intro",
      type: "audio",
      src: "sound/",
      channel: 1
    },{
      name: "112bpm_1_layer_loop",
      type: "audio",
      src: "sound/"
    },{
      name: "112bpm_2_layer_loop",
      type: "audio",
      src: "sound/"
    },{
      name: "112bpm_3_layer_loop",
      type: "audio",
      src: "sound/"
    }])
    me.state.change(me.state.LOADING)

  loaded: ->
    me.state.set(me.state.MENU, new StartScreen())
    me.state.set(me.state.PLAY, new PlayScreen())
    me.state.change(me.state.MENU)
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
    me.game.HUD.addItem("health", new HUD.ScoreHUD(40, 10))
    me.game.HUD.setItemValue("health", "HP: #{player.health}")
    this.player = player

    this.spawnEnemy()
    #me.debug.renderHitBox = true

  spriteZIndex: 50
  bulletZIndex: 49
  bulletZEnemyIndex: 51

  spawnEnemy: ->
    r = !! Math.round(Math.random() * 1)
    if r
      me.game.add(new Entities.GreenMonster(), this.spriteZIndex)
    else
      me.game.add(new Entities.RedMonster(), this.spriteZIndex)

  update: ->
    me.video.clearSurface(me.video.getScreenCanvas().getContext("2d"), "#000")
    window.musicController.update()
      
})

GameOverScreen = me.ScreenObject.extend({

})

StartScreen = me.ScreenObject.extend({
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
    me.input.unbindMouse(me.input.mouse.LEFT)

  onResetEvent: ->
    window.musicController = new MusicController()
    window.musicController.init()
    this.titleImage = me.loader.getImage("title")
    me.input.bindKey(me.input.KEY.ENTER, "enter", true)
    me.input.bindKey(me.input.KEY.X, "x", true)
    me.input.bindMouse(me.input.mouse.LEFT, me.input.KEY.X)
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

    if me.input.isKeyPressed("x") && this.viewStory
      this.currentScreen++
      this.timer = me.timer.getTime()

    window.musicController.update()
    true
})

PlayScreen = me.ScreenObject.extend({
  onDestroyEvent: ->
    me.game.disableHUD()
    window.musicController.cleanup()

  onResetEvent: ->
    me.game.addHUD(0, 0, 800, 640)
    me.game.HUD.addItem("score", new HUD.ScoreHUD(650, 10, 'yellow'))
    window.App.game = new Game()
    me.input.bindKey(me.input.KEY.X, "shoot")
    me.input.bindMouse(me.input.mouse.LEFT, me.input.KEY.X)
    me.game.add(window.App.game, 0)
    me.game.sort()
})

window.onReady ->
  App.init()