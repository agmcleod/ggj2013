class window.MusicController
  init: ->
    this.tracks = {
      intro: { 
        file: "112bpm_fade_in_final",
        time: 17000,
        i: 0
      },
      loop: { 
        file: "112bpm_loop_final",
        time: 17000,
        i: 1
      }
    }
    this.play("intro", "loop")

  cleanup: ->
    me.audio.stopTrack()

  play: (track_name, callbackTrack) ->
    me.audio.play(this.tracks[track_name].file, false, =>
      me.audio.playTrack(this.tracks[callbackTrack].file)
    )

  playFadeout: ->
    me.audio.stopTrack()
    me.audio.play(this.tracks["end"].file, false, =>
      this.play("intro", "loop")
    )
