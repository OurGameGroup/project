require("app.layer.MoneyLayer")

AccomplishmentLayer = class("AccomplishmentLayer", function()
    return display.newLayer()
end)

function AccomplishmentLayer:ctor()
	self:init();
end

function AccomplishmentLayer:init()
end

function AccomplishmentLayer:showAcmpmt(name)
	self.img = display.newSprite(name)
	self.img:setAnchorPoint(ccp(0,0))
	self.img:setPosition(display.width / 3, display.height * 3 / 5)
	self.img:setScale(0.3)
	self:addChild(self.img)


	local action1 = CCScaleBy:create(0.5,1.7)
	local action2 = CCFadeOut:create(1)
	local ccarray = CCArray:create()
   	ccarray:addObject(action1)
   	ccarray:addObject(action2)

   	local SequenceAction = CCSequence:create(ccarray)

	transition.execute(self.img, SequenceAction, {
   		onComplete = function ()
   			self:removeChild(self.img)
   		end
   	})
end