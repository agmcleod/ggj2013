Entities.Background = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    settings.spritewidth = 800
    settings.spriteheight = 1280
    settings.image = "Tower_BlurBG"
    this.parent(x, y, settings)

  update: ->
    this.pos.y -= 40 * me.timer.tick
    if this.pos.y <= -1280
      this.pos.y = 1280
    this.parent()
    true

})