GamePause = class("GamePause")

function GamePause:ctor()
	
end

function gamePause(scene)
	audio.pauseAllSounds()
	
	local texture = CCRenderTexture:create(display.width, display.height)
	texture:begin()
	scene:visit()
	texture:endToLua()
	
	CCDirector:sharedDirector():pushScene(require("app.scenes.PopWindow").new(texture))
end

return GamePause