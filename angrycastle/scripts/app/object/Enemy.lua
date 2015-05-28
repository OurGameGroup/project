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
	self.underTowerTime = 0
end

function Enemy:init(pos)
	self:setPosition(pos)
	self.speed = CCPoint(-1, 0)
	
end

function Enemy:update()
	if (self.underTower) then
		self.underTowerTime = self.underTowerTime + 1
	else
		self:setPosition(addCCPoint(self.speed, self:getPositionInCCPoint()))
	end
end



return Enemy