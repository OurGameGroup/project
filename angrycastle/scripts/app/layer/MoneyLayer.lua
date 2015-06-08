MoneyLayer = class("Moneyayer", function()
    return display.newLayer()
end)

function MoneyLayer:ctor()
	self.money = 0
	self:init()
end

function MoneyLayer:init()
	self.mimg = display.newSprite("money.png")
	self:setPosition(CCPoint(display.width*7/8, display.height*7/8))
	self:setAnchorPoint(ccp(0,0))
	self:scale(0.3)
	self:addChild(self.mimg)

	self.labelTTF = ui.newTTFLabelWithOutline({
		text  = self.money,
		size  = 100,
		color = ccc3(255, 255, 0),
		align = ui.TEXT_ALIGN_RIGHT,
		x     = 300,
		y     = 0,
		outlineColor = ccc3(255, 255, 0)
		})
	self:addChild(self.labelTTF)
end

function MoneyLayer:addMoney()
	self.money = self.money + 10
	self.labelTTF:setString(self.money)
end

return MoneyLayer