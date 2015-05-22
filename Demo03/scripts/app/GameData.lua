
TouchEventString = TouchEventString or {} --------鼠标事件名称
TouchEventString.began = "began"
TouchEventString.moved = "moved"
TouchEventString.ended = "ended"
TouchEventString.canceled = "canceled"


GameData = GameData or{}
GameData.fps = 30


State = State or {}
State.null = 0
State.stand = 1
State.move = 2
State.hurt = 3
State.attack = 4
State.dead = 5

State.actionName = {
	"stand"-- State.stand = 1
	, "move"-- State.move = 2
	, "hurt"-- State.hurt = 3
	, "attack"-- State.attack = 4
	, "dead"-- State.dead = 5	
}

State.isLoop = {
	true-- State.stand = 1
	, true-- State.move = 2
	, false-- State.hurt = 3
	, false-- State.attack = 4
	, false-- State.dead = 5
}
