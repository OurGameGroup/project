
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

require("app.game.GameDirector")


function MainScene:ctor()
    self:initControl()

    self.gameDirector = GameDirector.new()

    self.gameDirector:init(self)
    
    self:initUpdate()
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

function MainScene:onEnter()
    self.pause = false
end

function MainScene:update()
    if(self.gameDirector:GameOver())then
        audio.stopAllSounds()
        display.replaceScene(require("app.scenes.StartScene").new(), "fade", 2.0, display.COLOR_WHITE)
        self._scheduler.unscheduleGlobal(self.handle)
    end

    if (self.gameDirector.chapterLayer.goToNext == true) then
        audio.stopAllSounds()
        self.gameDirector:nextChapter(self.gameDirector.chapterLayer.curChapter, self.gameDirector.chapterLayer.killedNum)
        display.replaceScene(require("app.scenes.StartScene").new(), "fade", 2.0, display.COLOR_WHITE)
        self._scheduler.unscheduleGlobal(self.handle)
        self.gameDirector.chapterLayer:init()
    end

    self.gameDirector:update()
end

return MainScene
