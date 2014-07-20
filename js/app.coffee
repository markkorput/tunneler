class @App
	constructor: (_opts) ->
		@options = _opts || {}
		@init()

	init: ->
		@_initVfx()
		@scene = @_createScene()

		# @controls = new Controls({app: this})

		requestAnimationFrame =>
			@update()
			@draw()

	_initVfx: ->
		# @camera = new THREE.OrthographicCamera(-1200, 1000, -1100, 1200, 10, 10000)
		@camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 1, 10000)
		@camera.position.z = 500
		
		# @renderer = new THREE.CanvasRenderer()
		@renderer = new THREE.WebGLRenderer({preserveDrawingBuffer: true}) # preserveDrawingBuffer: true allows for image exports, but has some performance implications

		@renderer.setSize(window.innerWidth, window.innerHeight)
		document.body.appendChild(this.renderer.domElement)

	_createScene: ->
		scene = new THREE.Scene()

		geometry = new THREE.CubeGeometry(1,1,1)
		material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } )
		cube = new THREE.Mesh( geometry, material )
		scene.add( cube )
		@camera.position.z = 5

		return scene

	update: ->
		return if @paused

	draw: ->
		@renderer.render(@scene, @camera)

	togglePause: ->
		@paused = (@paused != true);
		if @paused
			console.log 'Paused'
		else
			console.log 'Continue'
