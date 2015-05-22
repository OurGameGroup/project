local BackgroundLayer = class("BackgroundLayer", function()
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
    self.traceLayer = TraceLayer:new()
    self.addChild(self.traceLayer)
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
        local tempSpeed = subCCPoint(startPoint,self.endPoint)
        tempSpeed = numberTimesCCPoint(40/display.width,tempSpeed)

        while (tracePoint.y > 0) do
            tracePoint = addCCPoint(tracePoint,tempSpeed)
            table.insert(trace,tracePoint)
            tempSpeed = addCCPoint(tempSpeed,GameData.gravity)
        end

        self.traceLayer:setVisible(true)

        local count = 1
        count = 1

        for i,tp in ipairs(trace) do
            if(i % 5 == 4)then
                traceNodeList[count]:setPosition(tp)
                count = count + 1
            end

            if(count > 10) then 
                break
            end
        end

    end
    return true
end