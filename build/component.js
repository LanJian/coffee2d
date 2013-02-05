(function() {

  window.Component = (function() {

    function Component(x, y, w, h) {
      if (x == null) x = 0;
      if (y == null) y = 0;
      if (w == null) w = 0;
      if (h == null) h = 0;
      this.position = {
        x: x,
        y: y
      };
      this.size = {
        w: w,
        h: h
      };
      this.setSize(w, h);
      this.isMouseOver = false;
      this.children = [];
      this.listeners = [];
      this.keyDownHandlers = [];
      this.zIndex = 0;
      this.addListener('resize', this.onResize.bind(this));
      this.addListener('mouseMoveScene', this.onMouseMove.bind(this));
    }

    Component.prototype.onResize = function() {
      var c, ch, cw, h, w, _i, _len, _ref;
      w = this.size.w;
      h = this.size.h;
      _ref = this.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        cw = c.position.x + c.size.w;
        ch = c.position.y + c.size.h;
        if (cw > w) w = cw;
        if (ch > h) h = ch;
      }
      return this.size = {
        w: w,
        h: h
      };
    };

    Array.prototype.remove = function(e) {
      var t, _ref;
      if ((t = this.indexOf(e)) > -1) {
        return ([].splice.apply(this, [t, t - t + 1].concat(_ref = [])), _ref);
      }
    };

    Component.prototype.onMouseMove = function(evt) {
      var newEvt;
      if (!this.isMouseOver && this.containsPoint(evt.x, evt.y)) {
        this.isMouseOver = true;
        newEvt = {
          type: 'mouseOver',
          x: evt.x,
          y: evt.y
        };
        return this.dispatchEvent(newEvt);
      } else if (this.isMouseOver && !this.containsPoint(evt.x, evt.y)) {
        this.isMouseOver = false;
        newEvt = {
          type: 'mouseOut',
          x: evt.x,
          y: evt.y
        };
        return this.dispatchEvent(newEvt);
      }
    };

    Component.prototype.addChild = function(child) {
      return this.children.push(child);
    };

    Component.prototype.removeChild = function(childToRemove) {
      return this.children.remove(childToRemove);
    };

    Component.prototype.addListener = function(type, handler) {
      return this.listeners.push({
        type: type,
        handler: handler
      });
    };

    Component.prototype.dispatchEvent = function(evt) {
      if (!evt.x) evt.x = 0;
      if (!evt.y) evt.y = 0;
      if (!evt.origin) evt.origin = this;
      if (!evt.target) evt.target = this;
      return Event.addToQueue(evt);
    };

    Component.prototype.onKeyDown = function(which, handler) {
      return this.keyDownHandlers.push({
        which: which,
        handler: handler
      });
    };

    Component.prototype.setPosition = function(x, y) {
      this.position.x = x;
      return this.position.y = y;
    };

    Component.prototype.setSize = function(w, h) {
      if (w !== this.size.w || h !== this.size.w) {
        this.dispatchEvent({
          type: 'resize'
        });
      }
      this.size.w = w;
      return this.size.h = h;
    };

    Component.prototype.handle = function(evt) {
      var child, listener, _i, _j, _len, _len2, _ref, _ref2, _results;
      if (Event.isMouseEvent(evt)) {
        if (!this.containsPoint(evt.x, evt.y)) return;
        evt.target = this;
      }
      _ref = this.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        evt.x = evt.x - child.position.x;
        evt.y = evt.y - child.position.y;
        child.handle(evt);
        evt.x = evt.x + child.position.x;
        evt.y = evt.y + child.position.y;
      }
      _ref2 = this.listeners;
      _results = [];
      for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
        listener = _ref2[_j];
        if (evt.type === listener.type) {
          _results.push(listener.handler(evt));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    Component.prototype.containsPoint = function(x, y) {
      var rect;
      rect = new Rect(0, 0, this.size.w, this.size.h);
      return rect.isPointInside(x, y);
    };

    Component.prototype.update = function(dt) {
      var child, k, _i, _j, _len, _len2, _ref, _ref2, _results;
      _ref = this.keyDownHandlers;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        k = _ref[_i];
        if (Event.isKeyDown(k.which)) k.handler();
      }
      _ref2 = this.children;
      _results = [];
      for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
        child = _ref2[_j];
        _results.push(child.update(dt));
      }
      return _results;
    };

    Component.prototype.draw = function(ctx) {
      var child, _i, _len, _ref;
      ctx.save();
      ctx.translate(this.position.x, this.position.y);
      _ref = this.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        child.draw(ctx);
      }
      return ctx.restore();
    };

    return Component;

  })();

}).call(this);
