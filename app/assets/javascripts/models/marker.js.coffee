Cubic.Models.Marker = Backbone.Model.extend
  initialize: (board) ->
    @board = board
    @row   = 5
    @col   = 3

  moveUp: ->
    @row += 1  unless @row >= 11

  moveDown: ->
    @row -= 1  unless @row <= 1

  moveLeft: ->
    @col -= 1  unless @col <= 0

  moveRight: ->
    @col += 1  unless @col >= 4

  switch: ->
    helper = @board.cubes[@row][@col]
    @board.cubes[@row][@col] = @board.cubes[@row][@col+1]
    @board.cubes[@row][@col+1] = helper
