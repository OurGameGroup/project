
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

startPoint = CCPoint(display.cx,display.cy)
endPoint = CCPoint(display.cx,display.cy)

gravity = CCPoint(0,-1)
speed = CCPoint(0,0)

shoot = false

function MainScene:ctor()
    local background = display.newSprite("background.jpg")
    :pos(display.cx,display.cy)
    :addTo(self)

    local layer = display.newLayer()
    layer:setTouchEnabled(true)
    layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, 
        function(event)
            return self:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
        end
        )
    layer:setTouchSwallowEnabled(false)
    self:addChild(layer)

    traceLayer = display.newLayer()
    traceNodeList = {}
    for i=1,10 do
        local traceNode = display.newSprite("tracenode.png")
        traceNode:scale(0.2)
        traceNode:addTo(traceLayer)
        table.insert(traceNodeList,traceNode)
    end
    self:addChild(traceLayer)
    traceLayer:setVisible(false)

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
    if shoot then
        local bulletPosition = bullet:getPositionInCCPoint()
        bulletPosition  = addCCPoint(bulletPosition, speed)
        bullet:setPosition(bulletPosition)
        speed = addCCPoint(speed, gravity)

        local distance = subCCPoint(bullet:getPositionInCCPoint(), enemy:getPositionInCCPoint())
        if (distance:getLengthSq() < 1000) then
            bullet:pos(30,display.cy)
            speed = CCPoint(0,0)
            shoot = false
            enemy:pos(display.cx,display.cy)        
        end
    end
    
    if(outOfScreen(bullet:getPositionInCCPoint(),10)) then
        bullet:pos(30,display.cy)
        speed = CCPoint(0,0)
        shoot = false
    end

    if(outOfScreen(enemy:getPositionInCCPoint(),10)) then
        enemy:pos(display.cx,display.cy)
    end

end



function MainScene:onTouch(name,x,y,prevX,prevY)
    -- print (name)
	if name == "began" then

		startPoint = CCPoint(x,y)
		--print ("startPiont",x,y)
	elseif name == "cancel" or name == "ended" then
        shoot = true
        traceLayer:setVisible(false)
		endPoint = CCPoint(x,y)		
		--print ("endPiont",x,y)
        speed = subCCPoint(startPoint,endPoint)
        --local speedLength = speed:getLength()
        speed = numberTimesCCPoint(40/display.width,speed)
	end

    if name == "began" or name == "moved" then
        local trace = {}
        local tracePoint = bullet:getPositionInCCPoint()

        endPoint = CCPoint(x,y)
        local tempSpeed = subCCPoint(startPoint,endPoint)
        tempSpeed = numberTimesCCPoint(40/display.width,tempSpeed)
        -- print("tempSpeed",tempSpeed.x,tempSpeed.y)
        while (tracePoint.y > 0) do
            tracePoint = addCCPoint(tracePoint,tempSpeed)
            table.insert(trace,tracePoint)
            tempSpeed = addCCPoint(tempSpeed,gravity)
        end

        traceLayer:setVisible(true)

        local count = 1
        count = 1
        -- print ("count",count)
        for i,tp in ipairs(trace) do
            if(i % 5 == 4)then
                traceNodeList[count]:setPosition(tp)
                count = count + 1
            end

            if(count > 10) then 
                break
            end
        end
        -- print ("count",count)
    end
    return true
end

function addCCPoint(point1,point2)
    return CCPoint(point1.x + point2.x,point1.y + point2.y)
end

function subCCPoint(point1,point2)
    return CCPoint(point1.x - point2.x,point1.y - point2.y)
end

function numberTimesCCPoint( number,point )
    return CCPoint(point.x * number,point.y * number)
end

function outOfScreen(point,range)
    if(range == nil) then
        range = 0
    end

    return not (point.x > 0 - range and point.y > 0 - range and point.x < display.width + range and point.y < display.height + range)
end

return MainScene
