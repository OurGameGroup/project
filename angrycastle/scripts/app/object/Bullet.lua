local Bullet = class("Bullet",function()
    return display.newNode()
end)

require("app.Tools.MyMath")
require("app.GameData")

function Bullet:ctor()
	self.img = display.newSprite("bullet.png")
	self.img:scale(0.1)
	self:addChild(self.img)
end

function Bullet:init(pos,speed)
	self.speed = deepCopyCCPoint(speed)
	self:setPosition(pos)
end

function Bullet:update()
	self:setPosition(addCCPoint(self:getPositionInCCPoint(), self.speed))
	self.speed = addCCPoint(self.speed, GameData.gravity)
end

return Bullet