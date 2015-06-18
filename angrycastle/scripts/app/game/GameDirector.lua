GameDirector = class("GameDirector")

require("app.layer.TraceLayer")
require("app.layer.WeaponChooseLayer")
require("app.layer.MoneyLayer")
require("app.layer.AccomplishmentLayer")
require("app.layer.UltimateSkillLayer")
require("app.Tools.MyMath")
require("app.GameData")
require("app.object.Castle")
require("app.object.Ground")

WeaponClass = require("app.object.Weapon")

require("app.layer.ChapterLayer")

EnemyClass = require("app.object.Enemy")


function GameDirector:ctor()
   
end

function GameDirector:init(scene)
    self.scene = scene

    self:initBackground("background.jpg")

    self:initTower()

    self:initGround()

    self:initSoldier()

    self:initWeaponLayer()

    self:initEnemyLayer()

    self:initTraceLayer()

    self:initWeaponChooseLayer()

    self:initData()

    self:initMoneyLayer()

    self:initAccomplishmentLayer()

    self:initChapterLayer()

    self:initUltimateSkillLayer()
end

function GameDirector:initMusic()
    audio.preloadMusic("dungeon.mp3")
    audio.playMusic("dungeon.mp3", true)
end

function GameDirector:initBackground(name)
	self.background = display.newSprite(name)
	self.background:pos(display.cx,display.cy)
    self.scene:addChild(self.background)
end

function GameDirector:initGround()
    self.ground = Ground.new()
    self.ground:init(CCPoint(display.cx,100))
    self.scene:addChild(self.ground)
end

function GameDirector:initTower()
    self.castle = Castle.new()
    self.castle:init(CCPoint(120, 100))
    self.scene:addChild(self.castle)
end

function GameDirector:initSoldier()
    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("Player/Player.ExportJson")
    self.soldier = CCArmature:create("Player")
    self.soldier:scale(0.2)
    self.soldier:getAnimation():setSpeedScale(0.5)
    self.soldier:pos(self.castle:getTowerTop().x,self.castle:getTowerTop().y - 40)
    self.scene:addChild(self.soldier)
    self.soldier:getAnimation():play("magic",-1,-1)
end

function GameDirector:initWeaponLayer()
    self.weaponList = {}
    self.weaponLayer = display.newNode()
    self.scene:addChild(self.weaponLayer)
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

function GameDirector:initMoneyLayer()
    self.moneyLayer = MoneyLayer.new()
    self.scene:addChild(self.moneyLayer)
end

function GameDirector:initAccomplishmentLayer()
    self.accomplishmentLayer = AccomplishmentLayer.new()
    self.scene:addChild(self.accomplishmentLayer)
end

function GameDirector:initChapterLayer()
    self.chapterLayer = ChapterLayer.new()
    self.scene:addChild(self.chapterLayer)
end

function GameDirector:initUltimateSkillLayer()
    self.ultimateSkillLayer = UltimateSkillLayer:new()
    self.scene:addChild(self.ultimateSkillLayer)
end

function GameDirector:initData()
    self.count = 0
	self.shoot = false

	self.speed = CCPoint(0,0)

	self.startPoint = CCPoint(display.cx,display.cy)
	self.endPoint = CCPoint(display.cx,display.cy)
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
    return (self.castle.hp < 0)
end

function GameDirector:nextChapter(curChapt, killednum)
    self.chapterLayer:goToChapter(curChapt, killednum)
end

function GameDirector:createNewObject()
    if(self.weaponChooseLayer.count0  > 0)then
        if(self.weaponChooseLayer.count1 == 0)then
            self.ultimateSkillLayer:showSkill("meteorShower", self.scene,self.weaponList)
            self.weaponChooseLayer.count1 = randomNumber(1, 30)
            self.weaponChooseLayer.count0 = self.weaponChooseLayer.count0 - 1
        end
        self.weaponChooseLayer.count1 = self.weaponChooseLayer.count1 - 1
    end

    if self.count == 100 or self.count == 200 then
        local enemy = EnemyClass.new()
        enemy:init(GameData.enemyBase)
        self.scene:addChild(enemy)
        table.insert(self.enemyList,enemy)
    end

    if self.count == 200 then

        for i,autoFireType in ipairs(self.weaponChooseLayer.weaponList) do
            if(i ~= self.weaponChooseLayer.selectedButton)then    
                local weapon = WeaponClass.new(autoFireType.weaponType)

                weapon:init(self.castle:getTowerTop(),autoFireType.speed)
                self.scene:addChild(weapon)

                table.insert(self.weaponList,weapon)
            end
        end
        
        self.count = 0
    end

    self.count = self.count + 1

    if self.shoot then
        self.soldier:getAnimation():play("magic",-1,-1)

        local weapon = WeaponClass.new(self.weaponChooseLayer.weaponList[self.weaponChooseLayer.selectedButton].weaponType)

        weapon:init(self.castle:getTowerTop(),self.speed)
        self.scene:addChild(weapon)
        table.insert(self.weaponList,weapon)
        self.shoot = false

        self.weaponChooseLayer.weaponList[self.weaponChooseLayer.selectedButton].speed = self.speed
    end
end

function GameDirector:updatePosition()
    for i,enemy in ipairs(self.enemyList) do
        enemy:updatePosition()
    end

    for i,weapon in ipairs(self.weaponList) do
        weapon:updatePosition()
    end
end

function GameDirector:checkHit()
    for i,weapon in ipairs(self.weaponList) do
        if(not weapon.doNotHitEnemy)then
            weapon:hitTo(self.enemyList)
        end
    end

    for i,weapon in ipairs(self.weaponList) do
        if(weapon:hitGround(self.ground)) then
            weapon.hit = true
        end
    end

    for j,enemy in ipairs(self.enemyList) do
        enemy.underTower = hitN2N(enemy, self.castle)
        self.ground:giveEffect(enemy)
    end
end

function GameDirector:makeEffect()
    for i,weapon in ipairs(self.weaponList) do
        if(weapon.hit or outOfScreen(weapon:getPositionInCCPoint(),10))then
            self.scene:removeChild(weapon)
            table.remove(self.weaponList,i)
            i = i - 1
        end
    end

    for i,enemy in ipairs(self.enemyList) do
        enemy:updateByStatus()

        if(enemy.underTower) then
            enemy:setState("stand")
            if(enemy.underTowerTime % (GameData.fps * 2) == 0) then
                enemy:setState("attack")
                self.castle:damage()
            end
        end

        if(enemy.hp < 0)then
            self.chapterLayer:addKilledNum()
            print(self.chapterLayer.killedNum)
            self.moneyLayer:addMoney()
            self.scene:removeChild(enemy)
            table.remove(self.enemyList,i)
            self:nextChapter(self.chapterLayer.curChapter, self.chapterLayer.killedNum)
            i = i - 1
        end
    end

    for i,acmpmt in ipairs(GameData.accomplishment) do
        if(not acmpmt.get and self.moneyLayer.money >= acmpmt.requireMoney) then
            self.accomplishmentLayer:showAcmpmt(acmpmt.img)
            acmpmt.get = true
        end
    end

    self.ground:update()
end

return GameDirector