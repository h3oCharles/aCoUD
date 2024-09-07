HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/circles.lua")
HedgewarsScriptLoad("/Scripts/turncounter.lua")

gearInside = false

function onGameStart()
	circle = AddCircle(LAND_WIDTH/2,LAND_HEIGHT/2,100,3,0xFF0000FF)
	GetCircleDebug(circle)
end

function onGameTick20()
		radius = GetCircleRadius(circle)
		gearInside = TestForGearInsideCircle(CurrentHedgehog,circle)
		TestForStateOfGearInsideCircle(CurrentHedgehog,circle)
		
		--[[
		ShowMission("GetDistFromGearToGear","debug",
		"gear" .. ": " .. tostring(g1X) .. "," ..tostring(g1Y) .. "|" ..
		"gear2" .. ": " .. tostring(g2X) .. "," .. tostring(g2Y) .. "|" ..
		"result" .. ": " .. tostring(result) .. "|" ..
		"radius^2" .. ": " .. tostring(radius^2) .. "|" ..
		"gearInside" .. ": " .. tostring(gearInside) .. "|" ..
		"currentState" .. ": " .. tostring(currentState) .. "|"
		,4,0)
		]]--
		
end

function onGearInsideCircle(gear,circle)
	if turnCounter ~= -1 then
		PlaySound(sndKnifeImpact)
		AddCaption("gear " .. gear .. " is inside circle " .. circle.visual, 0xFFFFFFFF, capgrpGameState)
	end
end

function onGearOutsideCircle(gear,circle)
	if turnCounter ~= -1 then
		PlaySound(sndLaserSight)
		AddCaption("gear " .. gear .. " is outside circle " .. circle.visual, 0xFFFFFFFF, capgrpGameState)
	end
end