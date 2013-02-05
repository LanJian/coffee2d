(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.IsometricMap = (function(_super) {

    __extends(IsometricMap, _super);

    function IsometricMap(opts) {
      IsometricMap.__super__.constructor.call(this);
      console.log(this);
      this.opts = opts;
      this.spriteSheet = opts.spriteSheet;
      this.map = opts.map;
      this.tileWidth = opts.tileWidth;
      this.tileHeight = opts.tileHeight;
      this.tileXOffset = opts.tileXOffset;
      this.tileYOffset = opts.tileYOffset;
      this.tiles = [];
      this.init();
    }

    IsometricMap.prototype.init = function() {
      var cols, i, ii, index, j, jj, rows, t, x, xOffset, y, yOffset, _results;
      i = 0;
      j = 0;
      ii = 0;
      jj = 0;
      xOffset = 0;
      yOffset = 0;
      rows = this.map.length;
      cols = this.map[0].length;
      _results = [];
      while (i < rows && j < cols) {
        ii = i;
        jj = j;
        x = xOffset;
        y = yOffset;
        console.log('-----');
        while (ii < rows && jj < cols) {
          if (ii < 0 || ii >= rows || jj < 0 || jj >= cols) break;
          index = this.map[ii][jj];
          t = new Tile(this.opts.spriteSheet, index);
          console.log(ii, jj);
          console.log(index);
          console.log(x, y);
          t.position = {
            x: x,
            y: y
          };
          this.addChild(t);
          ii -= 1;
          jj += 1;
          x += this.tileWidth;
        }
        if (i + 1 < cols) {
          i++;
          xOffset -= this.tileXOffset;
        } else {
          j++;
          xOffset += this.tileXOffset;
        }
        _results.push(yOffset += this.tileYOffset);
      }
      return _results;
    };

    return IsometricMap;

  })(Component);

}).call(this);
