playerHogs = 0
enemyHogs = 0

function CountHogs()
	PlayerClan = GetHogClan(player[1])
	EnemyClan = GetHogClan(enemy[1])
	runOnHogs(CountHogs1)
end

function CountHogs1(gear)
	clan = GetHogClan(gear)
	isHogFromPlayerTeam = GetHogTeamName(gear) == PlayerTeam
	if clan == PlayerClan and isHogFromPlayerTeam == true then
		playerHogs = playerHogs + 1
	elseif clan == EnemyClan then
		enemyHogs = enemyHogs + 1
	end
end

function UpdateCounts()
	--clan = GetHogClan(gear)
	--isHogFromPlayerTeam = GetHogTeamName(gear) == PlayerTeam
	if clan == PlayerClan and isHogFromPlayerTeam == true then
		playerHogs = playerHogs - 1
		--if playerHogs == 0 then ConcludeGame(false,true,false) end
	elseif clan == EnemyClan then
		enemyHogs = enemyHogs - 1
	end
end