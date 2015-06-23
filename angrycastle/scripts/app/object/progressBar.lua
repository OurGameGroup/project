local progressBar = class("progressBar", function()
	return display.newNode()
end)

function progressBar:ctor()
	self.background = display.newSprite("bloodProgress2.png")
	self:addChild(self.background)

	self.fill = display.newProgressTimer("bloodProgress.png", display.PROGRESS_TIMER_BAR)
	self.fill:setMidpoint(CCPoint(0, 0.5))
	self.fill:setBarChangeRate(CCPoint(1, 0))
	self:addChild(self.fill)
	self.fill:setPercentage(100)
end

function progressBar:setPercentage(number)
	self.fill:setPercentage(number*100)
end

return progressBar