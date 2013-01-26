HUD.ScoreHUD = me.HUD_Item.extend({
  init: (x, y) ->
    this.parent(x, y)
    this.font = new me.BitmapFont("04b03_font", 32)
  draw: (context, x, y) ->
      this.font.draw(context, this.value, this.pos.x + x, this.pos.y + y)
})