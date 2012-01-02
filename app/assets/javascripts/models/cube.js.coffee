Cubic.Models.Cube = Backbone.Model.extend
  initialize: (forbidden) ->
    allowed = []
    $(['red', 'blue', 'orange', 'green']).each ->
      color = ''+this
      allowed.push color  if $.inArray(color, forbidden) < 0
    @attributes['color'] = allowed.sample()
