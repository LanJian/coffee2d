(function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  window.Scene = (function(_super) {

    __extends(Scene, _super);

    function Scene(canvas, bgColor) {
      var bg, type;
      this.canvas = canvas;
      this.bgColor = bgColor != null ? bgColor : 'none';
      Scene.__super__.constructor.call(this);
      this.setPosition(0, 0);
      this.setSize(this.canvas.width, this.canvas.height);
      if (this.bgColor !== 'none') {
        bg = new Rect(this.position.x, this.position.y, this.size.w, this.size.h, this.bgColor);
        this.addChild(bg);
      }
      for (type in Event.TYPES) {
        this.canvas.addEventListener(type, this.onEvent.bind(this));
      }
      this.addListener('mouseMoveScene', (function(evt) {
        evt.type = 'mouseMove';
        return this.dispatchEvent(evt);
      }).bind(this));
      this.addListener('keyDown', function(evt) {
        return Event.keyDown(evt.which);
      });
      this.addListener('keyUp', function(evt) {
        return Event.keyUp(evt.which);
      });
      this.context = this.canvas.getContext('2d');
      this.lastTime = new Date().getTime();
      this.gameLoop();
    }

    Scene.prototype.onEvent = function(evt) {
      var newEvt;
      newEvt = {
        origin: this.canvas,
        type: Event.TYPES[evt.type],
        button: evt.button,
        which: evt.which || evt.keyCode || evt.charCode,
        x: evt.offsetX,
        y: evt.offsetY
      };
      return this.dispatchEvent(newEvt);
    };

    Scene.prototype.gameLoop = function() {
      var curTime, dt, evt;
      requestAnimationFrame(this.gameLoop.bind(this));
      curTime = new Date().getTime();
      dt = curTime - this.lastTime;
      this.lastTime = curTime;
      while (!Event.isEmpty()) {
        evt = Event.removeFromQueue();
        this.handle(evt);
      }
      this.update(dt);
      return this.draw(this.context);
    };

    Scene.prototype.clear = function() {
      return this.context.clearRect(0, 0, this.size.w, this.size.h);
    };

    Scene.prototype.draw = function(ctx) {
      this.clear();
      return Scene.__super__.draw.call(this, ctx);
    };

    return Scene;

  })(Component);

}).call(this);
