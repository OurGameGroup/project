
BackgroundLayer = class("BackgroundLayer",function()
    return display.newLayer()
end)
 
function BackgroundLayer:ctor()

end

function BackgroundLayer:createBackground()
	local bg = display.display.newSprite("back.jpg")
	:scale(0.3)
	:pos(display.cx,display.cy)
	:addTo(self,5)
end

return BackgroundLayer