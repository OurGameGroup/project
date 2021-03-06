function addCCPoint(point1,point2)
    return CCPoint(point1.x + point2.x,point1.y + point2.y)
end

function subCCPoint(point1,point2)
    return CCPoint(point1.x - point2.x,point1.y - point2.y)
end

function numberTimesCCPoint( number,point )
    return CCPoint(point.x * number,point.y * number)
end

function outOfScreen(point,range)
    if(range == nil) then
        range = 0
    end

    return not (point.x > 0 - range and point.y > 0 - range and point.x < display.width + range and point.y < display.height + range)
end

function deepCopyCCPoint(point)
	return CCPoint(point.x, point.y)
end

function getSpeedWithScale(startPoint,endPoint,scale)
	return numberTimesCCPoint(scale,subCCPoint(startPoint,endPoint))
end

function hitN2N(ccnode1,ccnode2)
	rect1 = ccnode1:getCascadeBoundingBox()
	rect2 = ccnode2:getCascadeBoundingBox()
    return rect1:intersectsRect(rect2)
end

math.randomseed(os.time())
function randomNumber(x,y)
    return math.random(x,y)
end