// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.Dripper = (function(_super) {
    __extends(Dripper, _super);

    function Dripper(_opts) {
      this.options = _opts || {};
      this.init();
    }

    Dripper.prototype.init = function() {
      this.destroy();
      this.scene = this.options.scene;
      this.camera = this.options.camera;
      this.geometry = new THREE.CubeGeometry(1, 1, 1);
      this.material = new THREE.MeshLambertMaterial({
        color: 0xFF0000
      });
      return this.drips = [];
    };

    Dripper.prototype.destroy = function() {
      this.trigger('destroy');
      if (this.cube) {
        this.scene.remove(this.cube);
        this.cube = void 0;
      }
      return this.scene = this.camera = void 0;
    };

    Dripper.prototype.generateDrip = function() {
      var mesh;
      mesh = new THREE.Mesh(this.geometry, this.material);
      mesh.position.x = -50 + Math.random() * 100;
      mesh.position.y = -50 + Math.random() * 100;
      mesh.position.z = this.camera.position.z - mesh.geometry.depth - 0.1;
      return mesh;
    };

    Dripper.prototype.update = function() {
      var curDrip, drip, _results;
      curDrip = new Date().getTime();
      if (this.lastDrip && (curDrip - this.lastDrip) < 100) {
        return;
      }
      this.lastDrip = curDrip;
      drip = this.generateDrip();
      this.drips.push(drip);
      this.scene.add(drip);
      _results = [];
      while (this.drips[0] && Math.abs(this.camera.position.z - this.drips[0].position.z) > (this.options.max_depth || 5000)) {
        this.scene.remove(this.drips[0]);
        _results.push(this.drips = this.drips.slice(1));
      }
      return _results;
    };

    return Dripper;

  })(Backbone.Model);

}).call(this);
