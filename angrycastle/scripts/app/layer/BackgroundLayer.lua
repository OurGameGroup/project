BackgroundLayer = class("BackgroundLayer", function()
    return display.newLayer()
end)

require("app.Layer.TraceLayer")
require("app.Tools.MyMath")
require("app.GameData")

function BackgroundLayer:ctor()
	self:initBackground("background.jpg")

	self:initTraceLayer()

    self:initControl()

    self:initData()
end

function BackgroundLayer:initBackground(name)
	self.background = display.newSprite(name)
	self.background:pos(display.cx,display.cy)
    self:addChild(self.background)
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
    -- print ("new wanle")
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

        self.speed = subCCPoint(self.startPoint,self.endPoint)

        self.speed = numberTimesCCPoint(40/display.width,self.speed)
	end

    if name == "began" or name == "moved" then
        local trace = {}
        local tracePoint = bullet:getPositionInCCPoint()

        self.endPoint = CCPoint(x,y)
        local tempSpeed = subCCPoint(self.startPoint,self.endPoint)
        tempSpeed = numberTimesCCPoint(40/display.width,tempSpeed)

        local trace = self.traceLayer:getTrace(tracePoint, tempSpeed, GameData.gravity)

        self.traceLayer:setVisible(true)

        self.traceLayer:showTrace(trace)


    end
    return true
end

return BackgroundLayer