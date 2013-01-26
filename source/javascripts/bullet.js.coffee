Entities.Bullet = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.tx = settings.tx
    this.ty = settings.ty
    settings.image = "bullets"
    settings.spriteWidth = 16
    settings.spriteHeight = 16
    this.width = 16
    this.height = 16
    this.speed = 30
    this.source = settings.source
    this.damage = 1
    this.parent(x, y, settings)
    this.calculateTarget()

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

    this.pos.x += this.velx
    this.pos.y += this.vely
    this.parent()
    true

  setAnimationArray: (arr) ->
    this.addAnimation("idle", arr)
})