Entities.BaseEntity = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.parent(x, y, settings)

    this.shootCooldown = settings.shootCooldown
    this.timer = settings.timer
    if this.timer == null || typeof this.timer == "undefined"
      this.timer = me.timer.getTime()
    this.entity_source = settings.entity_source
    this.health = settings.health
    this.bulletArray = settings.bulletArray
    
    this.collidable = true
    this.type = settings.type

  center: ->
    {
      x: this.pos.x + (this.width / 2),
      y: this.pos.y + (this.height / 2)
    }

  onCollision: (res, obj) ->
    if obj['source'] != null && obj['source'] != this.entity_source
      this.health -= obj.damage
      this.flicker(20)
      if this.entity_source == "player"
        me.game.HUD.setItemValue("health", "HP: #{this.health}")

      if this.health <= 0
        if obj.source == "player"
          me.game.remove(this)
          me.game.remove(obj)
          window.App.game.score += 100
          me.game.HUD.updateItemValue("score", 100)
          App.game.spawnEnemy()
        else
          obj.visible = false
          obj.collidable = false
          me.game.remove(obj)
          me.game.removeAll()
          me.state.change(me.state.GAMEOVER)

      else
        obj.visible = false
        obj.collidable = false
        me.game.remove(obj)

  shoot: (target) ->
    bullet = new Entities.Bullet(this.center().x, this.center().y, { tx: target.x, ty: target.y, source: this.entity_source })
    bullet.addAnimationArray(this.bulletArray)
    addedBullet = false
    if this.entity_source == "enemy"
      me.game.add(bullet, window.App.game.bulletZEnemyIndex)
      addedBullet = true
    else if this.entity_source == "player"
      me.game.add(bullet, window.App.game.bulletZIndex)
      addedBullet = true

    if addedBullet
      me.game.sort()
      me.audio.play("gunshot_a")
    
  update: (target, obj) ->
    if target != null && typeof target != "undefined" && (me.timer.getTime() - this.timer) > this.shootCooldown
      this.shoot(target)
      this.timer = me.timer.getTime()

    this.parent(obj)
    true

})