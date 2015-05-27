
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
   	local back = display.newSprite("Image/background.jpg")
   	:pos(display.cx, display.cy)
    :scale(0.666)
   	:addTo(self);



   	title = display.newSprite("Castle.png")
         -- :rotation(45)
         :scale(0.25)
   		:pos(display.width/4, display.cy)
   		
      :addTo(self)
      print ("top",title:getBoundingBox():getMaxY())
   	-- local move1 = CCMoveBy:create(0.5, CCPoint(0, 10))
   	-- local move2 = CCMoveBy:create(0.5, CCPoint(0, -10))

   	-- local ccarray = CCArray:create()
   	-- ccarray:addObject(move1)
   	-- ccarray:addObject(move2)
   	
   	-- local SequenceAction = CCSequence:create(ccarray)
   	-- transition.execute(title,cc.RepeatForever:create(SequenceAction))


   	-- cc.ui.UIPushButton.new({ normal = "Image/start1.jpg",pressed = "Image/start2.jpg",})
   	-- 	:onButtonClicked(function ()
   	-- 		print("start")
   	-- 	end)
   	-- 	:pos(display.width/4*3, display.cy)
   	-- 	:addTo(self)


    --   local title2 = display.newSprite("Walk0001.png")
    --      :pos(display.width/4*3, display.cy)
    --      :addTo(self)

    --   display.addSpriteFramesWithFile("Walk.plist", "Walk.png")

    --   local frames = display.newFrames("Walk%04d.png", 1, 4)
    --   local animation = display.newAnimation(frames,0.5/4)

    --   title2:playAnimationForever(animation)

    --   -- transition.transition.playAnimationForever(title2, animation)
   local layer = display.newLayer()
   layer:setTouchEnabled(true)

   local callbackTouch = function(event)
      return self:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
   end

   layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, callbackTouch)
   layer:setTouchSwallowEnabled(false)

   self:addChild(layer)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:onTouch(name,x,y,prevX,prevY)
   print(name)
   print (x,y)
   if(title:getBoundingBox():containsPoint(CCPoint(x, y))) then
      print "OK"
   end

   return true
end

return MainScene
