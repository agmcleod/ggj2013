Entities.GreenMonster = Entities.BaseEntity.extend({
  init: ->
    settings = {
      image: "player",
      spritewidth: 128,
      spriteheight: 96,
      shootCooldown: 500,
      entity_source: "enemy",
      health: 2
    }
})