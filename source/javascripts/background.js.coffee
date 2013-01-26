Entities.Background = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    settings.spritewidth = 800
    settings.spriteheight = 1280
    settings.image = "TowerBG"
    this.parent(x, y, settings)

  update: ->
    this.parent()
    true

})