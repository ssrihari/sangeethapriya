setupPlayer = ->
  playables = $(".playable")
  playables.click (event) -> playNow($(event.currentTarget))
  playNow(playables.last())

playNow = (playable) ->
  file = playable.data("file")
  player.src = file
  updateNowPlaying(playable)

updateNowPlaying = (playable) ->
  $(".now-playing-title").text(playable.data("track"))

window.setupPlayer = setupPlayer
