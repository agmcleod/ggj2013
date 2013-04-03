Entities.Bullet = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.tx = settings.tx
    this.ty = settings.ty
    settings.image = "bullets"
    settings.spritewidth = 20
    settings.spriteheight = 20
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
    if this.renderable.pos.x > 800 || this.renderable.pos.x < -this.width || this.renderable.pos.y < -this.height || this.renderable.pos.y > 640
      me.game.remove(this)

    me.game.collide(this)
    this.renderable.pos.x += this.velx
    this.renderable.pos.y += this.vely
    this.parent()
    true

  addAnimationArray: (arr) ->
    this.arr = arr
    this.renderable.addAnimation("idle", this.arr)
    this.renderable.setCurrentAnimation("idle")
})