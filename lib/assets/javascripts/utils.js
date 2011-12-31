Array.prototype.sample = function() {
  var rand_position = parseInt(Math.random() * this.length);
  return this[rand_position];
};
