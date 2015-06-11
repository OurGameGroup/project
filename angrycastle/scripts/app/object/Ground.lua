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

function Ground:showEffect(type,x)
	if(type == "burning")then
		local effect = EffectClass.new()
		effect:init(CCPoint(x - self:getPositionX(), self:getPositionY() - 40),120)
		self:addChild(effect)

		table.insert(self.effectList, effect)
	elseif(type == 2)then
		local thunder = ThunderClass.new()
		thunder:init(CCPoint(x - self:getPositionX(), self:getPositionY() - 40),120)
		self:addChild(thunder)

		local action1 = CCFadeIn:create(0.2)
		local action2 = CCFadeOut:create(0.2)
		local ccarray = CCArray:create()
   		ccarray:addObject(action1)
   		ccarray:addObject(action2)

   		local SequenceAction = CCSequence:create(ccarray)

		transition.execute(thunder, SequenceAction, {
   			onComplete = function ()
   				self:removeChild(thunder)
   			end
   		})
	end
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
			enemy.burning = true
			if(enemy.burningTime < 60)then
				enemy.burningTime = enemy.burningTime + 120
			end
		end
	end
end

function Ground:showThunder()
	-- body
end

return Ground