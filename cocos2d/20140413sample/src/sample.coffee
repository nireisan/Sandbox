Sample = cc.Layer.extend(
  init: ->
    @_super()
    size = cc.Director.getInstance().getWinSize();

    @helloLabel = cc.LabelTTF.create "Hello World", "Arial", 38
    @helloLabel.setPosition cc.p size.width / 2, size.height / 2
    @addChild @helloLabel, 5

    @setTouchEnabled true
    return true

  onTouchesBegan: (touchies, event) ->
  onTouchesMoves: (touchies, event) ->
  onTouchesEnded: (touchies, event) ->
  onTouchesCancelled: (touchies, event) ->
)

SampleScene = cc.Scene.extend(
  onEnter: ->
    @_super()
    layer = new Sample()
    layer.init()
    @addChild layer
)

@SampleScene = SampleScene
