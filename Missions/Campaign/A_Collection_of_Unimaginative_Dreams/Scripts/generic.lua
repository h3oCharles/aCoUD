function printDebug(message)
	WriteLnToConsole(message)
	WriteLnToChat(message)
end

function SetBoom(gear,Boom)
	SetGearValues(gear,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,Boom)
end

function CutsceneTriggered()
	AddCaption(loc("Cutscene Triggered!"), 0xFFBA00FF, capgrpMessage2) PlaySound(sndExtraTime)
end