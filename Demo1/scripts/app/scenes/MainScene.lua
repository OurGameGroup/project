
-- local Shell = require("app/objects/Shell")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

ClassBullet = require("app/objects/Bullet")
ClassEnemy = require("app/objects/Enemy")
require("app/layer/BackgroundLayer")

frame = 60
counting = 0
hitrange = 100
xSecondsOneEnemy = 3
kill = 0
playSound= false

function MainScene:ctor()


  fun1()
  fun2()
  fun1()
  fun2()

  local layer2 = BackgroundLayer:new()

  audio.preloadMusic("dungeon.mp3")
  audio.playMusic("dungeon.mp3", true)
  audio.preloadSound("coin.mp3")
	local layer = display.newLayer()

	layer:setTouchEnabled(true)

  local callbackTouch = function(event)
      return self:onTouch(event.name, event.x, event.y, event.prevX, event.prevY)
  end

  layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, callbackTouch)
  layer:setTouchSwallowEnabled(false)

  -- 键盘事件(esc)
  layer:setKeypadEnabled(true)
  layer:addNodeEventListener(cc.KEYPAD_EVENT,handler(self,self.testKeypad))

  self:addChild(layer)

  self._imgBack = display.newSprite("back.jpg")
  self._imgBack:setAnchorPoint(ccp(0,0))

  self:addChild(self._imgBack)

  self.labelTTF = ui.newTTFLabelWithOutline({
    text  = "0",
    size  = 30,
    color = ccc3(255, 0, 0),
    align = ui.TEXT_ALIGN_RIGHT,
    x     = 30,
    y     = 30,
    outlineColor = ccc3(255, 255, 0)
    })
  self:addChild(self.labelTTF)


  self._scheduler = require("framework.scheduler")
	self._scheduler.scheduleGlobal(handler(self, self.update), 1/frame)


  self._listBullet = {} 
  self._listEnemy = {}

end



function MainScene:update()


  if(startSpeed <= 30) then
    startSpeed = startSpeed + 1
  end

  if (counting >= frame * xSecondsOneEnemy ) then 
    local position = randomVector(0, display.cy, display.width, display.height)
    local enemy = ClassEnemy.new()
    self:addChild(enemy)
    enemy:init(position.x,position.y)
    table.insert(self._listEnemy, enemy)

    counting = 0

  else
    counting = counting + 1
  end


  for i,bullet in ipairs(self._listBullet) do
    bullet:update()

    if (bullet:outOfScreen(100)) then
      table.remove(self._listBullet, i)
      i = i - 1
      self:removeChild(bullet)  
    end
  end

  for i,enemy in ipairs(self._listEnemy) do
    enemy:update()

    if(enemy:outOfScreen(100)) then
      table.remove(self._listEnemy,i)
      i = i - 1
      self:removeChild(enemy)
    end
  end

  for i,enemy in ipairs(self._listEnemy) do
    for j,bullet in ipairs(self._listBullet) do
        local bulletPointToEnemy = sub(enemy:getPositionInCCPoint(),bullet:getPositionInCCPoint())
        
        if(bulletPointToEnemy:getLengthSq() < hitrange*hitrange ) then
          table.remove(self._listEnemy,i)
          i = i - 1
          self:removeChild(enemy)

          table.remove(self._listBullet, j)
          j = j - 1
          self:removeChild(bullet)
          kill = kill + 1

          playSound = true

          break
        end


    end
  end

  self.labelTTF:setString(kill)
  if(playSound)then
    audio.playSound("coin.mp3",false)
    playSound = false
  end
end




TouchEventString = TouchEventString or {} --------鼠标事件名称
TouchEventString.began = "began"
TouchEventString.moved = "moved"
TouchEventString.ended = "ended"
TouchEventString.canceled = "canceled"

startSpeed = 0
function MainScene:onTouch(name,x,y,prevX,prevY)
  -- print(name)

  if name == TouchEventString.began then
    startSpeed = 0
  elseif ((name == TouchEventString.ended) or (name == TouchEventString.canceled)) then

    local bullet = ClassBullet.new()
    self:addChild(bullet)
    bullet:init(x,y,startSpeed)

    -- print(startSpeed)
    table.insert(self._listBullet, bullet)
  else
     
	end


	return true
end

playing = true
function MainScene:testKeypad(event)
    print("event.name:"..event.name,"event.key:"..event.key,audio.isMusicPlaying())
    if(playing) then
      audio.pauseMusic()
    else
      audio.resumeMusic()
    end

    playing = not playing
end 



local data = 100

function fun1()
  print(data)
  data = data +50
end

data = 200

local data = data
function fun2()
  print(data)
  data = data + 50
end
--data = 400


return MainScene
