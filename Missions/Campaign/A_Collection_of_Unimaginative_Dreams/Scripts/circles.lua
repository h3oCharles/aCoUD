DebugGear = {}
DebugVisual = {}

function onGearInsideCircle(testgear,testcircle) end
function onGearOutsideCircle(testgear,testcircle) end

tempCircleVar = {}

function AddCircle(x, y, Radius, LineThickness, Color)
	local circleData = {}
	circleData.gear = AddGear(x, y, gtGenericFaller, gstNoGravity+gstInvisible, 0, 0, 2147483647)
	circleData.visual = AddVisualGear(x, y, vgtCircle, Radius, true)
	SetVisualGearValues(circleData.visual, x, y, nil, nil, 0, nil, nil, Radius, LineThickness, Color, nil)
	table.insert(tempCircleVar, circleData)
	return circleData
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
	if g1X == nil then g1X = -2147483648 end
	if g1Y == nil then g1Y = -2147483648 end
	if g2X == nil then g2X = -2147483648 end
	if g2Y == nil then g2Y = -2147483648 end
	q = g1X - g2X
	w = g1Y - g2Y
	result = ((q*q) + (w*w))
	return result
end

function TestForGearInsideCircle(testgear,testcircle)
	if testgear == nil then return false end
	local testresult = GetDistFromGearToGear(testgear,testcircle.gear)
	local testradius = GetCircleRadius(testcircle)
	if testresult <= testradius^2 then return true else return false end
end

local gearStateTable = {}

function TestForStateOfGearInsideCircle(testgear, testcircle)
	if testgear == nil then return nil end
	if gearStateTable[testgear] == nil then
		gearStateTable[testgear] = {}
	end
	
	local previousState = gearStateTable[testgear][testcircle]
	local currentState = nil

	if TestForGearInsideCircle(testgear, testcircle) == true then
		currentState = "inTargetArea"
	else
		currentState = "outOfTargetArea"
	end

	if currentState ~= previousState then
		if currentState == "inTargetArea" then
			onGearInsideCircle(testgear, testcircle)
		elseif currentState == "outOfTargetArea" then
			onGearOutsideCircle(testgear, testcircle)
		end
	end

	gearStateTable[testgear][testcircle] = currentState
end