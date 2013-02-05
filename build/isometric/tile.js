(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.Tile = (function(_super) {

    __extends(Tile, _super);

    function Tile(spriteSheet, index) {
      var rect;
      Tile.__super__.constructor.call(this);
      this.tile = new SpriteImage(spriteSheet, index);
      rect = new Rect(0, 0, 64, 64, 'white');
      this.addChild(this.tile);
    }

    return Tile;

  })(Component);

}).call(this);
