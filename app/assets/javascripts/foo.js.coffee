setupPlayer = ->
  $(".playable").click loadFile

loadFile = (event) ->
  file = $(event.currentTarget).data("file")
  player.load({file:file, autoPlay: true})
  player.play()

window.setupPlayer = setupPlayer
