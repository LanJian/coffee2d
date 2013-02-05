(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.Coffee2D || (window.Coffee2D = {});

  window.Coffee2D.Image = (function(_super) {

    __extends(Image, _super);

    function Image(filename) {
      Image.__super__.constructor.call(this);
      console.log('test');
      this.image = new window.Image;
      this.image.src = filename;
      this.image.onload = this.onImageLoaded.bind(this);
      this.loaded = false;
    }

    Image.prototype.onImageLoaded = function() {
      this.loaded = true;
      return this.setSize(this.image.width, this.image.height);
    };

    Image.prototype.draw = function(ctx) {
      Image.__super__.draw.call(this, ctx);
      if (this.loaded) {
        return ctx.drawImage(this.image, this.position.x, this.position.y, this.size.w, this.size.h);
      }
    };

    return Image;

  })(Component);

}).call(this);
