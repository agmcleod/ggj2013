(function() {

  HUD.ScoreHUD = me.HUD_Item.extend({
    init: function(x, y, colour) {
      if (colour === null || typeof colour === "undefined") {
        colour = "#0f0";
      }
      this.parent(x, y);
      return this.font = new me.Font("Verdana, Helvetica, Arial, sans-serif", 24, colour, "top");
    },
    draw: function(context, x, y) {
      return this.font.draw(context, this.value, this.pos.x + x, this.pos.y + y);
    }
  });

}).call(this);
