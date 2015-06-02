
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

require("app.game.GameDirector")


function MainScene:ctor()

    self.gameDirector = GameDirector.new()
    self.gameDirector:init(self)

    self:initUpdate()
    self:initControl()

end

function MainScene:initUpdate()
    self._scheduler = require("framework.scheduler")
    self.handle = self._scheduler.scheduleGlobal(handler(self, self.update), 1/GameData.fps)
end

function MainScene:initControl()
    local layer = display.newLayer()
    layer:setTouchEnabled(true)
    layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
        function(event)
            return self.gameDirector:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
        end
        )
    layer:setTouchSwallowEnabled(false)
    self:addChild(layer)
end


count = 0

function MainScene:update()
    if(self.gameDirector:GameOver())then
        display.replaceScene(require("app.scenes.StartScene").new(), "fade", 2.0, display.COLOR_WHITE)
        self._scheduler.unscheduleGlobal(self.handle)
    end

    self.gameDirector:update()
end

return MainScene
