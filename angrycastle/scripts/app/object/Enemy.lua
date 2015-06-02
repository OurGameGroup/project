local Enemy = class("Enemy", function()
    return display.newNode()
end)
require("app.Tools.MyMath")
function Enemy:ctor()
	self.img = display.newSprite("enemy.png")
	self:scale(0.3)
	self:addChild(self.img)
	self.hp = 6

	self.underTower = false
	self.underTowerTime = 0

	self.frozen = false
	self.frozenTime = 0

	self.burning = false
	self.burningTime = 0
end

function Enemy:init(pos)
	self:setPosition(pos)
	self.normalSpeed = CCPoint(-1, 0)
	self.speed = deepCopyCCPoint(self.normalSpeed)
end

function Enemy:updatePosition()
	self:setPosition(addCCPoint(self.speed, self:getPositionInCCPoint()))
end

function Enemy:updateByStatus()
	if self.underTower then
		self.speed = CCPoint(0, 0)
		self.underTowerTime = self.underTowerTime + 1
	end

	if self.frozen then
		self.speed = numberTimesCCPoint(0.2, self.normalSpeed)
		self.frozenTime = self.frozenTime - 1
		if(self.frozenTime < 0)then
			self.frozen = false
			self.speed = deepCopyCCPoint(self.normalSpeed)
		end
	end

	if self.burning then
		
		if(self.burningTime % 30 == 0) then
            self.hp = self.hp - 1
			self:showDamage()
        end
		
        self.burningTime = self.burningTime - 1

		if(self.burningTime < 0)then
			self.burning = false
		end
	end
end

function Enemy:showDamage()
	local labelTTF = ui.newTTFLabelWithOutline({
		text  = "-1",
		size  = 60,
		color = ccc3(255, 0, 0),
		align = ui.TEXT_ALIGN_RIGHT,
		x     = 0,
		y     = 0,
		outlineColor = ccc3(255, 255, 0)
		})
	self:addChild(labelTTF)

	local move1 = CCMoveBy:create(1, CCPoint(50, 50))
   	local move2 = CCFadeOut:create(1)

   	local ccarray = CCArray:create()
   	ccarray:addObject(move1)
   	ccarray:addObject(move2)
   	
   	local SpawnAction = CCSpawn:create(ccarray)
   	-- labelTTF:playAnimationOnce(SpawnAction,true)

   	-- labelTTF:runAction(SpawnAction)
   	transition.execute(labelTTF, SpawnAction, {
   		onComplete = function ()
   			self:removeChild(labelTTF)
   		end
   	})
end

return Enemy