Cubic.Views.BoardView = Backbone.View.extend
  tagName:   'div'
  className: 'cubic-board'

  initialize: (params) ->
    _.bindAll this
    @board     = params['board']
    @container = params['container']

    @renderBoard()
    @renderCubes()
    @renderMarker()
    @bindKeys()
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
        @renderSlotAt(row, col)

  renderSlotAt: (row, col) ->
    cube = @board.cubes[row][col]
    if cube
      @slotAt(row, col).html(@renderCube(cube)).removeClass('empty')
    else
      @slotAt(row, col).html('').addClass('empty')

  renderCube: (cube) ->
    $('<div />')
      .addClass('cubic-cube')
      .addClass('cubic-cube-'+cube.get('color'))

  renderMarker: ->
    @marker = $('<div />').addClass('cubic-marker')
    $(@wrapper).append(@marker)
    @updateMarker()

  updateMarker: ->
    @marker.css
      bottom: @board.marker.row* 40
      left:   @board.marker.col * 40

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
      @updateMarker()
    @moveUp() unless @board.isGameOver()

  moveUp: ->
    @gear_position = @gear_position + 1
    @wrapper.css 'top', -@gear_position

  gameOver: ->
    @clock.stop()
    @renderGameOver()

  renderGameOver: ->
    $(@wrapper).before $('<div />').text('GAME OVER').addClass('cubic-gameover')

  bindKeys: ->
    self = this
    marker = @board.marker
    $(document).keydown (e) ->
      switch e.keyCode
        when 38
          marker.moveUp()
        when 40
          marker.moveDown()
        when 37
          marker.moveLeft()
        when 39
          marker.moveRight()
        when 32
          marker.switch()
          self.board.check()
          self.renderCubes()
      self.updateMarker()
