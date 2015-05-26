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
	self:showDamage()
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

function Castle:showDamage()
	local labelTTF = ui.newTTFLabelWithOutline({
		text  = "-1",
		size  = 60,
		color = ccc3(255, 0, 0),
		align = ui.TEXT_ALIGN_RIGHT,
		x     = self:getTowerTop().x,
		y     = self:getTowerTop().y,
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

return Castle