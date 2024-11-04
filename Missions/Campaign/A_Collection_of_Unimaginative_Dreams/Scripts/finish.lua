--gfOneClanMode needs to be enabled if this is used

function ConcludeGame(result,silence,special)
	if AnimInProgress() ~= true then
		EndTurn()
		if result == true then
			SaveMissionVar("Won", "true")
			SendStat(siGameResult, "Mission succeeded!")
			AddCaption("Mission succeeded!", 0xFFFFFFFF, capgrpGameState)
			
		end
		if result == false then
			SendStat(siGameResult, "Mission failed!")
			AddCaption("Mission failed!", 0xFFFFFFFF, capgrpGameState)
		end
		if		result == true and silence == false and special == true then
			PlaySound(sndFlawless,CurrentHedgehog)
			SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstWinner)
		elseif	result == true and silence == false and special == false then
			PlaySound(sndVictory,CurrentHedgehog)
			SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstWinner)
		elseif	result == false and silence == false then
			PlaySound(sndNooo,CurrentHedgehog)
			SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstLoser)
		end
		SetInputMask(0)
		EndGame()
	end
end

function terminate()
	ConcludeGame(true,false,false)
	SendHealthStatsOff()
	SendAchievementsStatsOff()
	SendRankingStatsOff()
	SendGameResultOff()
	SendStat(siGameResult, "You cheated not only the game, but yourself.")
	SendStat(siCustomAchievement, "You didn't grow.")
	SendStat(siCustomAchievement, "You didn't improve.")
	SendStat(siCustomAchievement, "You took a shortcut and gained nothing.")
	SendStat(siCustomAchievement, "You experienced a hollow victory.")
	SendStat(siCustomAchievement, "Nothing was risked and nothing was gained.")
	SendStat(siCustomAchievement, "It's sad you don't know the difference.")
end
