local StartScene = class("StartScene", function()
    return display.newScene("StartScene")
end)

require("app.GameData")

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

	transition.execute(startButton, shake())
	transition.execute(aboutButton, shake())
	transition.execute(quitButton, shake())
	transition.execute(soundButton, shake())

	local moon = cc.uiloader:seekNodeByName(self,"moon")

	if(GameData.chapter == 2)then
		moon:setColor(ccc3(255,40,40))
	elseif (GameData.chapter == 3) then
		moon:setColor(ccc3(80,80,255))
	end

	transition.execute(moon, CCRepeatForever:create(CCRotateBy:create(1, 1)))
	
	self:initAboutPage()

	aboutButton:onButtonClicked(function()
		self.aboutPage:setVisible(true)
	end)
	
end

function StartScene:initAboutPage()
	self.aboutPage = cc.ui.UIPushButton.new({ normal = "about.jpg"})
      :onButtonClicked(
        function ()
        	self.aboutPage:setVisible(false)
        end
      )
      :pos(display.cx, display.cy)
  	self:addChild(self.aboutPage)

  	self.aboutPage:setVisible(false)
end

function shake()
	local action1 = CCScaleBy:create(2,1.25)
	local action2 = action1:reverse()
	local ccarray = CCArray:create()
	ccarray:addObject(action1)
	ccarray:addObject(action2)
	local SequenceAction = CCSequence:create(ccarray)
	return CCRepeatForever:create(SequenceAction)
end

 
return StartScene