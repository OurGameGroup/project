WeaponChooseLayer = class("WeaponChooseLayer", function()
    return display.newLayer()
end)

function WeaponChooseLayer:ctor()
	-- self.img = display.newSprite("WeaponChoose.png")
	-- self:addChild(self.img)
	-- self:pos(display.cx,display.cy)
  self:init()
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

end

return WeaponChooseLayer