class @Controls extends Backbone.Model
	constructor: (_opts) ->
		@options = _opts
		@init()

	init: ->
		@destroy()

		$(document).on 'mousedown', @mousedown
		$(document).on 'keydown', @keydown

		@gui = new dat.GUI()

		@data = new ->
			# @Stripes = => 
			@timeline = 0

		folder = @gui.addFolder 'Elements'
		# folder.add(@data, 'Stripes').listen()
		timeliner = folder.add(@data, 'timeline', 0, 100)
		folder.open()

		timeliner.listen()
		timeliner.onChange (val) => @trigger('timeline', val/100) # communicate in 0.0 - 1.0 ranges with outside

	destroy: ->
		@trigger 'destroy'
		$(document).off 'mousedown keydown'

		if @gui
			@gui.destroy()
			@gui = undefined

	mousedown: (e) ->
		# console.log e
		# e.preventDefault()
		# e.stopPropagation()

	keydown: (e) ->
		# console.log e
		# e.preventDefault()
		# e.stopPropagation()

		# if event.which >= 48 && event.which <= 57 # 0 - 9
		@trigger 'reset' if(event.which == 27) # escape
		@trigger 'toggle-pause' if event.which == 32 # SPACE
		@trigger 'screenshot' if event.which == 13 # ENTER


