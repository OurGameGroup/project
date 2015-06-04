local Effect = class("Effect", function()
    return display.newNode()
end)

function Effect:ctor()
	self.img = display.newSprite("Effect/fire.png")
	self:addChild(self.img)
end

function Effect:init(pos,lifeTime)
	self:setPosition(pos)
	self.lifeTime = lifeTime
end

return Effect
