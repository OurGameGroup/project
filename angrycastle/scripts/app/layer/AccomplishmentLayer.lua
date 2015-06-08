require("app.layer.MoneyLayer")

AccomplishmentLayer = class("AccomplishmentLayer", function()
    return display.newLayer()
end)

function AccomplishmentLayer:ctor()
	self.WRB = display.newSprite("whiteRichBeauty.jpg")
	self.WRB:setVisible(false)
	self.WRB:setAnchorPoint(ccp(0,0))
	self.WRB:setScale(0.3)
	self:addChild(self.WRB)
	self:init();
end

function AccomplishmentLayer:init()
	self.girlMan = false
	self.whiteRichBeauty = false
end

function AccomplishmentLayer:addAccomplishment()
	if self:checkItem(self.whiteRichBeauty) then
		self.WRB:setVisible(true)
	end
	
end

function AccomplishmentLayer:checkItem(name)
	-- Check if the accomplishment has been displayed
	if name == false then
		return true
	end
end