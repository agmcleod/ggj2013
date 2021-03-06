Entities.Bullet = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.tx = settings.tx
    this.ty = settings.ty
    settings.image = "bullets"
    settings.spritewidth = 20
    settings.spriteheight = 20
    this.parent(x, y, settings)
    this.collidable = true
    this.speed = 10
    this.source = settings.source
    this.damage = 1
    this.timer = me.timer.getTime()
    this.calculateTarget()
    this.type = me.game.ACTION_OBJECT
    this.alwaysUpdate = true

  calculateTarget: ->
    angle = Math.atan2(this.ty - this.pos.y, this.tx - this.pos.x) * (180 / Math.PI)
    this.velx = Math.cos(angle * Math.PI / 180) * this.speed * me.timer.tick
    this.vely = Math.sin(angle * Math.PI / 180) * this.speed * me.timer.tick
    if angle < 0
      angle = 360 - (-angle)
    this.renderable.angle = (angle - 90) * Math.PI/180


  update: ->
    #this.updateMovement()
    if this.pos.x > 800 || this.pos.x < -this.width || this.pos.y < -this.height || this.pos.y > 640
      me.game.remove(this)
    else
      me.game.collide(this);
      this.pos.x += this.velx
      this.pos.y += this.vely
      this.parent(this)
      true

  addAnimationArray: (arr) ->
    this.arr = arr
    this.renderable.addAnimation("idle", this.arr)
    this.renderable.setCurrentAnimation("idle")
})