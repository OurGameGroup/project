ClassBullet = require("app.Game.Bullet")
ClassUnit = require("app.Game.Unit")


local GameDirector = class("GameDirector")

function GameDirector:ctor()
end

function GameDirector:init(scene)
	self:initBullets(scene)
	self:initUnits(scene)
	self._addUnitTime = GameData.addUnitIntervalTime
end

function GameDirector:update()
	self._addUnitTime = self._addUnitTime - 1
	if self._addUnitTime <= 0 then
		self._addUnitTime = GameData.addUnitIntervalTime
		self:addUnit()
	end
    updateObjectList(self._listBullet)
    updateObjectList(self._listUnit)
end


function GameDirector:initBullets(scene)
    self._listBullet = {}
    self._layerBullet = display.newNode()
    scene:addChild(self._layerBullet)
end

function GameDirector:addBullet(destPos)
    local bullet = ClassBullet.new()
    bullet:init(destPos)
    table.insert(self._listBullet, bullet)
    self._layerBullet:addChild(bullet)
end



function GameDirector:initUnits(scene)
    self._listUnit = {}
    self._layerUnit = display.newNode()
    scene:addChild(self._layerUnit)
end
function GameDirector:addUnit()
    local unit = ClassUnit.new()
    table.insert(self._listUnit, unit)
    self._layerUnit:addChild(unit)
end

return GameDirector