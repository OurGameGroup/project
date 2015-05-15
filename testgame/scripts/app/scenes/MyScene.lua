
local MyScene = class("MyScene", function ()
	return display.newScene("myscene")
end)

function MyScene:ctor()
	--display.newSprite("background.png", display.cx, display.cy):addTo(self)
	
	--ui.newTTFLabel({text = "Hello, world", align = ui.TEXT_ALIGN_CENTER, x = display.cx, y = display.height*0.9}):addTo(self)

	local sp1 = display.newSprite("ico.png", display.width/4, display.cy)
	self:addChild(sp1)

	--不明原因的错误。。
	--local frame =  display.newSpriteFrame("ico.png")
	--local sp3 = display.newSprite(frame,display.width/4*3,display.cy)
	--self:addChild(sp3)
	
	--[[没有.fnt文件。。哎。。
	local labelBMFont = ui.newBMFontLabel({
		text  = "BMFont",
		--font  = "futura-48.fnt",
		align = ui.TEXT_ALIGN_CENTER,
		x     = display.cx,
		y     = display.cy
		})
	]]

	--有描边的文字
	local labelTTF = ui.newTTFLabelWithOutline({
		text  = "labelTTF",
		size  = 30,
		color = ccc3(255, 0, 0),
		align = ui.TEXT_ALIGN_RIGHT,
		x     = display.cx,
		y     = display.cy,
		outlineColor = ccc3(255, 255, 0)
		})
	self:addChild(labelTTF)

	local function onClicked(tag)
		if tag == 1 then
			print("item1 clicked")
		elseif tag == 2 then
			print("item2 clicked")
		else
			print ("error")
		end
	end

	local item1 = ui.newImageMenuItem({
		image = "ico.png",
		imageSelected = "background.png",
		listener = function ()
			print("item clicked")
		end,
		x = display.cx,
		y = display.cy,
		tag = 1
		})
	
	local menu = ui.newMenu({item1})
	self:addChild(menu)

	

end

return MyScene