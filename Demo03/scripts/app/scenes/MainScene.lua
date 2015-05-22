
require("app.GameData")
ClassUnit = require("app.Game.Unit")


local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self:initControl()
    self:initBack()
    -- self:initUpdate()

    ------------------预加载动画资源
    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("unit/unit1.png","unit/unit1.plist","unit/unit1.xml")


    self._unit1 = ClassUnit.new()
    self._unit1:init("Skeletons",400,100)-------根据角色名创建动画
    self:addChild(self._unit1)

end

function MainScene:initControl()
    local layer = display.newLayer()
    layer:setTouchEnabled(true)
    layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
        function(event)
            return self:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
        end
        )
    layer:setTouchSwallowEnabled(false)
    self:addChild(layer)
end

function MainScene:initBack()
    local imgBack = display.newSprite("back.jpg")
    imgBack:setAnchorPoint(ccp(0,0))
    self:addChild(imgBack)    
end

-- function MainScene:initUpdate()
--     self._scheduler = require("framework.scheduler")
--     self._scheduler.scheduleGlobal(handler(self, self.update), 1/GameData.fps)
-- end


-- function MainScene:update()
-- end

tempState = 1
function MainScene:onTouch(name,x,y,prevX,prevY)
    if name == TouchEventString.began then
        tempState = tempState + 1
        if tempState > State.dead then
            tempState = 1
        end
        self._unit1:setState(tempState)
    end
	return true
end



return MainScene
