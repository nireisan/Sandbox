Sample = cc.Layer.extend(

  init: ->
    @_super()
    size = cc.Director.getInstance().getWinSize()

#    @ship = cc.LabelTTF.create "=>", "Arial", 38
    @ship = cc.Sprite.create "res/CloseSelected.png"
    @ship.setPosition cc.p size.width / 2, size.height / 2
    @addChild @ship, 5

    @enemies = []
    for i in [0..14]
      enemy = cc.LabelTTF.create "●", "Arial", 38
      enemy.v = cc.p -5, (Math.random() - 0.5) * 3

      enemy.setColor cc.c3b 255, 0, 0
      enemy.setPosition cc.p (Math.random() + 1) * size.width, Math.random() * size.height

      @scoreLabel = cc.LabelTTF.create "", "Arial", 17
      @scoreLabel.setPosition cc.p 20, size.height - 20
      @scoreLabel.setAnchorPoint cc.p 0, 1
      @addChild @scoreLabel, 10

      @addChild enemy, 10
      @enemies.push enemy

    @scheduleUpdate()

    @setTouchEnabled(true)
    return true

  update: (dt) ->
    size = cc.Director.getInstance().getWinSize()

    shipPos = @ship.getPosition()
    if @touched
      k = 0.7
      @ship.setPosition shipPos.x, (shipPos.y * k) + (@touched.y * (1.0 - k))

    for enemy in @enemies
      pos = enemy.getPosition()
      pos = cc.p pos.x, pos.y
      pos.x += enemy.v.x
      pos.y += enemy.v.y

      if pos.x < 0
        pos.x = size.width
      if pos.y < 0
        pos.y = size.height
      if pos.y > size.height
        pos.y = 0

      distance = cc.pDistance shipPos, pos
      if distance < 25
        cc.log 'hit'
        unless @gameover
          @gameover = true;
          @onGameover()

      enemy.setPosition pos
      @scoreLabel.setString "SCORE: " + g.score++

  onGameover: ->
    transition = cc.TransitionFade.create 1.0, new ResultScene()
    console.log "replaceScene"
    cc.Director.getInstance().replaceScene transition
    return

  onTouchesBegan: (touches, event) ->
#    console.log touches[0].getLocation()
    @touched = touches[0].getLocation()
    return


  onTouchesMoved: (touches, event) ->
#    console.log touches[0].getLocation()
    @touched = touches[0].getLocation()
    return

  onTouchesEnded: (touches, event) ->
    @touched = null
    return

  onTouchesCancelled: (touches, event) ->
    @touched = null
    return
)

SampleScene = cc.Scene.extend(
  onEnter: ->
    @_super()
    layer = new Sample()
    layer.init()
    @addChild layer
)

@SampleScene = SampleScene
