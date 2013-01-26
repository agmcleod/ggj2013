Entities.Player = Entities.BaseEntity.extend({
  init: (x, y, settings) ->
    settings.image = "player"
    settings.spriteWidth = 128
    settings.spriteHeight = 96
    settings.shootCooldown = 200
    settings.entity_source = "player"
    settings.health = 5
    this.parent(x, y, settings)
    this.addAnimation("idle",[0])
    this.setCurrentAnimation("idle")


  update: ->
    if me.input.isKeyPressed("shoot")
      this.parent(me.input.mouse.pos)
    else
      this.parent()
    true
})