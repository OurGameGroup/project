
function add(vector1,vector2)
	return CCPoint(vector1.x + vector2.x, vector1.y + vector2.y)
end

function sub(vector1,vector2)
	return  CCPoint(vector1.x - vector2.x, vector1.y - vector2.y)
end

seeded = false

function randomVector(startx,starty,endx,endy)
	if(not seeded) then
		math.randomseed(os.time())
		seeded = true
	end

	local positionx = math.random(startx,endx)
	local positiony = math.random(starty,endy)

	return CCPoint(positionx,positiony)
end



