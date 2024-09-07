HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/circles.lua")
HedgewarsScriptLoad("/Scripts/turncounter.lua")
HedgewarsScriptLoad("/Scripts/finish.lua")

function onGameStart()
	flawlessCircle	= AddCircle(LAND_WIDTH/4,0,100,3,0xFF0000FF)
	victoryCircle	= AddCircle(LAND_WIDTH/2,0,100,3,0x00FF00FF)
	failCircle		= AddCircle(LAND_WIDTH*0.75,0,100,3,0x0000FFFF)
end

function onGameTick20()
	triggerFlawless	= TestForGearInsideCircle(CurrentHedgehog,flawlessCircle)
	TestForStateOfGearInsideCircle(CurrentHedgehog,flawlessCircle)
	
	triggerVictory	= TestForGearInsideCircle(CurrentHedgehog,victoryCircle)
	TestForStateOfGearInsideCircle(CurrentHedgehog,victoryCircle)
	
	triggerFail		= TestForGearInsideCircle(CurrentHedgehog,failCircle)
	TestForStateOfGearInsideCircle(CurrentHedgehog,failCircle)

		ShowMission("!finish","debug",
		"triggerFlawless" .. ": " .. tostring(triggerFlawless) .. "|" ..
		"triggerVictory" .. ": " .. tostring(triggerVictory) .. "|" ..
		"triggerFail" .. ": " .. tostring(triggerFail) .. "|" ..
		"currentState" .. ": " .. tostring(currentState) .. "|"
		,4,0)
end

function onGearInsideCircle(testgear,testcircle)
	printDebug("gear" .. ": " .. tostring(testgear))
	printDebug("circle" .. ": " .. tostring(testcircle))
	printDebug("flawlessCircle" .. ": " .. tostring(flawlessCircle))
	printDebug("victoryCircle" .. ": " .. tostring(victoryCircle))
	printDebug("failCircle" .. ": " .. tostring(failCircle))
	if		testcircle == flawlessCircle then
		printDebug("flawless circle")
		ConcludeGame(true,false,true)
	elseif	testcircle == victoryCircle then
		printDebug("victory circle")
		ConcludeGame(true,false,false)
	elseif	testcircle == failCircle then
		printDebug("fail circle")
		ConcludeGame(false,false,false)
	end
end