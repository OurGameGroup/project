local Enemy = class("Enemy", function()
    return display.newNode()
end)
require("app.Tools.MyMath")
function Enemy:ctor()
	self.img = display.newSprite("enemy.png")
	self:scale(0.3)
	self:addChild(self.img)
	self.killed = false
	self.underTower = false
	self.frozen = false
	self.underTowerTime = 0
	self.frozenTime = 0
end

function Enemy:init(pos)
	self:setPosition(pos)
	self.speed = CCPoint(-1, 0)
	
end

function Enemy:update()
	if (self.underTower) then
		self.underTowerTime = self.underTowerTime + 1
	elseif self.frozen then
		self:setPosition(addCCPoint(numberTimesCCPoint(0.2, self.speed), self:getPositionInCCPoint()))
		self.frozenTime = self.frozenTime - 1
		if(self.frozenTime < 0)then
			self.frozen = false
		end
	else
		self:setPosition(addCCPoint(self.speed, self:getPositionInCCPoint()))
	end
end



return Enemy