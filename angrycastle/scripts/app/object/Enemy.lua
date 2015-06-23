local Enemy = class("Enemy", function()
    return display.newNode()
end)
require("app.Tools.MyMath")
BloodClass = require("app.object.progressBar")
TextClass = require("app.Tools.MyText")

function Enemy:ctor()
	
	
	self.hp = 6

	self.quick = randomNumber(0,3) < 1
	self.strong = randomNumber(0,3) < 1

	if(self.strong)then
		self.hp = 2 * self.hp
	end

	self.underTower = false
	self.underTowerTime = -1

	self.frozen = false
	self.frozenTime = 0

	self.burning = false
	self.burningTime = 0
	self.onBurning = 0

	self.winding = false
	self.windingTime = 0

	self:initAnimation()
	self:initBloodBar()

end

function Enemy:init(pos)
	local zOrder = math.ceil(randomNumber(0, 60))
	self:setZOrder(60 - zOrder)
	self:pos(pos.x,pos.y+zOrder)
	self.normalSpeed = CCPoint(-1, 0)
	if(self.quick)then
		self.normalSpeed = numberTimesCCPoint(2,self.normalSpeed)
	end
	self.speed = deepCopyCCPoint(self.normalSpeed)
	self.state = "running"
	self.interruptable = true

	self:initName(name)
end

function Enemy:initName()
	local name = "怪物"
	local count = 0

	if(self.quick)then
		name = "迅速的"..name
		count = count + 1
	end

	if(self.strong)then
		name = "强壮的"..name
		count = count + 1
	end

	if(count == 0)then
		name = "普通的"..name
	end

	self.name = TextClass.new(name)
	self.name:setPosition(CCPoint(-10,60))

	if(count == 1)then
		self.name:setColor("purple")
	elseif (count == 2) then
		self.name:setColor("yellow")
	end

	self:addChild(self.name)
end

function Enemy:initBloodBar()
	self.blood = BloodClass.new(self.hp)
	self.blood:setPosition(CCPoint(-10,50))
	self:addChild(self.blood)
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

	if self.winding then
		self.speed = CCPoint(0, 0)
		self._armature:getAnimation():setSpeedScale(0.1)
		self.windingTime = self.windingTime - 1
		if(self.windingTime < 0)then
			self.winding = false
			self.speed = deepCopyCCPoint(self.normalSpeed)
			self._armature:getAnimation():setSpeedScale(1)
		end
	end

	if self.burning then
		
		if(self.onBurning % 30 == 0) then
            self.hp = self.hp - 1
			self:showDamage()
        end
		
        self.burningTime = self.burningTime - 1

        self.onBurning = self.onBurning + 1

		if(self.burningTime < 0)then
			self.burning = false
			self.onBurning = 0
		end
	end
end

function Enemy:showDamage()
	self.blood:setPercentage(self.hp)
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

function Enemy:getEffect(effect,effectTime)
	if(effect == "frozen")then
		self.frozen = true
		self.frozenTime = effectTime
	elseif (effect == "burning") then
		self.burning = true
		self.burningTime = effectTime
		self.onBurning = 0
	elseif (effect == "sudoKill") then
		self.hp = -1
	elseif (effect == "winding") then
		self.winding = true
		self.windingTime = effectTime
	end
end

function Enemy:getEffectFromGround(effect,effectTime)
	if(effect == "burning")then
		self.burning = true
		self.burningTime = effectTime
	elseif (effect == "winding") then
		self.winding = true
		self.windingTime = 3
	end
end

function Enemy:getCascadeBoundingBox()
	return self._armature:getCascadeBoundingBox()
end


return Enemy