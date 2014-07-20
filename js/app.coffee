class @App extends Backbone.Model
	constructor: (_opts) ->
		@options = _opts || {}
		@init()

	init: ->
		@_initVfx()
		@_createScene()
		# @controls = new Controls({app: this})
		@update()

	_initVfx: ->
		# @camera = new THREE.OrthographicCamera(-1200, 1000, -1100, 1200, 10, 10000)
		@camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 1000)

		# @renderer = new THREE.CanvasRenderer()
		@renderer = new THREE.WebGLRenderer() #({preserveDrawingBuffer: true}) # preserveDrawingBuffer: true allows for image exports, but has some performance implications

		@renderer.setSize(window.innerWidth, window.innerHeight)
		document.body.appendChild(this.renderer.domElement)

	_createScene: ->
		@scene = new THREE.Scene()

		@dripper = new Dripper(scene: @scene, camera: @camera)
		@on 'update', (-> @dripper.update()), this

		@camera_operator = new CameraOperator(camera: @camera, scene: @scene, speed: 0.1)
		@on 'update', (-> @camera_operator.update()), this

		@post_processor = new PostProcessor(renderer: @renderer, camera: @camera, scene: @scene)

		return @scene

	update: ->
		requestAnimationFrame =>
			@update()
			@draw()

		return if @paused
		@trigger 'update'

	draw: ->
		if @post_processor
			@post_processor.composer.render()
			return

		@renderer.render(@scene, @camera)

	togglePause: ->
		@paused = (@paused != true);
		if @paused
			console.log 'Paused'
		else
			console.log 'Continue'
