HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/circles.lua")

function onGameStart()
	ExampleCircle = AddCircle(LAND_WIDTH/2,0,100,3,0xFF0000FF)
	Color = GetCircleColor(ExampleCircle)
	printDebug(Color)
	if Color == 4278190335 then printDebug("It's working.") end
end