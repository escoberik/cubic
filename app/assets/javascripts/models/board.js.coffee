Cubic.Models.Board = Backbone.Model.extend
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

      @cubes[0][x] = new Cubic.Models.Cube(forbidden)
    @marker.moveUp()

  check: ->
    @checkRow(row)     for row in [1..12]
    @checkColumn(col)  for col in [0..5]

  checkRow: (row) ->
    for col in [0..3]
      return  unless @cubes[row][col] && @cubes[row][col+1] && @cubes[row][col+2]
      color1 = @cubes[row][col].get('color')
      color2 = @cubes[row][col+1].get('color')
      color3 = @cubes[row][col+2].get('color')

      if color1 == color2 && color2 == color3
        @cubes[row][col]   = false
        @cubes[row][col+1] = false
        @cubes[row][col+2] = false
        @fillBlankSpaces()

  checkColumn: (col) ->
    for row in [1..9]
      return  unless @cubes[row][col] && @cubes[row+1][col] && @cubes[row+2][col]
      color1 = @cubes[row][col].get('color')
      color2 = @cubes[row+1][col].get('color')
      color3 = @cubes[row+2][col].get('color')

      if color1 == color2 && color2 == color3
        @cubes[row][col] = false
        @cubes[row+1][col] = false
        @cubes[row+2][col] = false
        @fillBlankSpaces()

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
  