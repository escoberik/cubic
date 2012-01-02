Cubic.Models.Board = Backbone.Model.extend
  initialize: ->
    @initCubes()
    @marker = new Cubic.Models.Marker(this)

  initCubes: ->
    @cubes = []
    @cubes.push [false, false, false, false, false, false]  for i in [0..12]
    for y in [0..7]
      for x in [0..5]
        @cubes[y][x] = new Cubic.Models.Cube()

  generateNewLine: ->
    for y in [12..1]
      for x in [0..5]
        @cubes[y][x] = @cubes[y-1][x]
    for x in [0..5]
      @cubes[0][x] = new Cubic.Models.Cube()
    @marker.moveUp()

  isGameOver: ->
    for x in [0..5]
      return true  if @cubes[12][x]
    false
  