--[[
function SetPassive(isPassive)
	tempPassive = isPassive
	runOnHogs(SetPassiveOnHogs)
end

function SetPassiveOnHogs(gear)
	HogTeamName = GetHogTeamName(gear)
	if HogTeamName ~= HumanName then
		SetTeamPassive(HogTeamName, tempPassive)
	end
end

function StartMission()
	SetPassive(true)
	AnimSwitchHog(player[#player])
	ShowBriefing("intro")
	EndTurn(true)
	MissionStarted = true
end

function CheckMissionStart()
	if MissionStarted == true then
		SetPassive(false)
		SetTeamPassive(loc("Princess"), true)
		MissionStarted = false
	end
end
]]--

--
-- map setup
--

HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")

team1 = {}
team2 = {}
team3 = {}
team4 = {}
team5 = {}

height = 798

function onGameInit()

	Map = "Ruler"
	Theme = "Nature"

	TurnTime = 9999 * 1000
	Explosives = 0
	MinesNum = 0
	CaseFreq = 0
	Delay = 0.1 * 1000
	HealthCaseProb = 35
	HealthCaseAmount = 25
	DamagePercent = 100
	RopePercent = 100
	MinesTime = 3 * 1000
	MineDudPercent  = 0
	SuddenDeathTurns = 50
	WaterRise = 0
	HealthDecrease = 0
	Ready = 5 * 1000
	AirMinesNum = 0
	GetAwayTime = 100
	WorldEdge = 0
	
	team1n,team1i = AddTeam("Team 1", -1, "Simple", "Plane", "Default_qau", "hedgewars")
	team1[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team1[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team1[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team1[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team1[1], 1*100, height)
	SetGearPosition(team1[2], 2*100, height)
	SetGearPosition(team1[3], 3*100, height)
	SetGearPosition(team1[4], 4*100, height)
	
	team2n,team2i = AddTeam("Team 2", -2, "Simple", "Plane", "Default_qau", "hedgewars")
	team2[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team2[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team2[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team2[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team2[1], 5*100, height)
	SetGearPosition(team2[2], 6*100, height)
	SetGearPosition(team2[3], 7*100, height)
	SetGearPosition(team2[4], 8*100, height)

	team3n,team3i = AddTeam("Team 3", -3, "Simple", "Plane", "Default_qau", "hedgewars")
	team3[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team3[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team3[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team3[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team3[1], 9*100,  height)
	SetGearPosition(team3[2], 10*100, height)
	SetGearPosition(team3[3], 11*100, height)
	SetGearPosition(team3[4], 12*100, height)
	
	team4n,team4i = AddTeam("Team 4", -4, "Simple", "Plane", "Default_qau", "hedgewars")
	team4[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team4[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team4[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team4[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team4[1], 13*100,  height)
	SetGearPosition(team4[2], 14*100, height)
	SetGearPosition(team4[3], 15*100, height)
	SetGearPosition(team4[4], 16*100, height)
	
	team5n,team5i = AddTeam("Team 5", -5, "Simple", "Plane", "Default_qau", "hedgewars")
	team5[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team5[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team5[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team5[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team5[1], 17*100,  height)
	SetGearPosition(team5[2], 18*100, height)
	SetGearPosition(team5[3], 19*100, height)
	SetGearPosition(team5[4], 20*100, height)
end

function onGearAdd(gear)	if GetGearType(gear) == gtHedgehog then trackGear(gear) end end
function onGearDelete(gear) if GetGearType(gear) == gtHedgehog then trackDeletion(gear) end end
function onHogRestore(gear) if GetGearType(gear) == gtHedgehog then trackGear(gear) end end
function onHogHide(gear)	if GetGearType(gear) == gtHedgehog then trackDeletion(gear) end end

function onGameStart()
	trackTeams()
end

function GiveWeapons()
	for i = 0,AmmoTypeMax do
		AddAmmo(CurrentHedgehog,i,100)
	end
end

--
-- the actual function
--

--GiveTurn(team1n)
--GiveTurn(team2n)
--GiveTurn(team3n)
--GiveTurn(team4n)
--GiveTurn(team5n)

team = ""
teamtemp = ""

function GiveTurn(team)
	--team = teamtemp
	teamtemp = team
	--printDebug("team"..": "..team)
	--printDebug("teamtemp"..": "..teamtemp)
	--printDebug("trying to give a turn to team " .. tostring(team) )
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
	--printDebug("hog "..testIndex.." of team "..testteam.." is "..testname)
	testArray[testIndex] = gear
end

function onNewTurn()
	if GivenTurn == true then
		--printDebug("give turn was executed")
		--printDebug("the turn was given to "..tostring(teamtemp) )
		testIndex = 0
		testArray = {}
		runOnHogsInTeam(ListHogs, teamtemp)
		--printDebug("there are "..testIndex.. " hogs in this team")
		SwitchHog(testArray[1])
		runOnHogs(SetHogsNotPassive)
		GivenTurn = false
	end

	GiveWeapons()
end

--[[
function gets run
all hogs but the selected team are passive (passive true)
end turn
new turn - the selected team gets a turn
all hogs no longer passive (passive false)
]]--