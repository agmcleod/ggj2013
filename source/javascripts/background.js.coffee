Entities.Background = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    settings.spritewidth = 800
    settings.spriteheight = 640
    settings.image = "background"
    this.parent(x, y, settings)

  update: ->
    this.parent()
    true

})