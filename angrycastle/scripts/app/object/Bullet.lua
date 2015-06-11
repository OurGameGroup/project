WeaponClass = require("app.object.Weapon")

local Bullet = class("Bullet",function()
    return display.newNode()
end)

require("app.Tools.MyMath")
require("app.GameData")

function Bullet:ctor(bulletType)
	self.type = bulletType
	self:initAnimation(bulletType)
	self.hit = false
end

function Bullet:init(pos,speed)
	self.speed = deepCopyCCPoint(speed)
	self:setRotation(-math.deg(self.speed:getAngle())-90)
	self:setPosition(pos)
end

function Bullet:initAnimation(bulletType)
	if(bulletType == 1)then
		CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("fireBullet/fireBullet.ExportJson")
		self._armature = CCArmature:create("fireBullet")
		self._armature:scale(0.2)
		self._armature:getAnimation():setSpeedScale(0.3)
    	self:addChild(self._armature)
 		self._armature:getAnimation():play("blow",-1,-1)
 	else
 		self.img = display.newSprite("bullet2.png")
 		self.img:scale(0.1)
 		self:addChild(self.img)
 	end
 end


function Bullet:updatePosition()
	self:setRotation(-math.deg(self.speed:getAngle())-90)
	self:setPosition(addCCPoint(self:getPositionInCCPoint(), self.speed))
	self.speed = addCCPoint(self.speed, GameData.gravity)
end

function Bullet:hitTo(enemy)
	if self.type == 1 then
		enemy.burning = true
		enemy.burningTime = 120
	else
		enemy.frozen = true
		enemy.frozenTime = 120
	end
end

function Bullet:hitGround(ground)
	if(self:getPositionY() < ground:getPositionY()) then
		ground:showEffect(self.type,self:getPositionX())
		return true
	end
	return false
end

return Bullet