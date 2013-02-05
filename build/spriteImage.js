(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.SpriteImage = (function(_super) {

    __extends(SpriteImage, _super);

    function SpriteImage(spriteSheet, index) {
      this.spriteSheet = spriteSheet;
      this.index = index;
      SpriteImage.__super__.constructor.call(this);
    }

    SpriteImage.prototype.draw = function(ctx) {
      var f;
      SpriteImage.__super__.draw.call(this, ctx);
      if (this.spriteSheet && this.spriteSheet.loaded) {
        f = this.spriteSheet.data[this.index];
        return ctx.drawImage(this.spriteSheet.image, f.x, f.y, f.w, f.h, this.position.x, this.position.y, f.w, f.h);
      }
    };

    return SpriteImage;

  })(Component);

}).call(this);
