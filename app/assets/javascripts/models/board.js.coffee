Cubic.Models.Board = Backbone.Model.extend
  initialize: ->
    @marker = new Cubic.Models.Marker(this)
    @initCubes()

  initCubes: ->
    @cubes = []
    @cubes.push [false, false, false, false, false, false]  for i in [0..12]
    for y in [0..7]
      @generateNewLine()

  generateNewLine: ->
    @moveUp()
    for x in [0..5]
      forbidden = []
      forbidden.push @cubes[1][x].get('color')  if @cubes[1][x]
      forbidden.push @cubes[0][x-1].get('color')  if x > 0

      @cubes[0][x] = new Cubic.Models.Cube(forbidden)
    @marker.moveUp()

  moveUp: ->
    for y in [12..1]
      for x in [0..5]
        @cubes[y][x] = @cubes[y-1][x]

  isGameOver: ->
    for x in [0..5]
      return true  if @cubes[12][x]
    false
  