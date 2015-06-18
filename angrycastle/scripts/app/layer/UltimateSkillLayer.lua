UltimateSkillLayer = class("UltimateSkillLayer", function()
    return display.newLayer()
end)

require("app.Tools.MyMath")
WeaponClass = require("app.object.Weapon")

function UltimateSkillLayer:ctor()
	
end

function UltimateSkillLayer:showSkill(name,scene,list)
	if (name == "meteorShower")then
		local pos = CCPoint(randomNumber(0,display.width/4*3),randomNumber(display.height/8*7, display.height))
		local weapon = WeaponClass.new(1)
		weapon:scale(randomNumber(0.5, 2))
		scene:addChild(weapon)
		weapon:init(pos,CCPoint(10, -10))
		weapon.gravityEnable = false
			
		table.insert(list, weapon)
	end
end


return UltimateSkillLayer