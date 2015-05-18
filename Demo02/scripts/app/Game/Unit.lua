local Unit = class("Unit", function()
    return display.newScene("Unit")
end)

function Unit:ctor()
	local img = display.newSprite("img2.png")
	local scale = getRandomFloat(0.4, 0.6)
	self:setScale(scale)
	self._r = GameData.unitR * scale
	self:addChild(img)
	self:setAnchorPoint(ccp(0,0))
	local isLeft = (getRandomInt(1, 2) == 1)

	self._speed = getRandomFloat(6,9)
	local y = getRandomInt(CONFIG_SCREEN_HEIGHT*0.7,CONFIG_SCREEN_HEIGHT*0.9)
	local x
	if isLeft then
		img:setScaleX(1)
		x = 0
	else
		img:setScaleX(-1)
		x = CONFIG_SCREEN_WIDTH
		self._speed = -self._speed
	end
	self:setState(State.move)
	self:pos(x,y)
end


function Unit:setState(state)
	self._state = state
	if state == State.burst then
		self:toBurst()
	end
end

function Unit:toBurst()
	local function callback()
		self:setState(State.null)
	end
    local seq = transition.sequence({
        CCScaleTo:create(0.5, 0)
        , CCCallFunc:create(callback)
        })
    self:runAction(seq)
end


function Unit:update()
	if self._state == State.move then
		moveCCnode(self, self._speed, 0)
		if not hitR2P(GameData.rectScreen, self:getPositionInCCPoint()) then		
			self:setState(State.null)
		end
	elseif self._state == State.null then
		return true
	end
end

return Unit