local Enemy = class("Enemy", function()
    return display.newNode()
end)

enemySpeed = 1


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

	self.centery = y
	
	if(x > display.cx)then
		self:setScaleX(-1)
		self.speed = CCPoint(-enemySpeed,0)
	else
		self.speed = CCPoint(enemySpeed,0)
	end

	self.acceleration = CCPoint(0,2)
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
		self:wave()
		-- self.speed = add(self.speed,gravity)
	end
end

changespeed = 0

function Enemy:wave()
	if (self.inited) then
		changespeed = changespeed + 1
		if(changespeed >= 1) then
		self.speed = add(self.speed,self.acceleration)
		self.acceleration = CCPoint(0,(self.centery - self:getPositionY())/display.height)
		changespeed = 0
		end
	end
end

return Enemy