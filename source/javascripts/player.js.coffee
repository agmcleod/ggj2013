Entities.Player = Entities.BaseEntity.extend({
  init: () ->
    settings = {
      image: "player",
      spritewidth: 128,
      spriteheight: 128,
      shootCooldown: 150,
      entity_source: "player",
      health: 10,
      type: me.game.ACTION_OBJECT,
      bulletArray: [0,4]
    }

    this.health = settings.health
   
    x = (800 / 2) - (settings.spritewidth / 2)
    y = (640 / 2) - (settings.spriteheight / 2)
    this.parent(x, y, settings)

    this.addAnimation("idle",[0,1,2,3,2,1])
    this.setCurrentAnimation("idle")
    this.addAnimation("toshooting", [4,5,6])
    this.addAnimation("toidle", [6,5,4])
    this.addAnimation("shooting",[7])
    r = !! Math.round(Math.random() * 1)
    this.startX = this.pos.x
    this.maxX = 50
    this.collidable = true
    this.inShootState = false
    if r
      this.velx = -2
    else
      this.velx = 2


  update: ->
    if me.input.isKeyPressed("shoot")
      pos = me.input.mouse.pos
      if this.inShootState
        this.parent(pos, this)
      else
        this.parent(null, this)

      if !this.isCurrentAnimation("shooting") && !this.isCurrentAnimation("toshooting")
        this.setCurrentAnimation("toshooting", ->
          this.setCurrentAnimation("shooting")
          this.inShootState = true
        )

      angle = Math.atan2(pos.y - this.center().y, pos.x - this.center().x) * (180 / Math.PI)
      if angle < 0
        angle = 360 - (-angle)
      this.angle = (angle - 90) * Math.PI/180
    else
      if this.isCurrentAnimation("shooting")
        this.setCurrentAnimation("toidle", ->
          this.setCurrentAnimation("idle")
        )
        this.inShootState = false
      this.parent(null, this)
      if Math.abs(this.startX - this.pos.x) == this.maxX
        this.velx = -(this.velx)


      this.pos.x += this.velx

      this.angle = 0
    true
})