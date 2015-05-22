local Unit = class("Unit", function()
    return display.newScene("Unit")
end)

function Unit:ctor()
end

function Unit:init(name,x,y)
	
	self._armature = CCArmature:create(name)---------根据name创建动作
	local function animationEvent(armatureBack,movementType,movementID) ------动作的回调函数
		if movementType == 1 then----- movementType 0开始  1非循环结束  2循环结束
			self._armature:getAnimation():stop()
			self:actionCallback()
		end
	end
	self._armature:getAnimation():setMovementEventCallFunc(animationEvent) ---加载指定动作的回调函数
	self._armature:getAnimation():setSpeedScale(0.7) ---------设定动作的播放速度  百分比  可选

	self:addChild(self._armature)
	self:pos(x,y)

	self:setState(State.stand)
end


function Unit:setState(state)
	self._state = state
	local actionName = State.actionName[state]
	self._armature:getAnimation():play(actionName,-1,-1,State.isLoop[state] and 1 or 0) -------播放动画
end

function Unit:actionCallback() ----- 非循环动作结束回调
	if self._state == State.attack then
		-- self:setState(State.stand)
	elseif self._state == State.hurt then

	elseif self._state == State.dead then
	end
end



function Unit:update()
	if self._state == State.move then

	elseif self._state == State.null then
		return true
	end
	return false
end

return Unit