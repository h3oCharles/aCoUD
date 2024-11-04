--gfOneClanMode needs to be enabled if this is used

--SaveCampaignVar("Progress", tostring(2314) )

function ConcludeGame(result,silence,special)
	if AnimInProgress() ~= true then
		EndTurn()
		SendGameResultOff()
		if result == true then
			SendStat(siGameResult, "Mission succeeded!")
			AddCaption("Mission succeeded!", 0xFFFFFFFF, capgrpGameState)
			
			progress = GetCampaignVar("Progress")
			if progress == "" then progress = 0 end
			SaveCampaignVar("Progress", tostring(progress) )
			progress = GetCampaignVar("Progress")
			
			SaveCampaignVar("Mission".. missionID .."Won", tostring(true) )
			if tonumber(progress) < tonumber(missionID) == true then
				SaveCampaignVar("Progress", tostring(missionID) )
			end
		end
		if result == false then
			SendStat(siGameResult, "Mission failed!")
			AddCaption("Mission failed!", 0xFFFFFFFF, capgrpGameState)
		end
		if result == true and silence == false then
			if special == true then
				PlaySound(sndFlawless,CurrentHedgehog)
			elseif special == false then
				PlaySound(sndVictory,CurrentHedgehog)
			end
			SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstWinner)
		elseif	result == false and silence == false then
			PlaySound(sndNooo,CurrentHedgehog)
			SetState(CurrentHedgehog,GetState(CurrentHedgehog) + gstLoser)
		end
		SetInputMask(0)
		EndGame()
		onStatCollection()
		PopulateStats()
		--stats would be here
	end
end

function onStatCollection() end

function PopulateStats()
	
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