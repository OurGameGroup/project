WeaponChooseLayer = class("WeaponChooseLayer", function()
    return display.newLayer()
end)

require("app.GameData")
require("app.game.GamePause")

function WeaponChooseLayer:ctor()
	-- self.img = display.newSprite("WeaponChoose.png")
	-- self:addChild(self.img)
	-- self:pos(display.cx,display.cy)
  
  self:init({2,1,3,4})
  self.pause = false
  self.selectedButton = 1
  self.changeWeapon = false
  

  self.count0 = 0
  self.count1 = 0
end

function WeaponChooseLayer:init(chosenWeaponList)
  self.weaponList = {}
  for i,number in ipairs(chosenWeaponList) do
      local data = GameData.weapon[number]

      local weapon = cc.ui.UIPushButton.new({ normal = data.button.normal,pressed = data.button.pressed})
      :onButtonClicked(
        function ()
          self.changeWeapon = true
          self.selectedButton = i
          print("selectnumber",number)
        end
      )
      :pos(display.width/8*i, display.height/4*3)
      :scale(0.15)
      self:addChild(weapon)

      table.insert(self.weaponList, {weaponType = number,speed = data.speed})
  end

  self.ultimateButton = cc.ui.UIPushButton.new({ normal = "pause.png",pressed = "pausePushed.png",})
      :onButtonClicked(
        function ()
          if(self.count0 == 0)then
            print("click")
            self.count0 = 30
          end
        end
      )
      :pos(display.width/8*5, display.height/4*3)
      :scale(0.15)
  self:addChild(self.ultimateButton)

  self.pauseButton = cc.ui.UIPushButton.new({ normal = "pause.png",pressed = "pausePushed.png",})
      :onButtonClicked(
        function ()
          self:getParent().pause = true
          CCDirector:sharedDirector():getActionManager():pauseAllRunningActions()
          gamePause(self:getParent())
        end
      )
      :pos(display.width/8, display.height/8*7)
      :scale(0.15)
  self:addChild(self.pauseButton)


end

return WeaponChooseLayer