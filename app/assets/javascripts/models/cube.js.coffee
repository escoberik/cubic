Cubic.Models.Cube = Backbone.Model.extend
  initialize: ->
    @attributes['color'] = ['red', 'blue', 'orange', 'green'].sample()
