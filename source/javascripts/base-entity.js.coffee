Entities.BaseEntity = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.shootCooldown = settings.shootCooldown
    this.timer = me.timer.getTime()
    this.source = settings.source
    this.health = settings.health
    this.parent(x, y, settings)

  onCollision: (res, obj) ->
    if obj['source'] != this.source
      this.health -= obj.damage


  shoot: (target) ->
    me.game.add(new Bullet(this.pos.x, this.pos.y, { tx: target.x, ty: target.y, source: this.source }), window.App.game.bulletZIndex)
    
  update: (target) ->
    if target != null && typeof target != "undefined" && (me.timer.getTime() - this.timer) > this.shootCooldown
      shoot(target)

})