TraceLayer = class("TraceLayer", function()
    return display.newLayer()
end)

require("app.Tools.MyMath")

function TraceLayer:ctor()
    self.traceNodeList = {}
    for i=1,10 do
        local traceNode = display.newSprite("tracenode.png")
        traceNode:scale(0.2)
        traceNode:setVisible(false)
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
        tempSpeed = addCCPoint(tempSpeed,gravity)
    end


	return trace
end

function TraceLayer:showTrace(trace)

    for i,tn in ipairs(self.traceNodeList) do
        if(i * 5 - 4 < #trace)then
            tn:setPosition(trace[i * 5 - 4])
            tn:setVisible(true)
        else
        	tn:setVisible(false)
       	end
    end
end

return TraceLayer