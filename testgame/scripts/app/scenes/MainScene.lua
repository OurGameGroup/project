
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
   	display.newSprite("Image/background.jpg")
   	:pos(display.cx, display.cy)
   	:addTo(self);

   	local title = display.newSprite("Image/ico.png")
   		:pos(display.width/4, display.cy)
   		:addTo(self)

   	local move1 = CCMoveBy:create(0.5, CCPoint(0, 10))
   	local move2 = CCMoveBy:create(0.5, CCPoint(0, -10))

   	local ccarray = CCArray:create()
   	ccarray:addObject(move1)
   	ccarray:addObject(move2)
   	
   	local SequenceAction = CCSequence:create(ccarray)
   	transition.execute(title,cc.RepeatForever:create(SequenceAction))


   	cc.ui.UIPushButton.new({ normal = "Image/start1.jpg",pressed = "Image/start2.jpg",})
   		:onButtonClicked(function ()
   			print("start")
   		end)
   		:pos(display.width/4*3, display.cy)
   		:addTo(self)


      local title2 = display.newSprite("Walk0001.png")
         :pos(display.width/4*3, display.cy)
         :addTo(self)

      display.addSpriteFramesWithFile("Walk.plist", "Walk.png")

      local frames = display.newFrames("Walk%04d.png", 1, 4)
      local animation = display.newAnimation(frames,0.5/4)

      title2:playAnimationForever(animation)

      -- transition.transition.playAnimationForever(title2, animation)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
