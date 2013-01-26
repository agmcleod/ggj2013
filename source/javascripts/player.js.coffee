Entities.Player = Entities.BaseEntity.extend({
  init: (x, y, settings) ->
    settings.image = "player"
    settings.spriteWidth = 64
    settings.spriteHeight = 64
    settings.shootCooldown = 200
    this.parent(x, y, settings)

  update: ->
    if me.input.isKeyPressed("shoot")
      this.parent(me.input.mouse.pos)
    else
      this.parent()
    true
})