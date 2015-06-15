local Effect = class("Effect", function()
    return display.newNode()
end)

function Effect:ctor(weaponEffect,effectTime,hitGroundImage)
	self.img = display.newSprite(hitGroundImage)
	self.name = weaponEffect
	self.effectTime = effectTime
	self:addChild(self.img)
end

function Effect:init(pos,lifeTime)
	self:setPosition(pos)
	self.lifeTime = lifeTime
end

return Effect
