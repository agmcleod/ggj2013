HUD.HealthHUD = me.HUD_Item.extend({
  init: (x, y) ->
    this.parent(x, y)
    this.image = me.loader.getImage("hearts")

  draw: (context, x, y) ->
    for i in [0..parseInt(this.value)] by 1
      #console.log "draw at: #{i} #{this.pos.x + (i * 32)},#{this.pos.y}"
      context.drawImage(this.image, this.pos.x + (i * 32), this.pos.y)

})