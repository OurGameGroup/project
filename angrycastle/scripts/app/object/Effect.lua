local Effect = class("Effect", function()
    return display.newNode()
end)

function Effect:ctor(weaponEffect,effectTime,hitGroundImage)
	self.img = display.newSprite(hitGroundImage)
	self.name = weaponEffect
	self.effectTime = effectTime
	self:addChild(self.img)

	self.img:setAnchorPoint(ccp(0.5,0))
	transition.execute(self, shake())
end

function Effect:init(pos,lifeTime)
	self:setPosition(pos)
	self.lifeTime = lifeTime
end

function shake()
	local action1 = CCScaleBy:create(0.5,1.1)
	local action2 = action1:reverse()
	local ccarray = CCArray:create()
	ccarray:addObject(action1)
	ccarray:addObject(action2)
	local SequenceAction = CCSequence:create(ccarray)
	return CCRepeatForever:create(SequenceAction)
end

return Effect
