function printDebug(message)
	WriteLnToConsole(message)
	WriteLnToChat(message)
end

function SetBoom(gear,Boom)
	SetGearValues(gear,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,Boom)
end
