setupPlayer = ->
  playables.click (event) -> playNow($(event.currentTarget))
  playNow(playables.first())
  player.addEventListener 'ended', playNext
  player.addEventListener 'error', playNext

playNext = ->
  console.log "in playNext"
  window.currentIndex = currentIndex + 1
  playNow($(playables[currentIndex]))

playNow = (playable) ->
  file = playable.data("file")
  player.src = file
  updateNowPlaying(playable)
  markActive(playable)
  window.currentIndex = playables.index(playable)

markActive = (playable) ->
  playables.removeClass("active")
  playable.addClass("active")

updateNowPlaying = (playable) ->
  $(".now-playing-title").text(playable.data("track"))

window.setupPlayer = setupPlayer
