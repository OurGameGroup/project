local Enemy = class("Enemy", function()
    return display.newNode()
end)

function Enemy:ctor()
	self.img = display.newSprite("enemy.png")
	self:scale(0.3)
	self:addChild(self.img)
end

function Enemy:init(x,y)
	self:pos(x,y)
	self.speed = CCPoint(-1, 0)
end

function Enemy:update()
	-- self:SetPositionX(addCCPoint(self:getPositionInCCPoint(), self.speed).x)
	self:setPositionX(self:getPositionX() - 1)
end
	

return Enemy