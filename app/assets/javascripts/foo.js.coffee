setupPlayer = ->
  $("#jwplayer").css("margin", "0 auto")
  $(".playable").click loadFile

loadFile = (event) ->
  playable = $(event.currentTarget)
  file = playable.data("file")
  player.load({file:file, autoPlay: true})
  updateNowPlaying(playable.data("track"))
  player.play()

updateNowPlaying = (track) ->
  $(".now-playing-title").text(track)

window.setupPlayer = setupPlayer
