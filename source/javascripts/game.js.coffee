window.App = {
  init: ->
    if !me.video.init("app", 800, 640, false, 1)
      alert "your browser does not support the canvas"

    me.audio.init("mp3,ogg")
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
      src: "sound/",
      channel: 2
    },{
      name: "112bpm_2_layer_loop",
      type: "audio",
      src: "sound/",
      channel: 2
    },{
      name: "112bpm_3_layer_loop",
      type: "audio",
      src: "sound/",
      channel: 2
    }, {
      name: "lex_grunt_1",
      type: "audio",
      src: "sound/",
      channel: 3
    }, {
      name: "lex_grunt_2",
      type: "audio",
      src: "sound/",
      channel: 3
    }, {
      name: "lex_grunt_3",
      type: "audio",
      src: "sound/",
      channel: 3
    }, {
      name: "lex_screams_1",
      type: "audio",
      src: "sound/",
      channel: 3
    }, {
      name: "lex_screams_2",
      type: "audio",
      src: "sound/",
      channel: 3
    }, {
      name: "lex_screams_3",
      type: "audio",
      src: "sound/",
      channel: 3
    }])
    me.state.change(me.state.LOADING)

  loaded: ->
    me.state.set(me.state.MENU, new StartScreen())
    me.state.set(me.state.PLAY, new PlayScreen())
    me.state.set(me.state.GAMEOVER, new GameOverScreen())
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

    this.startTimer = me.timer.getTime()
    this.started = false
    this.score = 0
    #me.debug.renderHitBox = true

  bulletZIndex: 49
  bulletZEnemyIndex: 51
  spriteZIndex: 50

  spawnEnemy: ->
    r = !! Math.round(Math.random() * 1)
    if r
      me.game.add(new Entities.GreenMonster(), this.spriteZIndex)
    else
      me.game.add(new Entities.RedMonster(), this.spriteZIndex)

  update: ->
    me.video.clearSurface(me.video.getScreenCanvas().getContext("2d"), "#000")
    window.musicController.update()

    if !this.started && me.timer.getTime() - this.startTimer > 1500
      this.spawnEnemy()
      this.started = true
      
})

GameOverScreen = me.ScreenObject.extend({
  init: ->
    this.parent(true)
    this.overImage = null

  draw: (context) ->
    context.drawImage(this.overImage, 0, 0)
    context.font="30px Verdana"
    context.fillStyle = "yellow"
    context.fillText("Final Score: " + window.App.game.score, 500, 50)

  onDestroyEvent: ->
    me.input.unbindKey(me.input.KEY.ENTER)
    me.input.unbindMouse(me.input.mouse.LEFT)

  onResetEvent: ->
    this.overImage = me.loader.getImage("youlost")
    me.input.bindKey(me.input.KEY.ENTER, "enter", true)
    r = Math.round(Math.random() * 2) + 1
    me.audio.play("lex_screams_#{r}")

  update: ->
    if me.input.isKeyPressed('enter')
      me.state.change(me.state.PLAY)
    true

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
    # window.musicController.cleanup()
    me.input.unbindMouse(me.input.mouse.LEFT)
    me.input.unbindKey(me.input.KEY.X)

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