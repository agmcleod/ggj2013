Entities.GreenMonster = Entities.BaseEntity.extend({
  init: ->
    settings = {
      image: "green_monster",
      spritewidth: 160,
      spriteheight: 216,
      shootCooldown: 700,
      entity_source: "enemy",
      health: 2
      timer: me.timer.getTime() + 900,
      type: me.game.ENEMY_OBJECT,
      bulletArray: [1,5,9,13]
    }

    this.collidable = true
    xRanges = [[0, 200], [550, 640]]
    yRanges = [[0, 100], [360, 424]]

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
    this.renderable.addAnimation("idle", [0,1,2,3,2,1])
    this.renderable.setCurrentAnimation("idle")

  update: ->
    # call parent update, passing in player position as target
    this.parent(App.playScreen.player.center(), this)
    true
})