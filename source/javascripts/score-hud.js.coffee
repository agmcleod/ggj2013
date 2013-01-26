HUD.ScoreHUD = me.HUD_Item.extend({
  init: (x, y) ->
    this.parent(x, y)
    this.font = new me.Font("Verdana, Helvetica, Arial, sans-serif", 24, "#f00", "top")
  draw: (context, x, y) ->
      this.font.draw(context, this.value, this.pos.x + x, this.pos.y + y)
})