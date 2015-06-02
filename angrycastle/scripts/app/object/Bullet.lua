local Bullet = class("Bullet",function()
    return display.newNode()
end)

require("app.Tools.MyMath")
require("app.GameData")

function Bullet:ctor(bulletType)
	self.type = bulletType
	local bulletName
	if(bulletType == 1)then
		bulletName = "bullet.png"
	else
		bulletName = "bullet2.png"
	end
	self.img = display.newSprite(bulletName)
	self.img:scale(0.1)
	self:addChild(self.img)
	self.hit = false
end

function Bullet:init(pos,speed)
	self.speed = deepCopyCCPoint(speed)
	self:setPosition(pos)
end

function Bullet:update()
	self:setPosition(addCCPoint(self:getPositionInCCPoint(), self.speed))
	self.speed = addCCPoint(self.speed, GameData.gravity)
end

function Bullet:hitTo(enemy)
	if self.type == 1 then
		enemy.killed = true
	else
		enemy.frozen = true
		enemy.frozenTime = 60
	end
end

return Bullet