Cubic.Models.Clock = Backbone.Model.extend
  initialize: ->
    _.bindAll this
    @callback   = @get 'callback'
    @time_steps = @get('time_steps') * 1000
    @running    = false

  start: ->
    @running    = true
    @elapsed    = 0
    @run()

  stop: ->
    @running = false

  run: ->
    if @running
      @last_timestamp ||= new Date()
      now             = new Date()
      @elapsed       += now - @last_timestamp
      @last_timestamp = now

      while @elapsed >= @time_steps
        @callback()
        @elapsed -= @time_steps
      setTimeout @run, 100
