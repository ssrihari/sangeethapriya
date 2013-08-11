setupPlayer = ->
  playables.click (event) -> playNow($(event.currentTarget))
  playNow(playables.first())

playNow = (playable) ->
  file = playable.data("file")
  player.src = file
  updateNowPlaying(playable)
  markActive(playable)

markActive = (playable) ->
  playables.removeClass("active")
  playable.addClass("active")


updateNowPlaying = (playable) ->
  $(".now-playing-title").text(playable.data("track"))

window.setupPlayer = setupPlayer
