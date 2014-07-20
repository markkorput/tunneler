class @PostProcessor extends Backbone.Model
  constructor: (_opts) ->
    @options = _opts || {}
    @init()

  init: ->
    @destroy()
    @renderer = @options.renderer
    @scene = @options.scene
    @camera = @options.camera

    @composer = new THREE.EffectComposer @renderer
    @composer.addPass new THREE.RenderPass( @scene, @camera )
    
    effect = new THREE.ShaderPass( THREE.DotScreenShader )
    effect.uniforms[ 'scale' ].value = 4
    @composer.addPass( effect )

    effect = new THREE.ShaderPass( THREE.RGBShiftShader )
    effect.uniforms[ 'amount' ].value = 0.0015;
    effect.renderToScreen = true
    @composer.addPass effect

  destroy: ->
    @trigger 'destroy'

    if @composer
      @composer = undefined

    @scene = @camera = undefined
