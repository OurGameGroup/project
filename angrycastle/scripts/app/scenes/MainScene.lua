
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

require("app.layer.BackgroundLayer")

require("app.GameData")

require("app.object.Castle")

require("app.layer.WeaponChooseLayer")

BulletClass = require("app.object.Bullet")
EnemyClass = require("app.object.Enemy")

function MainScene:ctor()

    self.backgroundLayer = BackgroundLayer.new()
    self:addChild(self.backgroundLayer)
    
    self.weaponChooseLayer = WeaponChooseLayer.new()
    self:addChild(self.weaponChooseLayer)

    self.enemyList = {}
    self.bulletList = {}

    self.autoFireBulletSpeed1 = CCPoint(10,10)
    self.autoFireBulletSpeed2 = CCPoint(10,10)
    self.autoFireBulletType = 2

    self._scheduler = require("framework.scheduler")
    self.handle = self._scheduler.scheduleGlobal(handler(self, self.update), 1/GameData.fps)

end

count = 0

function MainScene:update()
    if(self:GameOver())then
        display.replaceScene(require("app.scenes.StartScene").new(), "fade", 2.0, display.COLOR_WHITE)
        self._scheduler.unscheduleGlobal(self.handle)
 
    else

    if count == 50 or count == 100 then
        local enemy = EnemyClass.new()
        enemy:init(GameData.enemyBase)
        self:addChild(enemy)
        table.insert(self.enemyList,enemy)
    end

    local tempSpeed

    if(self.weaponChooseLayer.bulletType == 1)then
        tempSpeed = self.autoFireBulletSpeed2
    else
        tempSpeed = self.autoFireBulletSpeed1
    end

    if(self.weaponChooseLayer.bulletType == self.autoFireBulletType)then
        self.autoFireBulletType = 3 - self.weaponChooseLayer.bulletType
    end

    if count == 100 then
        local bullet = BulletClass.new(self.autoFireBulletType)
        bullet:init(self.backgroundLayer.castle:getTowerTop(),tempSpeed)
        self:addChild(bullet)
        table.insert(self.bulletList,bullet)
        count = 0
    end


    count = count + 1

    

    for i,enemy in ipairs(self.enemyList) do
        enemy:update()

        if(self.backgroundLayer.castle:underTower(enemy:getPositionInCCPoint())) then
            enemy.speed = CCPoint(0, 0)
            enemy.underTowerTime = enemy.underTowerTime + 1
            
            if(enemy.underTowerTime % GameData.fps == 0) then
                self.backgroundLayer.castle:damage()
            end
        end
    end

    if self.backgroundLayer.shoot then

        local bullet = BulletClass.new(self.weaponChooseLayer.bulletType)
        bullet:init(self.backgroundLayer.castle:getTowerTop(),self.backgroundLayer.speed)
        self:addChild(bullet)
        table.insert(self.bulletList,bullet)
        self.backgroundLayer.shoot = false

        if(self.weaponChooseLayer.bulletType == 1)then
            self.autoFireBulletSpeed1 = self.backgroundLayer.speed
        else
            self.autoFireBulletSpeed2 = self.backgroundLayer.speed
        end
    end

    for i,bullet in ipairs(self.bulletList) do

        bullet:update()

        if(outOfScreen(bullet:getPositionInCCPoint(),10)) then
            self:removeChild(bullet)
            table.remove(self.bulletList,i)
            i = i - 1

        else

            for j,enemy in ipairs(self.enemyList) do
                local distance = subCCPoint(bullet:getPositionInCCPoint(), enemy:getPositionInCCPoint())
                if (distance:getLengthSq() < 1000) then

                    self.backgroundLayer.speed = CCPoint(0,0)
                    self.backgroundLayer.shoot = false
                
                    self:removeChild(enemy)
                    table.remove(self.enemyList,j)

                    self:removeChild(bullet)
                    table.remove(self.bulletList,i)
                    i = i - 1

                    break
                end
            end
        end
    end
    
    end
end

function MainScene:GameOver()
    return self.backgroundLayer.castle.gameover
end

return MainScene
