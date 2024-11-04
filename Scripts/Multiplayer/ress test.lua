--[[
function onGameInit()
	EnableGameFlags(gfOneClanMode)
end
]]--

function onNewTurn()
	if GetHogLevel(CurrentHedgehog) ~= 0 then
		SetHealth(CurrentHedgehog,1)
		SkipTurn()
	end
end

function onGearAdd(gear)
	if GetGearType(gear) == gtHedgehog and GetHogLevel(gear) == 0 then
		SetEffect(gear, heResurrectable, 1)
	end
	--[[
	if GetGearType(gear) == gtHedgehog and GetHogLevel(gear) ~= 0 then
		SetHealth(gear,1)
	end
	]]--
end

function onGearResurrect(gear, spawnedVGear)
	if GetGearType(gear) == gtHedgehog and GetHogLevel(gear) == 0 then
		SetEffect(gear, heResurrectable, 1)
	end
end