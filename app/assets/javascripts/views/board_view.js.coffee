Cubic.Views.BoardView = Backbone.View.extend
  tagName:   'div'
  className: 'cubic-board'

  initialize: (params) ->
    _.bindAll this
    @renderBoard params['container']
    @initCubes()
    @renderCubes()
    @startClock()

  renderBoard: (container) ->
    $(container).html(@el)
    @wrapper = $('<div />').addClass('cubic-wrapper')
    @wrapper_pos = 0
    $(@el).append(@wrapper)

    for y in [12..0]
      for x in [0..5]
        slot = $('<div />')
          .addClass('cubic-slot')
          .addClass('cubic-row-'+y)
          .addClass('cubic-column-'+x)
        @wrapper.append slot


  startClock: ->
    @clock = new Cubic.Models.Clock
      time_steps: 0.1
      callback  : @update
    @clock.start()

  update: ->
    @wrapper_pos += 4
    while @wrapper_pos >= 40
      @generateNewLine()
      @renderCubes()
      @wrapper_pos -= 40
    @wrapper.css 'top', - @wrapper_pos * 1
    for x in [0..5]
      return @gameOver()  if @cubes[12][x]

  initCubes: ->
    @cubes = []
    @cubes.push [false, false, false, false, false, false]  for i in [0..12]

    for y in [0..6]
      for x in [0..5]
        @cubes[y][x] = ['red', 'blue', '#f90', 'green'].sample()

  renderCubes: ->
    for y in [0..12]
      for x in [0..5]
        slot = $(@el).find('.cubic-row-'+y+'.cubic-column-'+x)
        if @cubes[y][x]
          color = @cubes[y][x]
          slot.css('background', color).removeClass('empty')
        else
          slot.addClass 'empty'

  generateNewLine: ->
    for y in [12..1]
      for x in [0..5]
        @cubes[y][x] = @cubes[y-1][x]

    for x in [0..5]
      @cubes[0][x] = ['red', 'blue', '#f90', 'green'].sample()

  gameOver: ->
    @clock.stop()
    game_over = $('<div />').text('GAME OVER').addClass('cubic-gameover')
    $(@wrapper).before game_over