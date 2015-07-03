local PopWindow = class("PopWindow", function()
	return display.newScene("PopWindow")
end)

function PopWindow:ctor(texture)
	local bg = CCSprite:createWithTexture(texture:getSprite():getTexture())
	bg:pos(display.cx,display.cy)
	bg:setFlipY(true)
	bg:setColor(ccc3(100,100,100))
	self:addChild(bg)

	cc.FileUtils:getInstance():addSearchPath("res/pauseWindow/")
	local node,width,height = cc.uiloader:load("pauseWindow_1.ExportJson")
	self:addChild(node)

	local playButton = cc.uiloader:seekNodeByName(self,"play")
	playButton:onButtonClicked(function ( event )
		audio.resumeAllSounds()
		CCDirector:sharedDirector():popScene()
	end)
end

return PopWindow