Entities.GreenMonster = Entities.BaseEntity.extend({
  init: ->
    settings = {
      image: "green_monster",
      spritewidth: 160,
      spriteheight: 216,
      shootCooldown: 500,
      entity_source: "enemy",
      health: 2
      timer: me.timer.getTime() + 500, # put 500 milliseconds in the future, given a cooldown before it can fire
      type: me.game.ENEMY_OBJECT,
      bulletArray: [1,4,7,10]
    }

    this.collidable = true
    x = Math.floor(Math.random() * 550) + 10
    y = Math.floor(Math.random() * 450) + 10
    this.parent(x, y, settings)
    this.addAnimation("idle", [0,1,2,3,2,1])
    this.setCurrentAnimation("idle")

  update: ->
    # call parent update, passing in player position as target
    this.parent(window.App.game.player.center(), this)
    true
})