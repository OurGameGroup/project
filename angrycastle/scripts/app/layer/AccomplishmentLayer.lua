require("app.layer.MoneyLayer")

AccomplishmentLayer = class("AccomplishmentLayer", function()
    return display.newLayer()
end)

function AccomplishmentLayer:ctor()
	self.fb = display.newSprite("Accomplishment/firstblood.png")
	self.fb:setVisible(false)
	self.fb:setAnchorPoint(ccp(0,0))
	self.fb:setPosition(display.width / 3, display.height * 3 / 5)
	self.fb:setScale(0.3)
	self:addChild(self.fb)

	self.te= display.newSprite("Accomplishment/10enemy.png")
	self.te:setVisible(false)
	self.te:setAnchorPoint(ccp(0,0))
	self.te:setPosition(display.width / 3, display.height * 3 / 5)
	self.te:setScale(0.3)
	self:addChild(self.te)

	self.tc= display.newSprite("Accomplishment/1000coins.png")
	self.tc:setVisible(false)
	self.tc:setAnchorPoint(ccp(0,0))
	self.tc:setPosition(display.width / 3, display.height * 3 / 5)
	self.tc:setScale(0.3)
	self:addChild(self.tc)

	self:init();
end

function AccomplishmentLayer:init()
	self.firstBlood = false
	self.tenEnemy = false
	self.thousandCoins = false
	self.firstBloodExist = false
	self.tenEnemyExist = false
	self.thousandCoinsExist = false
	self.count = 0
end

function AccomplishmentLayer:addAccomplishmentFirstBlood()
	self.count = self.count + 1
	
	if self:checkItem(self.firstBlood) then
		self.firstBlood = true
		self.fb:setVisible(true)
		self.fb:runAction(CCScaleBy:create(0.5,1.7))
	end
end	

function AccomplishmentLayer:addAccomplishmentTenEnemy()
	self.count = self.count + 1

	if self:checkItem(self.tenEnemy) then
		self.tenEnemy = true
		self.te:setVisible(true)
		self.te:runAction(CCScaleBy:create(0.5,1.7))
	end
end

function AccomplishmentLayer:addAccomplishmentThousandCoins()
	self.count = self.count + 1

	if self:checkItem(self.thousandCoins) then
		self.thousandCoins = true
		self.tc:setVisible(true)
		self.tc:runAction(CCScaleBy:create(0.5,1.7))
	end
end

function AccomplishmentLayer:removeAccomplishment()
	if self.count % 90 == 0 then
		if self:checkItem(self.firstBloodExist) then
			self:removeChild(self.fb)
		end
		if self:checkItem(self.tenEnemyExist) then
			self:removeChild(self.te)
		end
		if self:checkItem(self.thousandCoinsExist) then
			self:removeChild(self.tc)
		end
	end
end

function AccomplishmentLayer:checkItem(name)
	-- Check if the accomplishment has been displayed
	if name == false then
		return true
	end
end