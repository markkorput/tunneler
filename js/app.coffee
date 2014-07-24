class @App extends Backbone.Model
	constructor: (_opts) ->
		@options = _opts || {}
		@init()

	init: ->
		@_initVfx()
		@_createScene()

		@controls = new Controls()
		@controls.on 'toggle-loop', ((value) -> @timer.set(loop: value)), this
		@controls.on 'timeline', ((value) -> @timer.setProgress(value)), this

		@timer = new Timer(duration: 3000)		
		@on 'update', @timer.update, @timer
		@timer.start()
		@timer.on 'change:progress', ((timer, progress, obj) -> @controls.data.timeline = progress * 100), this

		@update()

		

	_initVfx: ->
		# @camera = new THREE.OrthographicCamera(-1200, 1000, -1100, 1200, 10, 10000)
		@camera = new THREE.PerspectiveCamera(45, window.innerWidth / window.innerHeight, 1, 1000)

		# @renderer = new THREE.CanvasRenderer()
		@renderer = new THREE.WebGLRenderer() #({preserveDrawingBuffer: true}) # preserveDrawingBuffer: true allows for image exports, but has some performance implications

		# perform window-size based configuration
		@_resize()
		# add event hook, to perform re-configuration when the window resizes
		$(window).resize @_resize

		# add our canvas element to the page
		document.body.appendChild(this.renderer.domElement)

	_resize: (event) ->
		if @camera
			@camera.aspect = window.innerWidth / window.innerHeight
			@camera.updateProjectionMatrix()

		if @renderer
			@renderer.setSize( window.innerWidth, window.innerHeight )

	_createScene: ->
		@scene = new THREE.Scene()

		@dripper = new Dripper(scene: @scene, camera: @camera, drip_delay: 30)
		@on 'update', (-> @dripper.update()), this

		@camera_operator = new CameraOperator(camera: @camera, scene: @scene, speed: 3, rotation_speed: 0.01)
		@on 'update', (-> @camera_operator.update()), this

		@post_processor = new PostProcessor(renderer: @renderer, camera: @camera, scene: @scene)
		@on 'update', (-> @post_processor.update()), this

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
