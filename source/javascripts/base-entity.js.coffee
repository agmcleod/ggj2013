Entities.BaseEntity = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.shootCooldown = settings.shootCooldown
    this.timer = me.timer.getTime()
    this.entity_source = settings.entity_source
    this.health = settings.health
    this.parent(x, y, settings)

  onCollision: (res, obj) ->
    if obj['source'] != null && obj['source'] != this.entity_source
      this.health -= obj.damage
    else if obj['entity_source'] != null && obj['entity_source'] != this.entity_source
      this.health -= 1


  shoot: (target) ->
    me.game.add(new Bullet(this.pos.x, this.pos.y, { tx: target.x, ty: target.y, source: this.entity_source }), window.App.game.bulletZIndex)
    
  update: (target) ->
    if target != null && typeof target != "undefined" && (me.timer.getTime() - this.timer) > this.shootCooldown
      shoot(target)

})