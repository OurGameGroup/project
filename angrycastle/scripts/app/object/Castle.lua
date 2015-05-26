Castle = class("Castle", function()
    return display.newSprite("castle.png")
end)

require("app.GameData")

function Castle:ctor()
 	self:scale(0.25)
end

function Castle:init(pos)
	self:setPosition(pos)
	self.hp = 10
end

function Castle:damage()
	self.hp = self.hp - 1

	if(self.hp < 0)then
		print "GameOver"
	end
end

function Castle:getTowerTop()
	return CCPoint(self:getPositionX(), self:getBoundingBox():getMaxY())
end

function Castle:underTower(point)
	return self:getBoundingBox():containsPoint(point)
end

return Castle