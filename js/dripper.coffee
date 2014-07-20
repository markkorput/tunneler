class @Dripper extends Backbone.Model
  constructor: (_opts) ->
    @options = _opts || {}
    @init()

  init: ->
    @destroy()
    @scene = @options.scene
    @camera = @options.camera

    @geometry = new THREE.CubeGeometry(1,1,1)
    @material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } )

    @drips = []

  destroy: ->
    @trigger 'destroy'

    if @cube
      @scene.remove @cube
      @cube = undefined

    @scene = @camera = undefined

  generateDrip: ->
    mesh = new THREE.Mesh( @geometry, @material )
    mesh.position.z = @camera.position.z
    mesh.position.x = -5 + Math.random() * 10
    mesh.position.y = -5 + Math.random() * 10
    mesh

  update: ->
    curDrip = new Date().getTime()
    return if @lastDrip && (curDrip - @lastDrip) < 500
    @lastDrip = curDrip

    # create new particle
    drip = @generateDrip()
    @drips.push drip
    @scene.add( drip )

    # this is crashing?!
    #console.log @camera.position.z + " / " + @drips[0].position.z
    #while @drips[0] && Math.abs(@camera.position.z - @drips[0].position.z) > 2
    #  @scene.remove @drips[0]
    #  @drips.slice(1)




