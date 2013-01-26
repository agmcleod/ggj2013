Entities.Bullet = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.tx = settings.tx
    this.ty = settings.ty
    settings.image = "bullets"
    settings.spritewidth = 16
    settings.spriteheight = 16
    this.parent(x, y, settings)
    this.speed = 10
    this.source = settings.source
    this.damage = 1
    this.timer = me.timer.getTime()
    this.calculateTarget()
    this.collidable = true
    this.type = me.game.ACTION_OBJECT

  calculateTarget: ->
    angle = Math.atan2(this.ty - this.pos.y, this.tx - this.pos.x) * (180 / Math.PI)
    this.velx = Math.cos(angle * Math.PI / 180) * this.speed * me.timer.tick
    this.vely = Math.sin(angle * Math.PI / 180) * this.speed * me.timer.tick
    if angle < 0
      angle = 360 - (-angle)
    this.angle = (angle - 90) * Math.PI/180

  update: ->
    if this.pos.x > 800 || this.pos.x < -this.width || this.pos.y < -this.height || this.pos.y > 640
      me.game.remove(this)

    if !this.isCurrentAnimation("idle2") && me.timer.getTime() - this.timer > 50
      this.addAnimation("idle2", [this.arr[0]+1])
      this.setCurrentAnimation("idle2")

    res = me.game.collide(this)
    #if res && (this.source == "enemy" && res.obj.entity_source == "player") || (this.source == "player" && res.obj.entity_source == "enemy")
      #this.visible = false
      #this.collidable = false
      # me.game.remove(this)
    #else
    this.pos.x += this.velx
    this.pos.y += this.vely
    this.parent()
    true

  addAnimationArray: (arr) ->
    this.arr = arr
    this.addAnimation("idle", this.arr)
    this.setCurrentAnimation("idle")
})