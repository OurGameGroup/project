GameDirector = class("GameDirector")

require("app.Layer.TraceLayer")
require("app.Layer.WeaponChooseLayer")
require("app.Tools.MyMath")
require("app.GameData")
require("app.object.Castle")
EnemyClass = require("app.object.Enemy")
BulletClass = require("app.object.Bullet")

function GameDirector:ctor()

end

function GameDirector:init(scene)
    self.scene = scene

    self:initBackground("background.png")

    self:initTower()

    self:initBulletLayer()

    self:initEnemyLayer()

    self:initTraceLayer()

    self:initWeaponChooseLayer()

    self:initData()
end


function GameDirector:initBackground(name)
	self.background = display.newSprite(name)
	self.background:pos(display.cx,display.cy)
    self.scene:addChild(self.background)
end

function GameDirector:initTower()
    self.castle = Castle.new()
    self.castle:init(CCPoint(100, 180))
    self.scene:addChild(self.castle)
end

function GameDirector:initBulletLayer()
    self.bulletList = {}
    self.bulletLayer = display.newNode()
    self.scene:addChild(self.bulletLayer)
end

function GameDirector:initEnemyLayer()
    self.enemyList = {}
    self.enemyLayer = display.newNode()
    self.scene:addChild(self.enemyLayer)
end

function GameDirector:initTraceLayer()
    self.traceLayer = TraceLayer.new()
    self.scene:addChild(self.traceLayer)
end

function GameDirector:initWeaponChooseLayer()
    self.weaponChooseLayer = WeaponChooseLayer.new()
    self.scene:addChild(self.weaponChooseLayer)
end

function GameDirector:initData()
    self.count = 0
	self.shoot = false

	self.speed = CCPoint(0,0)

	self.startPoint = CCPoint(display.cx,display.cy)
	self.endPoint = CCPoint(display.cx,display.cy)

    self.autoFireBulletSpeed1 = CCPoint(10,10)
    self.autoFireBulletSpeed2 = CCPoint(10,10)
    self.autoFireBulletType = 2
end

function GameDirector:update()
    self:createNewObject()
    self:updatePosition()
    self:checkHit()
    self:makeEffect()
end

function GameDirector:onTouch(name,x,y,prevX,prevY)
	if name == "began" then
        
		self.startPoint = CCPoint(x,y)

	elseif name == "cancel" or name == "ended" then
        
        self.traceLayer:setVisible(false)
		self.endPoint = CCPoint(x,y)		

        self.speed = getSpeedWithScale(self.startPoint, self.endPoint, GameData.defaultSpeedScale)
        self.shoot = true

	end

    if name == "began" or name == "moved" then

        self.endPoint = CCPoint(x,y)
        self:showTrace()
    
    end
    
    return true
end

function GameDirector:showTrace()
    local tracePoint = self.castle:getTowerTop()
    local tempSpeed = getSpeedWithScale(self.startPoint, self.endPoint, GameData.defaultSpeedScale)

    local trace = self.traceLayer:getTrace(tracePoint, tempSpeed, GameData.gravity)

    self.traceLayer:setVisible(true)

    self.traceLayer:showTrace(trace)
end

function GameDirector:GameOver()
    return self.castle.gameover
end

function GameDirector:createNewObject()
    if self.count == 50 or self.count == 100 then
        local enemy = EnemyClass.new()
        enemy:init(GameData.enemyBase)
        self.scene:addChild(enemy)
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

    if self.count == 100 then
        local bullet = BulletClass.new(self.autoFireBulletType)
        bullet:init(self.castle:getTowerTop(),tempSpeed)
        self.scene:addChild(bullet)
        table.insert(self.bulletList,bullet)
        self.count = 0
    end

    self.count = self.count + 1

    if self.shoot then

        local bullet = BulletClass.new(self.weaponChooseLayer.bulletType)
        bullet:init(self.castle:getTowerTop(),self.speed)
        self.scene:addChild(bullet)
        table.insert(self.bulletList,bullet)
        self.shoot = false

        if(self.weaponChooseLayer.bulletType == 1)then
            self.autoFireBulletSpeed1 = self.speed
        else
            self.autoFireBulletSpeed2 = self.speed
        end
    end
end

function GameDirector:updatePosition()
    for i,enemy in ipairs(self.enemyList) do
        enemy:update()
    end

    for i,bullet in ipairs(self.bulletList) do
        bullet:update()
    end
end

function GameDirector:checkHit()
    for i,bullet in ipairs(self.bulletList) do
        for j,enemy in ipairs(self.enemyList) do
            if(hitN2N(bullet, enemy)) then
                bullet.hit = true
                enemy.killed = true
            end
        end
    end

    for j,enemy in ipairs(self.enemyList) do
        enemy.underTower = self.castle:underTower(enemy:getPositionInCCPoint())
    end
end

function GameDirector:makeEffect()
    for i,bullet in ipairs(self.bulletList) do
        if(bullet.hit or outOfScreen(bullet:getPositionInCCPoint(),10))then
            self.scene:removeChild(bullet)
            table.remove(self.bulletList,i)
            i = i - 1
        end
    end

    for i,enemy in ipairs(self.enemyList) do
        if(enemy.underTower) then
            if(enemy.underTowerTime % GameData.fps == 0) then
                self.castle:damage()
            end
        end

        if(enemy.killed)then
            self.scene:removeChild(enemy)
            table.remove(self.enemyList,i)
            i = i - 1
        end
    end
end

return GameDirector