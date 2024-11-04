HedgewarsScriptLoad("Scripts/Tracker.lua")

function printDebug(message)
	WriteLnToConsole(message)
	WriteLnToChat(message)
end

function onGameTick20()
runOnGears(planeInterface)
end

function planeInterface(gear)
	if GetGearType(gear) == gtRCPlane then
	
		--[[isDrowning = band(GetState(gear),gstDrowning) ~= 0
		if isDrowning == true then
			printDebug("plane is drowning at Y: " .. GetY(gear) .. ", fuel is " ..fuel)
		end
	
		ShowMission("planeInterface","debug",
		"Y" .. ": " .. tostring(GetY(gear)) .. "|" ..
		"WaterLine" .. ": " .. tostring(WaterLine) .. "|" ..
		"isDrowning" .. ": " .. tostring(isDrowning)
		,4,0)]]--

		if GetY(gear) <= WaterLine-8 then
			fuelRaw = GetTimer(gear)
			missiles = GetHealth(gear)
			fuel = div(fuelRaw*100, 15000)
			DisplayCaption = true
		else
			fuelRaw = 0
			missiles = 0
			fuel = 0
			--DisplayCaption = false
		end
		
		if missiles ~= 0 or fuel ~= 0 then
			AddCaption("Fuel: ".. fuel .. "% | Missiles: ".. missiles,capcolDefault,capgrpMessage)
		elseif missiles == 0 and fuel == 0 and DisplayCaption == true then
			AddCaption("Fuel: ".. "0" .. "% | Missiles: ".. "0",capcolDefault,capgrpMessage)
			DisplayCaption = false
		end
		
		--[[
			--printDebug("plane interface")
			gx,gy = GetGearPosition(gear)
			--printDebug("x: " .. gx .. ", y: " .. gy)
			--printDebug("fuel raw: " .. fuelRaw)
			--printDebug("fuel: " .. fuelRaw)
			--printDebug("missiles: " .. missiles)
			--printDebug("fuelTag: " .. tostring(fuelTag) )
		
			fuelTag = AddVisualGear(gx-32, gy-32, vgtHealthTag, fuel, true)
			SetVisualGearValues(fuelTag, gx-32, gy-32, 0, 0, nil, nil, nil, nil, 32, 0xFFFF00FF, nil)
			if GetY(gear) >= WaterLine then DeleteVisualGear(fuelTag) end
			
			missilesTag = AddVisualGear(gx+32, gy-32, vgtHealthTag, missiles, true)
			SetVisualGearValues(missilesTag, gx+32, gy-32, 0, 0, nil, nil, nil, nil, 32, 0xBFBFBFFF, nil)
			if GetY(gear) >= WaterLine then DeleteVisualGear(missilesTag) end
		]]--
		--if GetY(gear) <= WaterLine then
		--else
		--	AddCaption("Fuel: ".. "0" .. "% | Missiles: ".. "0",capcolDefault,capgrpAmmostate)
			--plane = false
		--end
	end
end

function planeAddFuel(gear)
	if GetGearType(gear) == gtRCPlane then
		fuelRaw = GetTimer(gear)
		SetTimer(gear, fuelRaw + 3750)
	end
end

function planeAddMissiles(gear)
	if GetGearType(gear) == gtRCPlane then
		missiles = GetHealth(gear)
		SetHealth(gear, missiles + 3)
	end
end

function onGearAdd(gear)
    if GetGearType(gear) == gtRCPlane then
        trackGear(gear)
		SetGearValues(gear,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,75)
		plane = true
    end
	
    if GetGearType(gear) == gtAirBomb then
		SetGearValues(gear,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,50)
	end
end

function onGearDelete(gear)
	if GetGearType(gear) == gtRCPlane then
		trackDeletion(gear)
		plane = false
	end
	
	if GetGearType(gear) == gtCase then
		--printDebug("a crate")
		if GetGearMessage(gear) == 256 then
			PlaySound(sndShotgunReload)
			--printDebug("has been collected")
			--pos = GetGearPos(gear)
			--printDebug(pos)
			if GetGearPos(gear) == 9 then runOnGears(planeAddMissiles) end
			if GetGearPos(gear) == 12 then runOnGears(planeAddFuel) end
		end
	end
end

function onCaseDrop(gear)
	--DeleteGear(gear)
	if gear ~= nil then
		DeleteGear(gear)
		--PlaySound(sndReinforce,CurrentHedgehog)
		SpawnFakeAmmoCrate(0,0)
		SpawnFakeUtilityCrate(0,0)
	end
end

function onEndTurn(gear)
	--[[
	if gear ~= nil then
		if GetGearPos(gear) == 1 or GetGearPos(gear) == 4 then
			PlaySound(sndReinforce,CurrentHedgehog)
			DeleteGear(gear)
			SpawnFakeAmmoCrate(0,0)
			SpawnFakeUtilityCrate(0,0)
		end
	end
	]]--
end