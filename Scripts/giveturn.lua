--CheckGivenTurn() needs to be added in onNewTurn()

team = ""
teamtemp = ""

function GiveTurn(team)
	teamtemp = team
	runOnHogsInOtherTeams(SetHogsPassive, team)
	GivenTurn = true
	EndTurn()
end

function SetHogsPassive(gear)
	testteam = GetHogTeamName(gear)
	SetTeamPassive(testteam, true)
end

function SetHogsNotPassive(gear)
	testteam = GetHogTeamName(gear)
	SetTeamPassive(testteam, false)
end

function ListHogs(gear)
	testIndex = testIndex + 1
	testteam = GetHogTeamName(gear)
	testname = GetHogName(gear)
	testArray[testIndex] = gear
end

function CheckGivenTurn()
	if GivenTurn == true then
		testIndex = 0
		testArray = {}
		runOnHogsInTeam(ListHogs, teamtemp)
		SwitchHog(testArray[1])
		runOnHogs(SetHogsNotPassive)
		GivenTurn = false
	end
end