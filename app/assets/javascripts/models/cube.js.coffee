Cubic.Models.Cube = Backbone.Model.extend
  defaults:
    destroy: false

  initialize: ->
    allowed = []
    forbidden = @get('forbidden')
    $(['red', 'blue', 'orange', 'green']).each ->
      color = ''+this
      allowed.push color  if $.inArray(color, forbidden) < 0
    @set color: allowed.sample()
