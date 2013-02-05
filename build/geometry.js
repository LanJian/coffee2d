(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.Rect = (function(_super) {

    __extends(Rect, _super);

    function Rect(x, y, w, h, color) {
      this.color = color != null ? color : 'black';
      Rect.__super__.constructor.call(this, x, y, w, h);
    }

    Rect.prototype.isPointInside = function(x, y) {
      return x >= this.position.x && x <= this.position.x + this.size.w && y >= this.position.y && y <= this.position.y + this.size.h;
    };

    Rect.prototype.draw = function(ctx) {
      ctx.fillStyle = this.color;
      ctx.beginPath();
      ctx.rect(this.position.x, this.position.y, this.size.w, this.size.h);
      ctx.closePath();
      ctx.fill();
      return Rect.__super__.draw.call(this, ctx);
    };

    return Rect;

  })(Component);

}).call(this);
