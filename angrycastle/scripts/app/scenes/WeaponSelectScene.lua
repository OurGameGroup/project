local WeaponSelectScene = class("WeaponSelectScene", function()
    return display.newScene("WeaponSelectScene")
end)

function WeaponSelectScene:ctor()
	cc.FileUtils:getInstance():addSearchPath("res/WeaponSelect/")
	local node,width,height = cc.uiloader:load("WeaponSelect_1.ExportJson")
	self:addChild(node)

	local playButton = cc.uiloader:seekNodeByName(self,"play")
	playButton:onButtonClicked(function ( event )
		audio.resumeAllSounds()
		CCDirector:sharedDirector():popScene()
	end)
end

return WeaponSelectScene