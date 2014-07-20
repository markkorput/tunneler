class @CameraOperator extends Backbone.Model
  constructor: (_opts) ->
    @options = _opts || {}
    @init()

  init: ->
    @destroy()
    @scene = @options.scene
    @camera = @options.camera

    @camera.position.z = 5

  destroy: ->
    @trigger 'destroy'
    @scene = @camera = undefined

  update: ->
    @camera.position.z += @speed()

  speed: ->
    @options.speed || 0.01

