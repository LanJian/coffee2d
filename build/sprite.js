(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.Sprite = (function(_super) {

    __extends(Sprite, _super);

    function Sprite(spriteSheet) {
      Sprite.__super__.constructor.call(this);
      this.spriteSheets = {
        "default": spriteSheet
      };
      this.animations = {};
      this.playingAnimation = 'none';
      this.isPlaying = false;
      this.loop = true;
      this.addListener('spriteImageLoaded', this.onSpriteImageLoaded.bind(this));
      this.reset();
    }

    Sprite.prototype.onSpriteImageLoaded = function(evt) {
      var f, found, h, key, spr, val, w, _i, _len, _ref, _ref2, _ref3;
      found = false;
      _ref = this.spriteSheets;
      for (key in _ref) {
        val = _ref[key];
        if (val === evt.target) {
          found = true;
          break;
        }
      }
      if (!found) return;
      w = h = 0;
      _ref2 = this.spriteSheets;
      for (key in _ref2) {
        spr = _ref2[key];
        _ref3 = spr.data;
        for (_i = 0, _len = _ref3.length; _i < _len; _i++) {
          f = _ref3[_i];
          if (f.w > w) w = f.w;
          if (f.h > h) h = f.h;
        }
      }
      return this.setSize(w, h);
    };

    Sprite.prototype.addSpriteSheet = function(id, spriteSheet) {
      return this.spriteSheets[id] = spriteSheet;
    };

    Sprite.prototype.addAnimation = function(a) {
      var data, duration, fps, id, row, spriteSheetId, ss, startFrame;
      if (!a.id) return;
      if (isNaN(a.row && isNaN(a.startFrame))) return;
      if (!a.fps) a.fps = 60;
      if (!a.spriteSheetId) a.spriteSheetId = 'default';
      id = a.id;
      row = a.row;
      startFrame = a.startFrame;
      duration = a.duration;
      fps = a.fps;
      spriteSheetId = a.spriteSheetId;
      ss = this.spriteSheets[spriteSheetId];
      if ((0 <= row && row <= ss.rowData.length)) {
        data = ss.getStartFrameAndDuration(row);
        startFrame = data.startFrame;
        duration = data.duration;
      }
      return this.animations[id] = {
        spriteSheet: spriteSheetId,
        startFrame: startFrame,
        duration: duration,
        frameInterval: 1000 / fps
      };
    };

    Sprite.prototype.reset = function() {
      var anim;
      anim = this.animations[this.playingAnimation];
      if (anim) {
        this.frameIndex = anim.startFrame;
      } else {
        0;
      }
      return this.curInterval = 0;
    };

    Sprite.prototype.playOnce = function(id) {
      if (id && this.playingAnimation !== id) {
        this.playingAnimation = id;
        this.reset();
        this.loop = false;
      }
      return this.isPlaying = true;
    };

    Sprite.prototype.play = function(id) {
      if (id && this.playingAnimation !== id) {
        this.playingAnimation = id;
        this.reset();
        this.loop = true;
      }
      return this.isPlaying = true;
    };

    Sprite.prototype.stop = function() {
      return this.isPlaying = false;
    };

    Sprite.prototype.update = function(dt) {
      var anim, spriteSheet;
      anim = this.animations[this.playingAnimation];
      if (!anim) return;
      spriteSheet = this.spriteSheets[anim.spriteSheet];
      if (spriteSheet && this.isPlaying && spriteSheet.loaded) {
        this.curInterval += dt;
        if (this.curInterval >= anim.frameInterval) {
          this.frameIndex++;
          if ((this.frameIndex >= anim.duration) && !this.loop) this.stop();
          this.frameIndex = anim.startFrame + (this.frameIndex - anim.startFrame) % anim.duration;
          this.curInterval = this.curInterval % anim.frameInterval;
        }
      }
      return Sprite.__super__.update.call(this, dt);
    };

    Sprite.prototype.draw = function(ctx) {
      var anim, dh, dw, f, spriteSheet;
      anim = this.animations[this.playingAnimation];
      if (!anim) return;
      spriteSheet = this.spriteSheets[anim.spriteSheet];
      if (spriteSheet && spriteSheet.loaded) {
        f = spriteSheet.data[this.frameIndex];
        dw = this.size.w === 0 ? f.w : this.size.w;
        dh = this.size.h === 0 ? f.h : this.size.h;
        ctx.drawImage(spriteSheet.image, f.x, f.y, f.w, f.h, this.position.x, this.position.y, dw, dh);
      }
      return Sprite.__super__.draw.call(this, ctx);
    };

    return Sprite;

  })(Component);

}).call(this);
