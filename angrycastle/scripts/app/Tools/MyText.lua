local MyText = class("MyText", function()
	return display.newNode()
end)

function MyText:ctor(text)
	self.labelTTF = ui.newTTFLabel({
		text  = text,
		size  = 12,
		color = ccc3(255, 255, 255),
		align = ui.TEXT_ALIGN_CENTER,
		x     = 0,
		y     = 0,
		})
	self:addChild(self.labelTTF)
end

function MyText:setColor(color)
	if(color == "purple")then
		self.labelTTF:setColor(ccc3(132, 129, 221))
	elseif (color == "yellow") then
		self.labelTTF:setColor(ccc3(255, 255, 0))
	end
end
return MyText