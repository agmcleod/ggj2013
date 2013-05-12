Entities.BaseEntity = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.collidable = true
    this.parent(x, y, settings)

    this.shootCooldown = settings.shootCooldown
    this.timer = settings.timer
    if this.timer == null || typeof this.timer == "undefined"
      this.timer = me.timer.getTime()
    this.entity_source = settings.entity_source
    this.health = settings.health
    this.bulletArray = settings.bulletArray
    this.alwaysUpdate = true;
    this.type = settings.type

  center: ->
    {
      x: this.pos.x + (this.width / 2),
      y: this.pos.y + (this.height / 2)
    }

  onCollision: (res, obj) ->
    console.log 'collide!'
    if obj['source'] != null && obj['source'] != this.entity_source
      this.health -= obj.damage
      this.renderable.flicker(20)
      if this.entity_source == "player"
        me.game.HUD.setItemValue("health", "HP: #{this.health}")
        r = Math.round(Math.random() * 2) + 1
        me.audio.play("lex_grunt_#{r}")

      if this.health <= 0
        if obj.source == "player"
          me.game.remove(this, true)
          me.game.remove(obj, true)
          window.App.game.score += 100
          me.game.HUD.updateItemValue("score", 100)
          App.playScreen.spawnEnemy()
        else
          obj.visible = false
          obj.collidable = false
          me.game.remove(obj, true)
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
      me.game.add(bullet, App.playScreen.bulletZEnemyIndex)
      addedBullet = true
    else if this.entity_source == "player"
      me.game.add(bullet, App.playScreen.bulletZIndex)
      addedBullet = true

    if addedBullet
      me.game.sort()
      me.audio.play("gunshot_a", false, null, 0.2)
    
  update: (target, obj) ->
    if target != null && typeof target != "undefined" && (me.timer.getTime() - this.timer) > this.shootCooldown
      this.shoot(target)
      this.timer = me.timer.getTime()

    this.parent(obj)
    true

})