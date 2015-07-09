
GameData = GameData or{}

GameData.fps = 60

GameData.gravity = CCPoint(0,-0.5)

GameData.defaultSpeedScale = 20/display.width

GameData.enemyBase = CCPoint(800 , 100)

GameData.sound = true

GameData.chapter = 1

GameData.money = 0

GameData.accomplishment = {
--格式：{get=false，requireMoney = 需要的数字，img = 成就图片路径}
	{get = false,requireMoney = 10,img =  "Accomplishment/firstblood.png"},
	{get = false,requireMoney = 50,img =  "Accomplishment/5enemy.png"},
	{get = false,requireMoney = 1000,img =  "Accomplishment/1000coins.png"}
}


GameData.weapon = {
	{--fire bullet
		speed = CCPoint(10, 10),
		gravityEnable = true,
		rotatable = true,
		effect = "burning",
		effectTime = 120, -- frame per second
		body = "animation",
		hitGroundImage = "Effect/fire.png",
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
	{--frozen bullet
		speed = CCPoint(20, 10),
		gravityEnable = true,
		rotatable = true,
		effect = "frozen",
		effectTime = 120, -- frame per second
		body = "image",
		image = "freezingBullet.png",
		button = {
			normal = "freeze.png",
			pressed = "freezePushed.png"
		}
	},
	{--sudo kill
		speed = CCPoint(15, 10),
		gravityEnable = true,
		rotatable = true,
		effect = "sudoKill",
		body = "image",
		image = "bullet.png",
		button = {
			normal = "sudoKill.png",
			pressed = "sudoKillPushed.png"
		}
	},
	{--winding bullet
		speed = CCPoint(5, 10),
		gravityEnable = true,
		rotatable = true,
		effect = "winding",
		effectTime = 120, -- frame per second
		body = "image",
		image = "windBullet.png",
		hitGroundImage = "Effect/winding.png",
		button = {
			normal = "winding.png",
			pressed = "windingPushed.png"
		},
		doNotHitEnemy = true
	}
}

GameData.nextChapterNum = {
						  	{chapterNum = 1, killRequired = 10},
						  	{chapterNum = 2, killRequired = 20},
						  	{chapterNum = 3, killRequired = 30}
						  }

