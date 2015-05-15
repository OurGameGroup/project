--
-- Author: ChengQZ
-- Date: 2015-05-13 15:43:01
--
local Shell = class("Shell", function()
    return display.newSprite("img1.png")
end)

function Shell:ctor()
	self:pos(display.cx, 0)
end

function Shell:setDirection(x,y)
	self:ctor()

    local distance = math.sqrt((x - display.cx)*(x - display.cx)+y*y)

    local degree = math.deg(math.asin(y/distance))
    if(x < display.cx) then
        degree = 180 - degree
    end
    degree = 180 -degree

	self.setRotationX(fRotaionX)
end

return Shell