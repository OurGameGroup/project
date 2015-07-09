local PopWindow = class("PopWindow", function()
	return display.newScene("PopWindow")
end)

function PopWindow:ctor(texture)
	local bg = CCSprite:createWithTexture(texture:getSprite():getTexture())
	bg:pos(display.cx,display.cy)
	bg:setFlipY(true)
	bg:setColor(ccc3(100,100,100))
	self:addChild(bg)

	cc.FileUtils:getInstance():addSearchPath("res/PauseWindow/")
	local node,width,height = cc.uiloader:load("PauseWindow_1.ExportJson")

	node:pos(display.cx,0)
	node:scale(0.5)
	self:addChild(node)

	local playButton = cc.uiloader:seekNodeByName(self,"play")
	playButton:onButtonClicked(function ( event )
		audio.resumeAllSounds()
		CCDirector:sharedDirector():popScene()
	end)

	local exitButton = cc.uiloader:seekNodeByName(self,"exit")
	exitButton:onButtonClicked(function ()
		display.replaceScene(require("app.scenes.StartScene").new(), "fade", 2.0, display.COLOR_WHITE)
	end)

	node:setAnchorPoint(ccp(0.5,0))

	transition.execute(node, CCScaleBy:create(0.1,2), {
   		onComplete = function ()
   			-- self:removeChild(img)
   		end
   	})
	
end

return PopWindow