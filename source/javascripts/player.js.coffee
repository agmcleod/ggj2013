Entities.Player = Entities.BaseEntity.extend({
  init: () ->
    settings = {
      image: "player",
      spritewidth: 128,
      spriteheight: 96,
      shootCooldown: 200,
      entity_source: "player",
      health: 5   
    }
   
    x = (800 / 2) - (settings.spritewidth / 2)
    y = (640 / 2) - (settings.spriteheight / 2)
    this.parent(x, y, settings)
    this.addAnimation("idle",[0])
    this.setCurrentAnimation("idle")


  update: ->
    if me.input.isKeyPressed("shoot")
      this.parent(me.input.mouse.pos, this)
    else
      this.parent(null, this)
    true
})