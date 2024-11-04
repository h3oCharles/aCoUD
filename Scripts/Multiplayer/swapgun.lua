function printDebug(message)
	WriteLnToConsole(message)
	HogSay(CurrentHedgehog,message,SAY_SAY)
end

function onGearAdd(gearUid)
	printDebug("gear added - type: "..GetGearType(gearUid))
end

function onGearDamage(gearUid, damage)
	printDebug("gear damaged - type: "..GetGearType(gearUid)..", damage: "..damage)
end