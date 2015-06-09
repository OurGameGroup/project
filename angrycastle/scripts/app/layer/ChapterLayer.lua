ChapterLayer = class("ChapterLayer", function()
    return display.newLayer()
end)

function ChapterLayer:ctor()
	self.curChapter = 1
	self.killedNum = 0
	self.goToNext = false
end

function ChapterLayer:init()
	self.goToNext = false
end

function ChapterLayer:addKilledNum()
	self.killedNum = self.killedNum + 1
end

function ChapterLayer:goToChapter(curChapt, killednum)
	for i,chapter in ipairs(GameData.nextChapterNum) do
		if curChapt == chapter.chapterNum and self.killedNum >= chapter.killRequired then
			print("GoTo ",(curChapt + 1)," chapter")
			self.killedNum = 0
			self.curChapter = self.curChapter + 1
			self.goToNext = true
		end
	end
end

return ChapterLayer