(function() {

  window.SpriteSheet = (function() {

    function SpriteSheet(filename, rowData) {
      this.filename = filename;
      this.rowData = rowData;
      this.data = [];
      this.image = new Image;
      this.image.src = this.filename;
      this.image.onload = this.onImageLoaded.bind(this);
      this.loaded = false;
    }

    SpriteSheet.prototype.onImageLoaded = function() {
      var height, i, j, row, _ref, _ref2;
      height = 0;
      for (i = 0, _ref = this.rowData.length - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
        row = this.rowData[i];
        for (j = 0, _ref2 = row.length - 1; 0 <= _ref2 ? j <= _ref2 : j >= _ref2; 0 <= _ref2 ? j++ : j--) {
          this.data.push({
            x: j * row.cellWidth,
            y: height,
            w: row.cellWidth,
            h: row.cellHeight
          });
        }
        height += row.cellHeight;
      }
      this.loaded = true;
      return Event.dispatchEvent({
        type: 'spriteImageLoaded',
        origin: this,
        target: this,
        x: 0,
        y: 0
      });
    };

    SpriteSheet.prototype.getStartFrameAndDuration = function(row) {
      var duration, i, startFrame, _ref;
      startFrame = 0;
      if (row > 0) {
        for (i = 0, _ref = row - 1; 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
          startFrame += this.rowData[i].length;
        }
      }
      duration = this.rowData[row].length;
      return {
        startFrame: startFrame,
        duration: duration
      };
    };

    SpriteSheet.prototype.getNumFrames = function() {
      return this.data.length;
    };

    return SpriteSheet;

  })();

}).call(this);
