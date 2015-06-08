require("app.layer.MoneyLayer")

AccomplishmentLayer = class("AccomplishmentLayer", function()
    return display.newLayer()
end)

function AccomplishmentLayer:ctor()
	self:init();
end

function AccomplishmentLayer:init()
	self.firstBlood = false
	self.tenEnemy = false
	self.thousandCoins = false
	self.firstBloodRemoved = false
	self.tenEnemyRemoved = false
	self.thousandCoinsRemoved = false
	self.count = 0
end

function AccomplishmentLayer:initAccomplishmentFirstBlood()
	self.fb = display.newSprite("Accomplishment/firstblood.png")
	self.fb:setVisible(false)
	self.fb:setAnchorPoint(ccp(0,0))
	self.fb:setPosition(display.width / 3, display.height * 3 / 5)
	self.fb:setScale(0.3)
	self:addChild(self.fb)
end

function AccomplishmentLayer:initAccomplishmentTenEnemy()
	self.te = display.newSprite("Accomplishment/10enemy.png")
	self.te:setVisible(false)
	self.te:setAnchorPoint(ccp(0,0))
	self.te:setPosition(display.width / 3, display.height * 3 / 5)
	self.te:setScale(0.3)
	self:addChild(self.te)
end

function AccomplishmentLayer:initAccomplishmentThousandCoins()
	self.tc = display.newSprite("Accomplishment/1000coins.png")
	self.tc:setVisible(false)
	self.tc:setAnchorPoint(ccp(0,0))
	self.tc:setPosition(display.width / 3, display.height * 3 / 5)
	self.tc:setScale(0.3)
	self:addChild(self.tc)
end

function AccomplishmentLayer:addAccomplishmentFirstBlood()
	if self.firstBlood == false then
		self:initAccomplishmentFirstBlood()
		self.firstBlood = true
		self.fb:setVisible(true)
		self.fb:runAction(CCScaleBy:create(0.5,1.7))
	end
	
	if self.firstBloodRemoved == false then
		self.count = self.count + 1
		if self.count % 90 == 0 then
			self:removeAccomplishmentFirstBlood()
			self.firstBloodRemoved = true
		end
	end

end	

function AccomplishmentLayer:addAccomplishmentTenEnemy()
	if self.tenEnemy == false then
		self:initAccomplishmentTenEnemy()
		self.tenEnemy = true
		self.te:setVisible(true)
		self.te:runAction(CCScaleBy:create(0.5,1.7))
	end
	
	if self.tenEnemyRemoved == false then
		self.count = self.count + 1
		if self.count % 90 == 0 then
			self:removeAccomplishmentTenEnemy()
			self.tenEnemyRemoved = true
		end
	end
	
end

function AccomplishmentLayer:addAccomplishmentThousandCoins()
	if self.thousandCoins == false then
		self:initAccomplishmentThousandCoins()
		self.thousandCoins = true
		self.tc:setVisible(true)
		self.tc:runAction(CCScaleBy:create(0.5,1.7))
	end
	
	if self.thousandCoinsRemoved == false then
		self.count = self.count + 1
		if self.count % 90 == 0 then
			self:removeAccomplishmentThousandCoins()
			self.thousandCoinsRemoved = true
		end
	end
end

function AccomplishmentLayer:removeAccomplishmentFirstBlood()
	print(self.count)
	
	self:removeChild(self.fb)
	print("here")
	self.count = 0
end

function AccomplishmentLayer:removeAccomplishmentTenEnemy()
	self:removeChild(self.te)
	self.count = 0
end

function AccomplishmentLayer:removeAccomplishmentThousandCoins()
	self:removeChild(self.tc)
	self.count = 0
end

function AccomplishmentLayer:checkItem(name)
	-- Check if the accomplishment has been displayed
	if name == false then
		return true
	end
end