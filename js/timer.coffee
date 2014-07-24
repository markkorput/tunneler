class @Timer extends Backbone.Model
  initialize: ->
    @on 'change:state', @_onStateChange, this
    @on 'change:time'

    @set state: 'stopped'

  start: ->
    @set state: 'playing'

  curTime: -> new Date().getTime()

  _time: -> @curTime() - @get('startTime') if @get('startTime')

  _progress: ->
    if (t = @_time()) && d = @get('duration')
      return t * 1.0 / d

  update: ->
    if @get('state') == 'playing'
      data = {time: @_time(), progress: @_progress()}

      # When progress reaches one, it means the end of the timeline (specified by duration) is reached,
      # simply loop back to the beginning
      if data.progress && data.progress > 1
        @set(startTime: @get('startTime') + @get('duration'))
        @update()
        return

      # console.log data
      @set(data)

  _onStateChange: (timer,state,obj) ->
    if state == 'playing'
      @set({startTime: @curTime()})

    if state == 'stopped'
      @set({stopTime: @curTime()})