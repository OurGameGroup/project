WeaponChooseLayer = class("WeaponChooseLayer", function()
    return display.newLayer()
end)

function WeaponChooseLayer:ctor()
	-- self.img = display.newSprite("WeaponChoose.png")
	-- self:addChild(self.img)
	-- self:pos(display.cx,display.cy)
  self:init()
  self.pause = false
  self.bulletType = 1
  self.changeBulletType = false
end

function WeaponChooseLayer:init()
	self.weaponOne = cc.ui.UIPushButton.new({ normal = "fire.png",pressed = "firePushed.png",})
   		:onButtonClicked(
   			function ()
   				self.changeBulletType = true
          self.bulletType = 1
   			end
   		)
   		:pos(display.width/8, display.height/4*3)
      :scale(0.15)
  self:addChild(self.weaponOne)

  self.weaponTwo = cc.ui.UIPushButton.new({ normal = "freeze.png",pressed = "freezePushed.png",})
      :onButtonClicked(
        function ()
          self.changeBulletType = true
          self.bulletType = 2
        end
      )
      :pos(display.width/8*2, display.height/4*3)
      :scale(0.15)
  self:addChild(self.weaponTwo)

  self.pauseButton = cc.ui.UIPushButton.new({ normal = "pause.png",pressed = "pausePushed.png",})
      :onButtonClicked(
        function ()
          self.pause = not self.pause
          if(self.pause) then
            self.pauseButton:setButtonImage("normal", "play.png", true)
            self.pauseButton:setButtonImage("pressed","playPushed.png",true)
          else
            self.pauseButton:setButtonImage("normal", "pause.png", true)
            self.pauseButton:setButtonImage("pressed","pausePushed.png",true)
          end
        end
      )
      :pos(display.width/8, display.height/8*7)
      :scale(0.15)
  self:addChild(self.pauseButton)
end

return WeaponChooseLayer