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
	self.doNotHitEnemy = data.doNotHitEnemy
	self.hitGroundImage = data.hitGroundImage

	if(data.body == "animation")then
		self:initAnimation(data.animation)
	elseif (data.body == "image")then
		self:initImage(data.image)
	end
end

audio.preloadSound("fireBullet/burning.wav")

function Weapon:init(pos,speed)
	self:setPosition(pos)
	self.speed = deepCopyCCPoint(speed)
	self:setRotation(-math.deg(self.speed:getAngle())-90)
	if(self.effect == "burning" and GameData.sound)then
		self.sound = audio.playSound("fireBullet/burning.wav", true)
	end
end

function Weapon:initImage(dataImage)
	self.image = display.newSprite(dataImage)
	self.image:scale(0.1)
	self:addChild(self.image)
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
			if(self.effect == "burning" and GameData.sound)then
				audio.stopSound(self.sound)
			end
		end
	end
end

function Weapon:hitGround(ground)
	if(self:getPositionY() <= ground:getPositionY()) then
		ground:showEffect(self,self:getPositionX())
		if(self.effect == "burning" and GameData.sound)then
			audio.stopSound(self.sound)
		end
		return true
	end
	return false
end


return Weapon