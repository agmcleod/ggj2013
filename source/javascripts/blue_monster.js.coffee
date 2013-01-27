Entities.BlueMonster = Entities.BaseEntity.extend({
  init: ->
    settings = {
      image: "blue_monster",
      spritewidth: 128,
      spriteheight: 169,
      shootCooldown: 500,
      entity_source: "enemy",
      health: 2
      timer: me.timer.getTime() + 500, # put 500 milliseconds in the future, given a cooldown before it can fire
      type: me.game.ENEMY_OBJECT,
      bulletArray: [1,4,7,10]
    }

    this.collidable = true
    xRanges = [[0, 200], [550, 672]]
    yRanges = [[0, 100], [360, 471]]

    xSection = !! Math.round(Math.random() * 1)
    ySection = !! Math.round(Math.random() * 1)

    xRange = null
    xBase = null
    yRange = null
    yBase = null
    if xSection
      xRange = xRanges[0][1] - xRanges[0][0]
      xBase = xRanges[0][0]
    else
      xRange = xRanges[1][1] - xRanges[1][0]
      xBase = xRanges[1][0]

    if ySection
      yRange = yRanges[0][1] - yRanges[0][0]
      yBase = yRanges[0][0]
    else
      yRange = yRanges[1][1] - yRanges[1][0]
      yBase = yRanges[1][0]

    x = Math.floor(Math.random() * xRange) + xBase
    y = Math.floor(Math.random() * yRange) + yBase
    this.parent(x, y, settings)
    this.addAnimation("idle", [0,1,2,3,2,1])
    this.setCurrentAnimation("idle")

  update: ->
    # call parent update, passing in player position as target
    this.parent(window.App.game.player.center(), this)
    true
})