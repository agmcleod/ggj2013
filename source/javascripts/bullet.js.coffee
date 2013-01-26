Entities.Bullet = me.ObjectEntity.extend({
  init: (x, y, settings) ->
    this.tx = settings.tx
    this.ty = settings.ty
    settings.image = "bullet"
    settings.spriteWidth = 10
    settings.spriteHeight = 10
    this.width = 10
    this.height = 10
    this.speed = 30
    calculateTarget()
    this.parent(x, y, settings)

  calculateTarget: ->
    angle = Math.atan2(ty - y, tx - x) * (180 / Math.PI)
    this.velx = Math.cos(angle * Math.PI / 180) * this.speed * me.timer.tick
    this.vely = Math.sin(angle * Math.PI / 180) * this.speed * me.timer.tick

  update: ->
    if this.pos.x > 800 || this.pos.x < -this.width || this.pos.y < -this.height || this.pos.y > 640
      me.game.remove(this)
})