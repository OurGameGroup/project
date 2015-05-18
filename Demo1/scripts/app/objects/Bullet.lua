local Bullet = class("Bullet", function()
    return display.newNode()
end)


gravity = CCPoint(0,-0.3)

require("app/tools/Vector")

function Bullet:ctor()
	self._imgBullet = display.newSprite("img1.png")
	self._imgBullet:scale(0.5)
	self:addChild(self._imgBullet)

	self.speed = CCPoint(0,0)

	self.inited = false
end

function Bullet:init( x,y,startSpeed)

	self:pos(display.cx, 0)

	local distance = math.sqrt((x - display.cx)*(x - display.cx)+y*y)

    local degree = math.deg(math.asin(y/distance))
    if(x < display.cx) then
        degree = 180 - degree
    end
    degree = 180 -degree

	self:rotation(degree)


	self.speed = CCPoint(startSpeed * (x - display.cx) / distance, startSpeed * y / distance)

	self.inited = true

end

function Bullet:outOfScreen(range)
	if (self.inited) then
		local posx,posy = self:getPosition()

		if(posx <= display.width + range  and posx >= 0 - range  and posy <= display.height + range and posy >= 0 - range ) then
			return false
		end
	end
	return true
end


function Bullet:update()
	if (self.inited) then

		local nextstep = self:getPositionInCCPoint();
		nextstep = add(self.speed,nextstep)
		self:setPosition(nextstep)


		self:rotation(180 - math.deg(self.speed:getAngle()))

		print(self:getRotation(),180 - math.deg(self.speed:getAngle()))

		self.speed = add(self.speed,gravity)
	end
end


return Bullet