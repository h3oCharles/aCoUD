function onGearAdd(gear)
	if GetGearType(gear) == gtFlame then
		flame = AddGear(0, 0, gtMelonPiece, 0, 0, 0, 25)
		CopyPV(gear, flame)
		DeleteGear(gear)
	end
end