UltimateSkillLayer = class("UltimateSkillLayer", function()
    return display.newLayer()
end)

require("app.Tools.MyMath")
WeaponClass = require("app.object.Weapon")

function UltimateSkillLayer:ctor()
	self.count = 0
end

function UltimateSkillLayer:showSkill(name,scene,list,times)
	if(self.count == 0 )then
		if (name == "meteorShower")then
			local pos = CCPoint(randomNumber(0,display.width/4*3),randomNumber(display.height/8*7, display.height))
			local weapon = WeaponClass.new(1)
			weapon:scale(randomNumber(0.5, 2))
			scene:addChild(weapon)
			weapon:init(pos,CCPoint(10, -10))
			weapon.gravityEnable = false
			
			table.insert(list, weapon)
		end
		self.count = randomNumber(0, 30)
		return times - 1
	else
		self.count = self.count - 1
		return times
	end
end


return UltimateSkillLayer