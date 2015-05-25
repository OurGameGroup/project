TraceLayer = class("TraceLayer", function()
    return display.newLayer()
end)

require("app.Tools.MyMath")

function TraceLayer:ctor()
    self.traceNodeList = {}
    for i=1,10 do
        local traceNode = display.newSprite("tracenode.png")
        traceNode:scale(0.2)
        traceNode:addTo(self)
        table.insert(self.traceNodeList,traceNode)
    end
    self:setVisible(false)
end

function TraceLayer:getTrace(startPoint,startSpeed,gravity)
	local trace = {}

	local tracePoint = deepCopyCCPoint(startPoint)
	local tempSpeed = deepCopyCCPoint(startSpeed)

	while (tracePoint.y > 0) do
        tracePoint = addCCPoint(tracePoint,tempSpeed)
        table.insert(trace,tracePoint)
        tempSpeed = addCCPoint(tempSpeed,GameData.gravity)
    end


	return trace
end

function TraceLayer:showTrace(trace)
	local count = 1

    for i,tp in ipairs(trace) do
        if(i % 5 == 4)then
            self.traceNodeList[count]:setPosition(tp)
            count = count + 1
        end

        if(count > 10) then 
            break
        end
    end
end

return TraceLayer