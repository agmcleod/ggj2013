HUD.HealthHUD = me.HUD_Item.extend({
  init: (x, y) ->
    this.parent(x, y)
    this.image = me.loader.getImage("hearts")

  draw: (context, x, y) ->
    for i in [0..parseInt(this.value)] by 1
      context.drawImage(this.image, this.pos.x + (i * 32), this.pos.y)

})