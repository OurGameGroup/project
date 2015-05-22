
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

require("app.layer.BackgroundLayer")

require("app.GameData")


function MainScene:ctor()

    self.backgroundLayer = BackgroundLayer.new()
    self:addChild(self.backgroundLayer)

    bullet = display.newSprite("bullet.png")
    :pos(30,display.cy)
    :scale(0.1)
    :addTo(self)

    enemy = display.newSprite("enemy.png")
    :pos(display.cx,display.cy)
    :scale(0.3)
    :addTo(self)

    self._scheduler = require("framework.scheduler")
    self._scheduler.scheduleGlobal(handler(self, self.update), 1/60)

end

function MainScene:update()
	enemy:setPositionX(enemy:getPositionX() - 1)
    if self.backgroundLayer.shoot then
        local bulletPosition = bullet:getPositionInCCPoint()
        bulletPosition  = addCCPoint(bulletPosition, self.backgroundLayer.speed)
        bullet:setPosition(bulletPosition)
        self.backgroundLayer.speed = addCCPoint(self.backgroundLayer.speed, GameData.gravity)

        local distance = subCCPoint(bullet:getPositionInCCPoint(), enemy:getPositionInCCPoint())
        if (distance:getLengthSq() < 1000) then
            bullet:pos(30,display.cy)
            self.backgroundLayer.speed = CCPoint(0,0)
            self.backgroundLayer.shoot = false
            enemy:pos(display.cx,display.cy)        
        end
    end
    
    if(outOfScreen(bullet:getPositionInCCPoint(),10)) then
        bullet:pos(30,display.cy)
        self.backgroundLayer.speed = CCPoint(0,0)
        self.backgroundLayer.shoot = false
    end

    if(outOfScreen(enemy:getPositionInCCPoint(),10)) then
        enemy:pos(display.cx,display.cy)
    end

end

return MainScene
