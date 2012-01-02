# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
new Cubic.Views.BoardView
  board     : new Cubic.Models.Board()
  container : $('.container')
  time_steps: 0.1
