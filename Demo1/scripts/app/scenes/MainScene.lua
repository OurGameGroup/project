
-- local Shell = require("app/objects/Shell")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

ClassBullet = require("app/objects/Bullet")
ClassEnemy = require("app/objects/Enemy")
require("app/layer/BackgroundLayer")


CCNode:create()

function MainScene:ctor()

	local layer = display.newLayer()

	layer:setTouchEnabled(true)

  local callbackTouch = function(event)
      return self:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
  end

  layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, callbackTouch)
  layer:setTouchSwallowEnabled(false)

  -- 键盘事件(esc)
  -- layer:setKeypadEnabled(true)
  -- layer:addNodeEventListener(cc.KEYPAD_EVENT,handler(self,self.testKeypad))

  self:addChild(layer)

  self._imgBack = display.newSprite("back.jpg")
  self._imgBack:setAnchorPoint(ccp(0,0))

  self:addChild(self._imgBack)


  self._scheduler = require("framework.scheduler")
	self._scheduler.scheduleGlobal(handler(self, self.update), 1/60)


    self._listBullet = {} 

end


function MainScene:update()
    for i,bullet in ipairs(self._listBullet) do
        bullet:update()

        if (bullet:outOfScreen(100)) then
          table.remove(self._listBullet, i)
          i = i - 1;
          self:removeChild(bullet)  
        end
    end   
end




TouchEventString = TouchEventString or {} --------鼠标事件名称
TouchEventString.began = "began"
TouchEventString.moved = "moved"
TouchEventString.ended = "ended"
TouchEventString.canceled = "canceled"


function MainScene:onTouch(name,x,y,prevX,prevY)
    
	if name == TouchEventString.began then

        local bullet = ClassBullet.new()
        self:addChild(bullet)
        bullet:init(x,y)
        

        table.insert(self._listBullet, bullet)

        local enemy = ClassEnemy.new()
        self:addChild(enemy)
        enemy:init(x,y)

	end	
	return true
end

function MainScene:testKeypad(event)
    print("event.name:"..event.name,"event.key:"..event.key)
    gravity = -gravity
end 

return MainScene
