TraceLayer = class("TraceLayer", function()
    return display.newLayer()
end)

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

return TraceLayer