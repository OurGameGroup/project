local Bullet = class("Bullet", function()
    return display.newScene("Bullet")
end)
function Bullet:ctor()
	local img = display.newSprite("img1.png")
	local scale = 0.3
	self:setScale(scale)
	self._r = GameData.bulletR * scale
	self:addChild(img)
	self:setAnchorPoint(ccp(0,0))
end

function Bullet:init(destPos)
	self:setPosition(GameData.posStart)
	local distance
	self._speedX,self._speedY,distance = getSpeedXY(GameData.posStart,destPos,GameData.moveSpeed)
	local angle = getAngle(GameData.posStart,destPos,distance)
	self:setRotation(180-angle)
	self:setState(State.move)
end

function Bullet:setState(state)
	self._state = state
	if state == State.burst then
		self:toBurst()
	end
end

function Bullet:toBurst()
	local function callback()
		self:setState(State.null)
	end
    local seq = transition.sequence({
        CCScaleTo:create(0.5, 0)
        , CCCallFunc:create(callback)
        })
    self:runAction(seq)
end


function Bullet:update()
	if self._state == State.move then
		moveCCnode(self, self._speedX, self._speedY)		
		self:hitUnit()
		if not hitR2P(GameData.rectScreen, self:getPositionInCCPoint()) then		
			self:setState(State.null)
		end
	elseif self._state == State.null then
		return true
	end
end

function Bullet:hitUnit()
	for i,unit in ipairs(g_director._listUnit) do
		if unit._state == State.move then
			local distance = getDistance(self,unit)
			if distance < self._r + unit._r then
				unit:setState(State.burst)
				self:setState(State.burst)
				return true
			end
		end
	end
	return false
end

return Bullet