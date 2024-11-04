--needs Tracker library
--CheckGivenTurn() needs to be added in onNewTurn()
--trackTeams() needs to be added in onGameStart()
--all hedgehogs need to be tracked from the start

--team = ""
--teamtemp = ""
--hog = ""
--hogtemp = ""

function onGivenTurn() end

function GiveTurn(team,hog)
	teamtemp = team
	hogtemp = hog
	runOnHogsInOtherTeams(SetHogsPassive, team)
	GivenTurn = true
	EndTurn(true)
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
		if hogtemp == nil then
			SwitchHog(testArray[1])
			FollowGear(testArray[1])
		else
			SwitchHog(hogtemp)
			FollowGear(hogtemp)
		end
		runOnHogs(SetHogsNotPassive)
		onGivenTurn()
		GivenTurn = false
	end
end