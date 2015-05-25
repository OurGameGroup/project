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