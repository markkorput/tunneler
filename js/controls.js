// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Controls = (function(_super) {
    __extends(Controls, _super);

    function Controls(_opts) {
      this.options = _opts;
      this.init();
    }

    Controls.prototype.init = function() {
      var folder, timeliner,
        _this = this;
      this.destroy();
      $(document).on('mousedown', this.mousedown);
      $(document).on('keydown', this.keydown);
      this.gui = new dat.GUI();
      this.data = new function() {
        return this.timeline = 0;
      };
      folder = this.gui.addFolder('Elements');
      timeliner = folder.add(this.data, 'timeline', 0, 100);
      folder.open();
      timeliner.listen();
      return timeliner.onChange(function(val) {
        return _this.trigger('timeline', val / 100);
      });
    };

    Controls.prototype.destroy = function() {
      this.trigger('destroy');
      $(document).off('mousedown keydown');
      if (this.gui) {
        this.gui.destroy();
        return this.gui = void 0;
      }
    };

    Controls.prototype.mousedown = function(e) {};

    Controls.prototype.keydown = function(e) {
      if (event.which === 27) {
        this.trigger('reset');
      }
      if (event.which === 32) {
        this.trigger('toggle-pause');
      }
      if (event.which === 13) {
        return this.trigger('screenshot');
      }
    };

    return Controls;

  })(Backbone.Model);

}).call(this);
