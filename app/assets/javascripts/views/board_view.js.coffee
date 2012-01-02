Cubic.Views.BoardView = Backbone.View.extend
  tagName:   'div'
  className: 'cubic-board'

  initialize: (params) ->
    _.bindAll this
    @board     = params['board']
    @container = params['container']

    @renderBoard()
    @renderCubes()
    @startClock()

  renderBoard: ->
    @renderFrame()
    @renderSlots()

  renderFrame: ->
    @wrapper = $('<div />').addClass('cubic-wrapper')
    $(@el).append(@wrapper)
    @container.html @el

  renderSlots: ->
    for row in [12..0]
      for col in [0..5]
        @wrapper.append @generateSlotFor(row, col)

  generateSlotFor: (row, col) ->
    $('<div />')
      .addClass('cubic-slot')
      .addClass('cubic-row-'+row)
      .addClass('cubic-column-'+col)

  renderCubes: ->
    return @gameOver()  if @board.isGameOver()

    for row in [0..12]
      for col in [0..5]
        slot = @slotAt(row, col)
        if @board.cubes[row][col]
          color = @board.cubes[row][col]
          slot.css('background', color).removeClass('empty')
        else
          slot.addClass 'empty'

  slotAt: (row, col) ->
    $(@el).find('.cubic-row-'+row+'.cubic-column-'+col)

  startClock: ->
    @clock = new Cubic.Models.Clock
      time_steps: 0.1
      callback  : @update
    @clock.start()
    @gear_position = 0

  update: ->
    while @gear_position >= 40
      @gear_position -= 40
      @board.generateNewLine()
      @renderCubes()
    @moveUp() unless @board.isGameOver()

  moveUp: ->
    @gear_position = @gear_position + 5
    @wrapper.css 'top', -@gear_position

  gameOver: ->
    @clock.stop()
    @renderGameOver()

  renderGameOver: ->
    $(@wrapper).before $('<div />').text('GAME OVER').addClass('cubic-gameover')
