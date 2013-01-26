Entities.Player = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.parent(x, y, settings)

  update: ->
    this.parent()
    true
})