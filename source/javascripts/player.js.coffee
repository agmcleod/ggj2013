Entities.Player = Entities.BaseEntity.extend({
  init: () ->
    settings = {
      image: "player",
      spritewidth: 128,
      spriteheight: 96,
      shootCooldown: 100,
      entity_source: "player",
      health: 5   
    }
   
    x = (800 / 2) - (settings.spritewidth / 2)
    y = (640 / 2) - (settings.spriteheight / 2)
    this.parent(x, y, settings)
    this.addAnimation("idle",[0])
    this.setCurrentAnimation("idle")
    this.addAnimation("shooting", [1])

  update: ->
    if me.input.isKeyPressed("shoot")
      pos = me.input.mouse.pos
      this.parent(pos, this)
      this.setCurrentAnimation("shooting") if !this.isCurrentAnimation("shooting")
      angle = Math.atan2(pos.y - this.center().y, pos.x - this.center().x) * (180 / Math.PI)
      if angle < 0
        angle = 360 - (-angle)
      this.angle = (angle - 90) * Math.PI/180
      console.log "player: #{this.angle}"
    else
      this.setCurrentAnimation("idle")
      this.parent(null, this)
      this.angle = 0
    true
})