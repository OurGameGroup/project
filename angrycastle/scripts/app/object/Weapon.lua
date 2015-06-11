local Weapon = class("Weapon",function()
    return display.newNode()
end)

require("app.GameData")
require("app.Tools.MyMath")

function Weapon:ctor(type)
	self.hit = false

	local data = GameData.weapon[type]
	self.speed = data.speed
	self.gravityEnable = data.gravityEnable
	self.rotatable = data.rotatable
	self.effect = data.effect
	self.effectTime = data.effectTime

	self:initAnimation(data.animation)
end

function Weapon:init(pos,speed)
	self:setPosition(pos)
	self.speed = deepCopyCCPoint(speed)
	self:setRotation(-math.deg(self.speed:getAngle())-90)
end

function Weapon:initAnimation(dataAnimation)
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo(dataAnimation.FileName)
	self.animation = CCArmature:create(dataAnimation.Name)
	self.animation:scale(0.2)
	self.animation:getAnimation():setSpeedScale(0.3)
    self:addChild(self.animation)
 	self.animation:getAnimation():play(dataAnimation.defaultAnimation,-1,-1)
end

function Weapon:updatePosition()
	self:setPosition(addCCPoint(self:getPositionInCCPoint(), self.speed))

	if(self.gravityEnable) then
		self.speed = addCCPoint(self.speed, GameData.gravity)
	end

	if(self.rotatable) then
		self:setRotation(-math.deg(self.speed:getAngle())-90)
	end
end

function Weapon:hitTo(enemyList)
	for i,enemy in ipairs(enemyList) do
		if(hitN2N(self, enemy))then
			enemy:getEffect(self.effect,self.effectTime)
			self.hit = true
		end
	end
end

function Weapon:hitGround(ground)
	if(self:getPositionY() <= ground:getPositionY()) then
		ground:showEffect(self.effect,self:getPositionX())
		return true
	end
	return false
end


return Weapon