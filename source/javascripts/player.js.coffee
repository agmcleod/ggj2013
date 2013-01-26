Entities.Player = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    settings.image = "player"
    settings.spriteWidth = 64
    settings.spriteHeight = 64
    this.parent(x, y, settings)

  update: ->
    this.parent()
    true
})