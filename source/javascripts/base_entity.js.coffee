Entities.BaseEntity = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.shootCooldown = settings.shootCooldown
    this.timer = me.timer.getTime()
    this.entity_source = settings.entity_source
    this.health = settings.health
    this.parent(x, y, settings)

  center: ->
    {
      x: this.pos.x + (this.width / 2),
      y: this.pos.y + (this.height / 2)
    }

  onCollision: (res, obj) ->
    if obj['source'] != null && obj['source'] != this.entity_source
      this.health -= obj.damage
      if obj.source == "player" && this.health <= 0
        me.game.remove(this)
        me.game.HUD.updateItemValue("score", 100)

    else if obj['entity_source'] != null && obj['entity_source'] != this.entity_source
      this.health -= 1


  shoot: (target) ->
    bullet = new Entities.Bullet(this.center().x, this.center().y, { tx: target.x, ty: target.y, source: this.entity_source })
    bullet.addAnimationArray([0], true)
    if this.entity_source == "enemy"
      me.game.add(bullet, window.App.game.bulletZEnemyIndex)
    else if this.entity_source == "player"
      me.game.add(bullet, window.App.game.bulletZIndex)
    
  update: (target, obj) ->
    if target != null && typeof target != "undefined" && (me.timer.getTime() - this.timer) > this.shootCooldown
      this.shoot(target)
      this.timer = me.timer.getTime()

    this.parent(obj)
    true

})