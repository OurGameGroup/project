Castle = class("Castle", function()
    return display.newNode()
end)

require("app.GameData")

function Castle:ctor()
	self:initAnimation()
end

function Castle:init(pos)
	self:setPosition(pos)
	self.hp = 10
end

function Castle:initAnimation()
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("castle/castle.ExportJson")
	self._armature = CCArmature:create("castle")
	self._armature:scale(0.5)
	self._armature:getAnimation():setSpeedScale(0.3)
    self:addChild(self._armature)
 	self._armature:getAnimation():play("normal_Copy1",-1,-1)
end
function Castle:damage()
	self.hp = self.hp - 1
	self:showDamage()
end

function Castle:getTowerTop()
	return CCPoint(self:getPositionX(), self:getCascadeBoundingBox():getMaxY())
end

function Castle:underTower(point)
	return self:getCascadeBoundingBox():containsPoint(point)
end

function Castle:showDamage()
	if (self.hp > 8) then
		self._armature:getAnimation():play("normal_Copy1",-1,-1)
	elseif (self.hp > 5) then
		self._armature:getAnimation():play("quarterLeft",-1,-1)
	elseif (self.hp > 2) then
		self._armature:getAnimation():play("halfLeft",-1,-1)
	elseif (self.hp > 0) then
		self._armature:getAnimation():play("quarterRemain",-1,-1)
	elseif (self.hp == 0) then
		self._armature:getAnimation():play("gameOver",-1,-1)
	end
end

return Castle