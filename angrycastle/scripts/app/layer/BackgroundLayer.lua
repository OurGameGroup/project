BackgroundLayer = class("BackgroundLayer", function()
    return display.newLayer()
end)

require("app.Layer.TraceLayer")
require("app.Tools.MyMath")
require("app.GameData")
require("app.object.Castle")

BulletClass = require("app.object.Bullet")

function BackgroundLayer:ctor()
	self:initBackground("background.png")

    self:initTower()

	self:initTraceLayer()

    self:initControl()

    self:initData()
end

function BackgroundLayer:initBackground(name)
	self.background = display.newSprite(name)
	self.background:pos(display.cx,display.cy)
    self:addChild(self.background)
end

function BackgroundLayer:initTower()
    self.castle = Castle.new()
    self.castle:init(CCPoint(100, 180))
    self:addChild(self.castle)
end

function BackgroundLayer:initControl()
	self:setTouchEnabled(true)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
    	function(event)
            return self:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
        end
        )
    self:setTouchSwallowEnabled(false)
end

function BackgroundLayer:initTraceLayer()
    self.traceLayer = TraceLayer.new()

    self:addChild(self.traceLayer)
end

function BackgroundLayer:initData()
	self.shoot = false

	self.speed = CCPoint(0,0)

	self.startPoint = CCPoint(display.cx,display.cy)
	self.endPoint = CCPoint(display.cx,display.cy)
end

function BackgroundLayer:onTouch(name,x,y,prevX,prevY)

	if name == "began" then
        
		self.startPoint = CCPoint(x,y)

	elseif name == "cancel" or name == "ended" then
        self.shoot = true
        self.traceLayer:setVisible(false)
		self.endPoint = CCPoint(x,y)		

        self.speed =  getSpeedWithScale(self.startPoint, self.endPoint, GameData.defaultSpeedScale)

	end

    if name == "began" or name == "moved" then

        local tracePoint = self.castle:getTowerTop()

        self.endPoint = CCPoint(x,y)

        local tempSpeed = getSpeedWithScale(self.startPoint, self.endPoint, GameData.defaultSpeedScale)

        local trace = self.traceLayer:getTrace(tracePoint, tempSpeed, GameData.gravity)

        self.traceLayer:setVisible(true)

        self.traceLayer:showTrace(trace)


    end
    return true
end

return BackgroundLayer