HedgewarsScriptLoad("/Scripts/Tracker.lua")

HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/turncounter.lua")

height = 0

function TargetWidth()
	height = height + 1
	for i = 0, LAND_WIDTH/24 do
		target = AddGear(24*i,0,gtTarget,0,0,0,0)
	end
end

function onGameStart()
	TargetWidth()
	SetGravity(1000)
	runOnGears(InvulHogs)
	SetSoundMask(sndBump, true)
	SetSoundMask(sndWarp, true)
	SetSoundMask(sndGrenadeImpact, true)
	SetSoundMask(sndSkip, true)
	SetSoundMask(sndSplash, true)
	SetSoundMask(sndDroplet1, true)
	SetSoundMask(sndDroplet2, true)
	SetSoundMask(sndDroplet3, true)
end

function EndSetup()
	SetGravity(100)
	runOnGears(ShiftHogs)
	SetSoundMask(sndBump,			false)
	SetSoundMask(sndWarp,			false)
	SetSoundMask(sndGrenadeImpact,	false)
	SetSoundMask(sndSkip,			false)
	SetSoundMask(sndSplash,			false)
	SetSoundMask(sndDroplet1,		false)
	SetSoundMask(sndDroplet2,		false)
	SetSoundMask(sndDroplet3,		false)
end

function onNewTurn()
	runOnGears(InvulOffHogs)
end

function onCaseDrop(case)
	runOnGears(BumpHogs)
end

function onGameTick20()
	--printDebug(tostring(GetFlightTime(target)))
	if turnCounter == -1 then
		--dx,dy = GetGearVelocity(target)
		if GetFlightTime(target) == nil then
			if height < 16 then
				TargetWidth()
				runOnGears(ShiftHogs)
			elseif height == 16 then
				EndSetup()
				height = 17
			end
		end
	end
	if target ~= nil then
		tx,ty = GetGearPosition(target)
		if ty ~= nil and ty > LAND_HEIGHT then DeleteGear(target) end
	end
end

function isATrackedGear(gear)
	if 	(GetGearType(gear) == gtHedgehog)
	then return(true)
	else return(false)
	end
end

function onGearAdd(gear)
	if isATrackedGear(gear) then
		trackGear(gear)
	end
end

function ShiftHogs(gear)
	if GetGearType(gear) == gtHedgehog then
		x,y = GetGearPosition(gear)
		SetGearPosition(gear,x,0)
	end
end

function BumpHogs(gear)
	if GetGearType(gear) == gtHedgehog then
		x,y = GetGearPosition(gear)
		SetGearPosition(gear,x,y-24)
	end
end

function InvulHogs(gear)
	if GetGearType(gear) == gtHedgehog then
		SetEffect(gear,heInvulnerable,1)
	end
end

function InvulOffHogs(gear)
	if GetGearType(gear) == gtHedgehog then
		SetEffect(gear,heInvulnerable,0)
	end
end