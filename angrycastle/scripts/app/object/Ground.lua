Ground = class("Ground",function()
    return display.newNode()
end)

EffectClass = require("app.object.Effect")
ThunderClass = require("app.object.Thunder")

function Ground:ctor()
	self.img = display.newSprite("ground.png")
	self.img:setVisible(false)
	self.effectList = {}
	self:addChild(self.img)
end

function Ground:init(pos)
	self:setPosition(pos)
end

function Ground:showEffect(weapon,x)
	if(weapon.hitGroundImage == nil)then
		return
	end

	local effect = EffectClass.new(weapon.effect,weapon.effectTime,weapon.hitGroundImage)

	effect:init(CCPoint(x - self:getPositionX(), self:getPositionY()-100),weapon.effectTime)
	self:addChild(effect)

	table.insert(self.effectList, effect)

end

function Ground:update()
	for i,effect in ipairs(self.effectList) do
		effect.lifeTime = effect.lifeTime - 1

		if(effect.lifeTime < 0)then
			self:removeChild(effect)
			table.remove(self.effectList,i)
			i = i - 1
		end
	end
end

function Ground:giveEffect(enemy)
	for i,effect in ipairs(self.effectList) do
		if(hitN2N(effect, enemy))then
			enemy:getEffectFromGround(effect.name, effect.effectTime)
		end
	end
end

function Ground:showThunder()
	-- body
end

return Ground