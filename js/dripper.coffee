class @Dripper extends Backbone.Model
  constructor: (_opts) ->
    @options = _opts || {}
    @init()

  init: ->
    @destroy()
    @scene = @options.scene
    @camera = @options.camera

    geometry = new THREE.CubeGeometry(1,1,1)
    material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } )
    @cube = new THREE.Mesh( geometry, material )
    @scene.add( @cube )
    @camera.position.z = 5

  destroy: ->
    @trigger 'destroy'

    if @cube
      @scene.remove @cube
      @cube = undefined

    @scene = @camera = undefined

  update: ->
    @cube.position.set(Math.random(1), 0, 0)

