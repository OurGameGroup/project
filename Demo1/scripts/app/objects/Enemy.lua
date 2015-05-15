local Enemy = class("Enemy", function()
    return display.newNode()
end)

enemySpeed = 5

require("app/tools/Vector")

function Enemy:ctor()
	self._imgBullet = display.newSprite("enemy.png")
	self._imgBullet:scale(0.5)
	self:addChild(self._imgBullet)

	self.speed = CCPoint(0,0)

	self.inited = false
end

function Enemy:init(x,y)
	self:pos(x, y)
	self.speed = CCPoint(enemySpeed,0)

	self.inited = true
end

function Enemy:outOfScreen(range)
	if (self.inited) then
		local posx,posy = self:getPosition()

		if(posx <= display.width + range  and posx >= 0 - range  and posy <= display.height + range and posy >= 0 - range ) then
			return false
		end
	end
	return true
end

function Enemy:update()
	if (self.inited) then

		local nextstep = self:getPositionInCCPoint();
		nextstep = add(self.speed,nextstep)
		self:pos(nextstep.x, nextstep.y)

		-- self.speed = add(self.speed,gravity)
	end
end

return Enemy