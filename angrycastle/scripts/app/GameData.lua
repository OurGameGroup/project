
GameData = GameData or{}

GameData.fps = 60

GameData.gravity = CCPoint(0,-0.5)

GameData.defaultSpeedScale = 20/display.width

GameData.enemyBase = CCPoint(800 , 100)

GameData.accomplishment = {
--格式：{get=false，requireMoney = 需要的数字，img = 成就图片路径}
	{get = false,requireMoney = 10,img =  "Accomplishment/firstblood.png"},
	{get = false,requireMoney = 30,img =  "Accomplishment/10enemy.png"},
	{get = false,requireMoney = 70,img =  "Accomplishment/1000coins.png"}
}

GameData.weapon = {
	{--fire bullet
		speed = CCPoint(10, 10),
		gravityEnable = true,
		rotatable = true,
		effect = "burning",
		effectTime = 120, -- frame per second
		animation = {
			FileName = "fireBullet/fireBullet.ExportJson",
			Name = "fireBullet",
			defaultAnimation = "blow"
		},
		
		button = {
			normal = "fire.png",
			pressed = "firePushed.png"
		}
	},
	{
		speed = CCPoint(10, 10),
		gravity = true,
		effect = "frozen"
	}
}