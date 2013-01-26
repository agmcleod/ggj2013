Entities.Player = Entities.BaseEntity.extend({
  init: () ->
    settings = {
      image: "player",
      spritewidth: 128,
      spriteheight: 96,
      shootCooldown: 150,
      entity_source: "player",
      health: 5,
      type: me.game.ACTION_OBJECT
    }

    this.health = settings.health
   
    x = (800 / 2) - (settings.spritewidth / 2)
    y = (640 / 2) - (settings.spriteheight / 2)
    this.parent(x, y, settings)

    this.addAnimation("idle",[0])
    this.setCurrentAnimation("idle")
    this.addAnimation("shooting", [1])
    r = Math.floor(Math.random())
    this.startX = this.pos.x
    this.maxX = 50
    if r == 0
      this.velx = -2
    else
      this.velx = 2


  update: ->
    if me.input.isKeyPressed("shoot")
      pos = me.input.mouse.pos
      this.parent(pos, this)
      this.setCurrentAnimation("shooting") if !this.isCurrentAnimation("shooting")
      angle = Math.atan2(pos.y - this.center().y, pos.x - this.center().x) * (180 / Math.PI)
      if angle < 0
        angle = 360 - (-angle)
      this.angle = (angle - 90) * Math.PI/180
    else
      this.setCurrentAnimation("idle")
      this.parent(null, this)
      if Math.abs(this.startX - this.pos.x) == this.maxX
        this.velx = -(this.velx)


      this.pos.x += this.velx

      this.angle = 0
    true
})