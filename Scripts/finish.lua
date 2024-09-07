function onGameInit()
	EnableGameFlags(gfOneClanMode)
end

function ConcludeGame(result,silence,special)
	printDebug("attempting to end the game")
	EndTurn()
	--onEndTurn()
	if result == true then
		printDebug("result is win")
		SaveMissionVar("Won", "true")
		SendStat(siGameResult, "Mission succeeded!")
		AddCaption("Mission succeeded!", 0xFFFFFFFF, capgrpGameState)
		
	end
	if result == false then
		printDebug("result is fail")
		SendStat(siGameResult, "Mission failed!")
		AddCaption("Mission failed!", 0xFFFFFFFF, capgrpGameState)
	end
	if		result == true and silence == false and special == true then
		printDebug("flawless sound")
		PlaySound(sndFlawless,CurrentHedgehog)
		SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstWinner)
	elseif	result == true and silence == false and special == false then
		printDebug("victory sound")
		PlaySound(sndVictory,CurrentHedgehog)
		SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstWinner)
	elseif	result == false and silence == false then
		printDebug("fail sound")
		PlaySound(sndNooo,CurrentHedgehog)
		SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstLoser)
	end
	SetInputMask(0)
	EndGame()
end