local Thunder = class("Thunder",function()
    return display.newNode()
end)

function Thunder:ctor()
	self.img = display.newSprite("Thunder.png")
	self.img:setAnchorPoint(ccp(0.5,0.1))
	self:addChild(self.img)
end

function Thunder:init(pos)
	self:setPosition(pos)
end

return Thunder
