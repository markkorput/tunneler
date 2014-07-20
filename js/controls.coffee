class @Controls
	constructor: (_opts) ->
		@options = _opts
		@initGUI()
		@setupEventListeners()

	app: -> @options.app

	bind: ( scope, fn ) ->
		-> fn.apply scope, arguments

	setupEventListeners: ->
		document.addEventListener 'mousedown', @bind(this, @mousedown), false
		document.addEventListener 'keydown', @bind(this, @keydown), false

	mousedown: ( event ) ->
		return;
		event.preventDefault()
		event.stopPropagation()

		console.log "Mousedown - creating random disturbance"
		@app().disturbances.push( new DisturbancePicker({grid: @app().grid}).createDisturbance() )
		@app().createDisturbance()

	keydown: (event ) ->
		# event.preventDefault()
		# event.stopPropagation()
		console.log "Keydown (event.which = " + event.which + ")"

		if event.which >= 48 && event.which <= 57 # 0 - 9
			@app().disturbances.push( new DisturbancePicker({grid: @app().grid}).indexDisturbance(event.which - 48) ) 

		if(event.which == 27) # escape
			console.log '[ESC] clearing disturbances array'
			@app().disturbances = []
			@app().grid.reset();

		@app().togglePause() if event.which == 32 # SPACE

		if event.which == 13 # ENTER
			@app().renderer.preserveDrawingBuffer = true
			window.open( @app().renderer.domElement.toDataURL( 'image/png' ), 'screenshot' );

	initGUI: -> 
		UiObject = =>
			@reset = =>
				@app().disturbances = []
				@app().grid.reset();
			@vSpin = =>
				@app().disturbances.push( new DisturbancePicker({grid: @app().grid}).indexDisturbance(0) ) 
			@hSpin = =>
				@app().disturbances.push( new DisturbancePicker({grid: @app().grid}).indexDisturbance(1) ) 
			this

		uiobj = new UiObject()

		@gui = new dat.GUI() # ({autoPlace:true});

		# folder = @gui.addFolder 'Parameters'
		# control = folder.add({gridPosX: -2200}, 'gridPosX', -3000, 0)
		# control.onChange (value) -> console.log "Let's change grid pos to "+value

		folder = @gui.addFolder 'Actions'
		folder.add(uiobj, 'vSpin')
		folder.add(uiobj, 'hSpin')
		folder.add(uiobj, 'reset')
		folder.open()


