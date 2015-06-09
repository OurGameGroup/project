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
	local img = display.newSprite(name)
	img:setAnchorPoint(ccp(0,0))
	img:setPosition(display.width / 3, display.height * 3 / 5)
	img:setScale(0.3)
	self:addChild(img)


	local action1 = CCScaleBy:create(0.5,1.7)
	local action2 = CCScaleBy:create(2,1)
	local action3 = CCFadeOut:create(1)
	local ccarray = CCArray:create()
   	ccarray:addObject(action1)
   	ccarray:addObject(action2)
   	ccarray:addObject(action3)

   	local SequenceAction = CCSequence:create(ccarray)

	transition.execute(img, SequenceAction, {
   		onComplete = function ()
   			self:removeChild(img)
   		end
   	})
end