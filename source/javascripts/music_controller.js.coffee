class window.MusicController
  init: ->
    this.tracks = {
      intro: { 
        file: "112bpm_fade_in_intro",
        time: 25000,
        i: 0
      },
      layerOne: { 
        file: "112bpm_1_layer_loop",
        time: 17000,
        i: 1
      },
      layerTwo: { 
        file: "112bpm_2_layer_loop",
        time: 17000,
        i: 2
      },
      layerThree: { 
        file: "112bpm_3_layer_loop",
        time: 17000,
        i: 3
      }
    }
    this.play("intro")

  cleanup: ->
    me.audio.stopTrack()

  play: (track_name) ->
    if this.playing
      me.audio.stopTrack()
    this.timer = me.timer.getTime()
    me.audio.playTrack(this.tracks[track_name].file)
    this.currentTrack = track_name
    this.playing = true

  update: ->
    t = this.tracks[this.currentTrack].time
    if this.currentTrack != "layerThree" && (me.timer.getTime() - this.timer) >= t
      me.audio.stopTrack()
      t_name = ''
      for own name, track of this.tracks
        console.log "if #{track.i} == #{this.tracks[this.currentTrack].i + 1}"
        if track.i == (this.tracks[this.currentTrack].i + 1)
          t_name = name
          break
      console.log "t_name: #{t_name}"
      this.play(t_name) if t_name != ''
