local TraceLayer = class("TracLayer", function()
    return display.newLayer()
end)

function TraceLayer:ctor()
    self.traceNodeList = {}
    for i=1,10 do
        local traceNode = display.newSprite("tracenode.png")
        traceNode:scale(0.2)
        traceNode:addTo(traceLayer)
        table.insert(self.traceNodeList,traceNode)
    end
    traceLayer:setVisible(false)
end