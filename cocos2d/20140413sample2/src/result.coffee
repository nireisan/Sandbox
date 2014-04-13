@g =
  score: 0

Result = cc.Layer.extend(
  init: ->
    @_super()

    size = cc.Director.getInstance().getWinSize();

    resultLabel = cc.LabelTTF.create "score: " + g.score, "Arial", 20
    resultLabel.setPosition cc.p size.width / 2, size.height / 2
    @addChild resultLabel

    highScore = parseInt sys.localStorage.getItem("Sample/highScore") || 0
    console.log g.score
    console.log highScore
    if g.score > highScore
      console.log "high score"
#todo highScoreには値あるけど入らない(´・ω・｀) 今度調べる
      sys.localStorage.setItem "Sample/highScore", highScore
    highLabel = cc.LabelTTF.create "high score: " + highScore, "Arial", 20
    highLabel.setPosition cc.p size.width / 2, size.height / 2 - 50
    @addChild highLabel

    @scheduleOnce( ->
      @onTouchesBegan = (touches, event) ->
        g.score = 0
        cc.Director.getInstance().replaceScene new SampleScene
        return
    , 2.0)

    @setTouchEnabled true
    return true

  onTouchesBegan: (touches, event) ->
  onTouchesMoved: (touches, event) ->
  onTouchesEnded: (touches, event) ->
  onTouchesCancelled: (touches, event) ->
)

@ResultScene = cc.Scene.extend(
  onEnter: ->
    console.log "resultScene"
    @_super()
    layer = new Result()
    layer.init()
    @addChild layer
)
