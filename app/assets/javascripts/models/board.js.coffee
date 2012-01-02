Cubic.Models.Board = Backbone.Model.extend
  defaults:
    score: 0

  initialize: ->
    _.bindAll this
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
      @cubes[0][x] = new Cubic.Models.Cube forbidden: forbidden
    @marker.moveUp()

  check: ->
    @fillBlankSpaces()
    @checkRow(row)     for row in [1..12]
    @checkColumn(col)  for col in [0..5]
    @clean()
    @fillBlankSpaces()

  checkRow: (row) ->
    for col in [0..3]
      cube1 = @cubes[row][col]
      cube2 = @cubes[row][col+1]
      cube3 = @cubes[row][col+2]
      return  unless cube1 && cube2 && cube3

      if cube1.get('color') == cube2.get('color') && cube2.get('color') == cube3.get('color')
        cube1.set destroy: true
        cube2.set destroy: true
        cube3.set destroy: true

  checkColumn: (col) ->
    for row in [1..10]
      cube1 = @cubes[row][col]
      cube2 = @cubes[row+1][col]
      cube3 = @cubes[row+2][col]
      return  unless cube1 && cube2 && cube3

      if cube1.get('color') == cube2.get('color') && cube2.get('color') == cube3.get('color')
        cube1.set destroy: true
        cube2.set destroy: true
        cube3.set destroy: true

  clean: ->
    counter = 0
    for row in [1..12]
      for col in [0..5]
        if @cubes[row][col] && @cubes[row][col].get('destroy')
          @cubes[row][col] = false
          counter += 1
    if counter > 0
      @check()
      @set score: @get('score') + counter - 2

  fillBlankSpaces: ->
    for row in [1..11]
      for col in [0..5]
        unless @cubes[row][col]
          r = row
          until @cubes[r][col] || r >= 12
            r += 1
            @cubes[row][col] = @cubes[r][col]
          @cubes[r][col] = false

  moveUp: ->
    for y in [12..1]
      for x in [0..5]
        @cubes[y][x] = @cubes[y-1][x]

  isGameOver: ->
    for x in [0..5]
      return true  if @cubes[12][x]
    false
  