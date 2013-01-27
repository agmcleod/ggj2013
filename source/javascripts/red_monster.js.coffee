Entities.RedMonster = Entities.BaseEntity.extend({
  init: ->
    settings = {
      image: "red_monster",
      spritewidth: 128,
      spriteheight: 224,
      shootCooldown: 600,
      entity_source: "enemy",
      health: 2
      timer: me.timer.getTime() + 400,
      type: me.game.ENEMY_OBJECT
    }

    this.collidable = true
    x = Math.floor(Math.random() * 550) + 10
    y = Math.floor(Math.random() * 450) + 10
    this.parent(x, y, settings)
    this.addAnimation("idle", [0,1,2,3,2,1])
    this.setCurrentAnimation("idle")

  update: ->
    # call parent update, passing in player position as target
    v = window.App.game.player.center()
    mod = Math.round(Math.random() * 90)
    add = !! Math.round(Math.random() * 1)
    x = v.x 
    y = v.y
    if !add
      mod *= -1

    x += mod
    y += mod
    this.parent({ x: x, y: y }, this)
    true
})