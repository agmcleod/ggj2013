Entities.RedMonster = Entities.BaseEntity.extend({
  init: ->
    settings = {
      image: "red_monster",
      spritewidth: 128,
      spriteheight: 224,
      shootCooldown: 600,
      entity_source: "enemy",
      health: 2
      timer: me.timer.getTime() + 600,
      type: me.game.ENEMY_OBJECT,
      bulletArray: [2,6,10,14]
    }

    this.collidable = true
    xRanges = [[0, 200], [550, 672]]
    yRanges = [[0, 100], [360, 416]]

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
    this.configPatrolPath()
    this.goingToPatrol = true
    this.originalPosition = {
      x: this.pos.x,
      y: this.pos.y
    }
    this.speed = 5

  configPatrolPath: ->
    xRange = null
    yRange = null
    if this.pos.x < 400
      xRange = [400, 800-this.width]
    else
      xRange = [0, 400]

    if this.pos.y < 320
      yRange = [320, 640-this.height]
    else
      yRange = [0, 320]

    this.targetPatrol = {
      x: Math.round(Math.random() * (xRange[1] - xRange[0])) + xRange[0],
      y: Math.round(Math.random() * (yRange[1] - yRange[0])) + yRange[0]
    }

  moveTo: (position) ->
    angle = Math.atan2(position.y - this.pos.y, position.x - this.pos.x) * (180 / Math.PI)
    velx = Math.cos(angle * Math.PI / 180) * this.speed * me.timer.tick
    vely = Math.sin(angle * Math.PI / 180) * this.speed * me.timer.tick
    this.pos.x += velx
    this.pos.y += vely

    # check if sprite went past

    # if the previous x coordinate is less than the current one (meaning sprite is moving right)
    # and the x passed the target, set it to the target
    if this.pos.x - velx < this.pos.x && this.pos.x > position.x
      this.pos.x = position.x

    # otherwise if the previous coordinate is greater than, meaning it's moving left
    # and the x passed the target, set it to the target
    else if this.pos.x - velx > this.pos.x && this.pos.x < position.x
      this.pos.x = position.x

    # if the previous y coordinate is less than the current one (sprite is moving down)
    # and it passed the target, set it to the target
    if this.pos.y - vely < this.pos.y && this.pos.y > position.y
      this.pos.y = position.y

    # otherwise if the previous y coordinate is greater than the current one (sprite moving up)
    # and it passed the target, set it
    if this.pos.y - vely > this.pos.y && this.pos.y < position.y
      this.pos.y = position.y

    return (this.pos.x == position.x && this.pos.y == position.y)

  patrol: ->
    arrived = false
    if this.goingToPatrol
      arrived = this.moveTo(this.targetPatrol)
    else
      arrived = this.moveTo(this.originalPosition)

    this.goingToPatrol = !this.goingToPatrol if arrived

  update: ->
    # call parent update, passing in player position as target
    v = window.App.game.player.center()
    mod = Math.round(Math.random() * 90)
    add = !! Math.round(Math.random() * 1)
    x = v.x 
    y = v.y
    if !add
      mod *= -1

    x += mod
    y += mod
    this.patrol()
    this.parent({ x: x, y: y }, this)
    true
})