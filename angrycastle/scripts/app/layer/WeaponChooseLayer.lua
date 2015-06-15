WeaponChooseLayer = class("WeaponChooseLayer", function()
    return display.newLayer()
end)

require("app.GameData")

function WeaponChooseLayer:ctor()
	-- self.img = display.newSprite("WeaponChoose.png")
	-- self:addChild(self.img)
	-- self:pos(display.cx,display.cy)
  
  self:init({1,2,3,4})
  self.pause = false
  self.selectedButton = 1
  self.changeWeapon = false
  
end

function WeaponChooseLayer:init(chosenWeaponList)
  self.weaponList = {}
  for i,number in ipairs(chosenWeaponList) do
      local data = GameData.weapon[number]

      local weapon = cc.ui.UIPushButton.new({ normal = data.button.normal,pressed = data.button.pressed})
      :onButtonClicked(
        function ()
          self.changeWeapon = true
          self.selectedButton = number
          print("selectnumber",number)
        end
      )
      :pos(display.width/8*i, display.height/4*3)
      :scale(0.15)
      self:addChild(weapon)

      table.insert(self.weaponList, {weaponType = number,speed = data.speed})
  end

  self.pauseButton = cc.ui.UIPushButton.new({ normal = "pause.png",pressed = "pausePushed.png",})
      :onButtonClicked(
        function ()
          self.pause = not self.pause
          if(self.pause) then
            self.pauseButton:setButtonImage("normal", "play.png", true)
            self.pauseButton:setButtonImage("pressed","playPushed.png",true)
            display.pause()
          else
            self.pauseButton:setButtonImage("normal", "pause.png", true)
            self.pauseButton:setButtonImage("pressed","pausePushed.png",true)
            display.resume()
          end
        end
      )
      :pos(display.width/8, display.height/8*7)
      :scale(0.15)
  self:addChild(self.pauseButton)
end

return WeaponChooseLayer