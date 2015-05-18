
TouchEventString = TouchEventString or {} --------鼠标事件名称
TouchEventString.began = "began"
TouchEventString.moved = "moved"
TouchEventString.ended = "ended"
TouchEventString.canceled = "canceled"


GameData = GameData or{}
GameData.rectScreen = {left = -10, right = CONFIG_SCREEN_WIDTH+10, top = CONFIG_SCREEN_HEIGHT, bottom = -10}
GameData.posStart = ccp(CONFIG_SCREEN_WIDTH / 2, 0)
GameData.moveSpeed = 20
GameData.fps = 30
GameData.unitR = 100
GameData.bulletR = 75
GameData.addUnitIntervalTime = 20


State = State or {}
State.null = 0
State.move = 1
State.burst = 2
