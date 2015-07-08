local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)

function StartScene:ctor()
	cc.FileUtils:getInstance():addSearchPath("res/EnterScene/")
	local node,width,height = cc.uiloader:load("EnterScene_1.ExportJson")

	self:addChild(node)

    local startButton = cc.uiloader:seekNodeByName(self,"start")
	startButton:onButtonClicked(function()
		display.replaceScene(require("app.scenes.MainScene").new(), "fade", 2.0, display.COLOR_WHITE)
	end)

	local aboutButton = cc.uiloader:seekNodeByName(self,"about")
	local quitButton = cc.uiloader:seekNodeByName(self,"quit")
	local soundButton = cc.uiloader:seekNodeByName(self,"sound")

	local action1 = CCScaleBy:create(2,1.25)
	local action2 = action1:reverse()
	local ccarray = CCArray:create()
	ccarray:addObject(action1)
	ccarray:addObject(action2)
	local SequenceAction = CCSequence:create(ccarray)
	
	-- local CCSpawnAction = CCSpawn:create()

	transition.execute(startButton, CCRepeatForever:create(SequenceAction))
	-- transition.execute(aboutButton, CCRepeatForever:create(SequenceAction),0.5)
	-- transition.execute(quitButton, CCRepeatForever:create(SequenceAction),1)
	-- transition.execute(soundButton, CCRepeatForever:create(SequenceAction),1.5)

	local moon = cc.uiloader:seekNodeByName(self,"moon")

	transition.execute(moon, CCRepeatForever:create(CCRotateBy:create(1, 1)))

	
end

 
return StartScene