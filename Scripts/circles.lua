function printDebug(message)
	WriteLnToConsole(message)
	WriteLnToChat(message)
end

temp = {}
test = {}
DebugGear = {}
DebugVisual = {}

function AddCircle(x,y,Radius,LineThickness,Color)
	temp.gear = AddGear(x, y, gtGenericFaller, gstNoGravity+gstInvisible, 0, 0, 2147483647)
	temp.visual = AddVisualGear(x, y, vgtCircle, Radius, true)
	SetVisualGearValues(temp.visual, x, y, nil, nil, 0, nil, nil, Radius, LineThickness, Color, nil)
	return temp
end

function DeleteCircle(gear)
	DeleteGear(gear.gear)
	DeleteVisualGear(gear.visual)
end

function GetCirclePosition(gear)
	x,y = GetGearPosition(gear.gear)
	return x,y
end

function GetCircleX(gear)
	x = GetGearX(gear.gear)
	return x
end

function GetCircleY(gear)
	y = GetGearY(gear.gear)
	return y
end

function SetCirclePosition(gear, x, y)
	SetGearPosition(gear.gear, x, y)
	SetVisualGearValues(gear.visual, x, y, nil, nil, nil, nil, nil, nil, nil, nil, nil)
end

function GetCircleColor(gear)
	local X, Y, dX, dY, Angle, Frame, FrameTicks, State, Timer, Tint, Scale = GetVisualGearValues(gear.visual)
	return Timer
end

function SetCircleColor(gear, color)
	SetVisualGearValues(gear.visual, nil, nil, nil, nil, nil, nil, nil, nil, nil, color, nil)
end

function GetCircleRadius(gear)
	local X, Y, dX, dY, Angle, Frame, FrameTicks, State, Timer, Tint, Scale = GetVisualGearValues(gear.visual)
	return FrameTicks
end

function SetCircleRadius(gear,radius)
	SetVisualGearValues(gear.visual, nil, nil, nil, nil, nil, nil, nil, radius, nil, nil, nil)
end

function SetCircleThickness(gear,thickness)
	SetVisualGearValues(gear.visual, nil, nil, nil, nil, nil, nil, nil, nil, thickness, nil, nil)
end

function GetCircleDebug(gear)
	DebugGear[1], DebugGear[2], DebugGear[3], DebugGear[4], DebugGear[5], DebugGear[6], DebugGear[7], DebugGear[8], DebugGear[9], DebugGear[10], DebugGear[11], DebugGear[12], DebugGear[13] = GetGearValues(gear.gear)
	
	DebugVisual[1], DebugVisual[2], DebugVisual[3], DebugVisual[4], DebugVisual[5], DebugVisual[6], DebugVisual[7], DebugVisual[8], DebugVisual[9], DebugVisual[10], DebugVisual[11] = GetVisualGearValues(gear.visual)
	
	return DebugGear[1], DebugGear[2], DebugGear[3], DebugGear[4], DebugGear[5], DebugGear[6], DebugGear[7], DebugGear[8], DebugGear[9], DebugGear[10], DebugGear[11], DebugGear[12], DebugGear[13], DebugVisual[1], DebugVisual[2], DebugVisual[3], DebugVisual[4], DebugVisual[5], DebugVisual[6], DebugVisual[7], DebugVisual[8], DebugVisual[9], DebugVisual[10], DebugVisual[11]
end

function GetDistFromGearToGear(gear1,gear2)
	g1X, g1Y = GetGearPosition(gear1)
	g2X, g2Y = GetGearPosition(gear2)
	if gear1 ~= nil and gear2 ~= nil then
		q = g1X - g2X
		w = g1Y - g2Y
		result = ((q*q) + (w*w))
		return result
	else return nil end
end

function TestForGearInsideCircle(testgear,testcircle)
	local testresult = GetDistFromGearToGear(testgear,testcircle.gear)
	local testradius = GetCircleRadius(testcircle)
	if testresult <= testradius^2 then return true else return false end
end

--add a function checking for state changes, which is what i have in island hoppers for toggling airmines