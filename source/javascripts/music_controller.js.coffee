class window.MusicController
  init: ->
    this.tracks = {
      intro: "112bpm_fade_in_intro",
      layerOne: "112bpm_1_layer_loop",
      layerTwo: "112bpm_2_layer_loop",
      layerThree: "112bpm_3_layer_loop"
    }
    this.play("intro")

  cleanup: ->
    me.audio.stopTrack()

  play: (track_name) ->
    if this.playing
      me.audio.stopTrack()
    me.audio.playTrack(this.tracks[track_name])
    this.playing = true