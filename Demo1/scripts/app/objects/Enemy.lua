local Enemy = class("Enemy", function()
    return display.newNode()
end)

enemySpeed = 5

require("app/tools/Vector")

function Enemy:ctor()
	self._imgBullet = display.newSprite("enemy.png")
	self._imgBullet:scale(0.5)
	self:addChild(self._imgBullet)

	self.speed = CCPoint(0,0)

	self.inited = false
end

function Enemy:init(x,y)
	self:pos(x, y)

end

return Enemy