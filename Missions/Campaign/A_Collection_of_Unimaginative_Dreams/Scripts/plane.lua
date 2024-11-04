--needs Tracker and generic loaded

function onGameTick20()
	if isPlane == true then runOnGears(planeInterface) end
end

function planeInterface(gear)
	if GetGearType(gear) == gtRCPlane then
		if GetY(gear) <= WaterLine-8 then
			fuelRaw = GetTimer(gear)
			missiles = GetHealth(gear)
			fuel = div(fuelRaw*100, 15000)
		else
			fuelRaw = 0
			missiles = 0
			fuel = 0
		end
		
		if missiles ~= 0 or fuel ~= 0 then
			AddCaption("Fuel: ".. fuel .. "% | Missiles: ".. missiles,capcolDefault,capgrpMessage)
		elseif missiles == 0 and fuel == 0 and DisplayCaption == true then
			AddCaption("Depleted!",capcolDefault,capgrpMessage)
			DisplayCaption = false
		end
	end
end

--[[
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
]]--

function onGearAdd(gear)
    if GetGearType(gear) == gtRCPlane then
		trackGear(gear)
		isPlane = true
		--SetBoom(gear,75)
		DisplayCaption = true
    end
	
	--[[
    if GetGearType(gear) == gtAirBomb then
		--SetBoom(gear,50)
	end
	]]--
end

function onGearDelete(gear)
	if GetGearType(gear) == gtRCPlane then
		isPlane = false
		trackDeletion(gear)
	end
	
	--[[
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
	]]--
end

--[[
function onCaseDrop(gear)
	--DeleteGear(gear)
	if gear ~= nil then
		DeleteGear(gear)
		--PlaySound(sndReinforce,CurrentHedgehog)
		SpawnFakeAmmoCrate(0,0)
		SpawnFakeUtilityCrate(0,0)
	end
end
]]--
