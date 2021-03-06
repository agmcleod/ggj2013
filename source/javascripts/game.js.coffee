window.App = {
  init: ->

    if !me.video.init("app", 800, 640, false, "auto", true)
      alert "your browser does not support the canvas"

    me.audio.init("mp3,ogg")
    me.loader.onload = this.loaded.bind(this)
    me.loader.preload([{
      name: "TowerBG",
      type: "image",
      src: "images/TowerBG.jpg"
    }, {
      name: "Tower_BlurBG",
      type: "image",
      src: "images/Tower_BlurBG.jpg"
    } ,{
      name: "bullets",
      type: "image",
      src: "images/bullets.png"
    }, {
      name: "player",
      type: "image",
      src: "images/player.png"
    }, {
      name: "green_monster",
      type: "image",
      src: "images/green_monster.png"
    },{
      name: "red_monster",
      type: "image",
      src: "images/red_monster.png"
    },{
      name: "blue_monster",
      type: "image",
      src: "images/blue_monster.png"
    },{
      name: "frame1",
      type: "image",
      src: "images/Frame1.png"
    },{
      name: "frame2",
      type: "image",
      src: "images/Frame2.png"
    },{
      name: "frame3",
      type: "image",
      src: "images/Frame3.png"
    },{
      name: "youlost",
      type: "image",
      src: "images/YouLost.png"
    },{
      name: "title",
      type: "image",
      src: "images/Title1.jpg"
    },{
      name: "hearts",
      type: "image",
      src: "images/hearts.png"
    },{
      name: "gunshot_a",
      type: "audio",
      src: "sound/"
    },{
      name: "112bpmfull",
      type: "audio",
      src: "sound/"
    },{
      name: "140bpmfull",
      type: "audio",
      src: "sound/"
    },{
      name: "170bpmfull",
      type: "audio",
      src: "sound/"
    },{
      name: "220bpmfull",
      type: "audio",
      src: "sound/"
    },{
      name: "320bpm_intro_final",
      type: "audio",
      src: "sound/"
    },{
      name: "320bpm_loop_final",
      type: "audio",
      src: "sound/"
    }, {
      name: "lex_grunt_1",
      type: "audio",
      src: "sound/",
      channel: 3
    }, {
      name: "lex_grunt_2",
      type: "audio",
      src: "sound/"
    }, {
      name: "lex_grunt_3",
      type: "audio",
      src: "sound/"
    }, {
      name: "lex_screams_1",
      type: "audio",
      src: "sound/"
    }, {
      name: "lex_screams_2",
      type: "audio",
      src: "sound/"
    }, {
      name: "lex_screams_3",
      type: "audio",
      src: "sound/"
    }])
    me.state.change(me.state.LOADING)

  loaded: ->
    me.state.set(me.state.MENU, new Screens.StartScreen())
    App.playScreen = new Screens.PlayScreen()
    me.state.set(me.state.PLAY, App.playScreen)
    me.state.set(me.state.GAMEOVER, new Screens.GameOverScreen())
    me.state.change(me.state.MENU)
}
isIOS = ->
  userAgent().indexOf('iphone') != -1 || userAgent().indexOf('ipad') != -1

userAgent = ->
  window.navigator.userAgent.toLowerCase()

window.onReady ->
  App.init()
