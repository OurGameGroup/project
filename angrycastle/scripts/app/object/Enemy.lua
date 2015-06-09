local Enemy = class("Enemy", function()
    return display.newNode()
end)
require("app.Tools.MyMath")
function Enemy:ctor()
	self:initAnimation()

	self.hp = 6

	self.underTower = false
	self.underTowerTime = -1

	self.frozen = false
	self.frozenTime = 0

	self.burning = false
	self.burningTime = 0

end

function Enemy:init(pos)
	local yOrder = math.ceil(randomNumber(0, 60))
	self:setZOrder(60 - yOrder)
	self:pos(pos.x,pos.y+yOrder)
	self.normalSpeed = CCPoint(-1, 0)
	self.speed = deepCopyCCPoint(self.normalSpeed)
	self.state = "running"
	self.interruptable = true
end

function Enemy:initAnimation()
	CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("Enemy/enemy1.ExportJson")

    self._armature = CCArmature:create("enemy1")   -- 根据name创建动作（寻找动作序列中名为name的动作）

    -- self._armature:getAnimation():setSpeedScale(1)     ---------设定动作的播放速度  百分比  可选

    local function animationEvent(armatureBack,movementType,movementID) ------动作的回调函数

		if movementType == 2 and movementID == "attack" then----- movementType 0开始  1非循环结束  2循环结束
			self._armature:getAnimation():stop()
			self.interruptable = true
		end
	end
	self._armature:getAnimation():setMovementEventCallFunc(animationEvent)

    self._armature:scale(0.1)

    self:addChild(self._armature)

 	self._armature:getAnimation():play("running",-1,-1)
end

function Enemy:setState(state)
	if(self.state ~= state and self.interruptable)then
		self.state = state
		self._armature:getAnimation():play(self.state,-1,-1)

		if(self.state == "attack")then
			self.interruptable = false
		end
	end
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
		self._armature:getAnimation():setSpeedScale(0.2)
		self.frozenTime = self.frozenTime - 1
		if(self.frozenTime < 0)then
			self.frozen = false
			self.speed = deepCopyCCPoint(self.normalSpeed)
			self._armature:getAnimation():setSpeedScale(1)
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
		size  = 20,
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