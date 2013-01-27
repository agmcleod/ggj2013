class window.MusicController
  init: ->
    this.tracks = ["112bpmfull", "140bpmfull", "170bpmfull", "220bpmfull", "320bpm_intro_final", "320bpm_loop_final"]
    this.play()

  cleanup: ->
    me.audio.stopTrack()

  play: ->
    t = this.tracks
    me.audio.play(t[0], false, ->
      me.audio.play(t[1], false, ->
        me.audio.play(t[2], false, ->
          me.audio.play(t[3], false, ->
            me.audio.play(t[4], false, ->
              me.audio.playTrack(t[5])
            )
          )
        )
      )
    )