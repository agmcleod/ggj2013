Screens.PlayScreen = me.ScreenObject.extend({
  bulletZIndex: 49
  bulletZEnemyIndex: 51
  spriteZIndex: 50

  init: ->
    this.parent(true)

  onDestroyEvent: ->
    me.game.disableHUD()
    # window.musicController.cleanup()
    me.input.unbindMouse(me.input.mouse.LEFT)
    me.input.unbindKey(me.input.KEY.X)
    me.input.unbindTouch()

  onResetEvent: ->
    me.game.addHUD(0, 0, 800, 640)
    me.input.bindKey(me.input.KEY.X, "shoot")
    me.input.bindMouse(me.input.mouse.LEFT, me.input.KEY.X)
    me.input.bindTouch(me.input.KEY.X)

    this.backgrounds = [
      new Entities.Background(0, 0, {}),
      new Entities.Background(0, 1280, {})
    ]
    this.bottomBackground = 0
    me.game.add(this.backgrounds[0], 0)
    me.game.add(this.backgrounds[1], 0)

    player = new Entities.Player()
    me.game.add(player, this.spriteZIndex)
    this.player = player

    me.game.HUD.addItem("score", new HUD.ScoreHUD(650, 30, 'yellow'))
    me.game.HUD.addItem("health", new HUD.HealthHUD(20, 10))

    this.startTimer = me.timer.getTime()
    this.started = false
    this.score = 0

  spawnEnemy: ->
    r =  Math.round(Math.random() * 2)
    if r == 0
      me.game.add(new Entities.GreenMonster(), this.spriteZIndex)
    else if r == 1
      me.game.add(new Entities.RedMonster(), this.spriteZIndex)
    else if r == 2
      me.game.add(new Entities.BlueMonster(), this.spriteZIndex)

  update: ->
    me.video.clearSurface(me.video.getScreenCanvas().getContext("2d"), "#000")

    if !this.started && me.timer.getTime() - this.startTimer > 1500
      this.spawnEnemy()
      this.started = true
})