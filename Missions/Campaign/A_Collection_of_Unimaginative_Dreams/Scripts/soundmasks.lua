function SoundMasks(num)
	--onNewTurn
	if num == 0 then
		if AnimationInProgress == true then
			AnimFollowGear(triggered)
			SetSoundMask(sndYesSir, true)
			SetSoundMask(sndHmm, true)
		else
			SetSoundMask(sndYesSir, false)
			SetSoundMask(sndHmm, false)
		end
	--onEndTurn
	elseif num == 1 then
		SetSoundMask(sndYesSir, false)
		SetSoundMask(sndHmm, false)
		if enemyHogs == 0 then
			SetSoundMask(sndMissed, true)
			SetSoundMask(sndCoward, true)
		end
	end
end