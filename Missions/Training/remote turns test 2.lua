HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/giveturn.lua")

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
function onHogRestore(gear) if GetGearType(gear) == gtHedgehog then trackGear(gear) end end
function onGearDelete(gear) if GetGearType(gear) == gtHedgehog then trackDeletion(gear) end end
function onHogHide(gear)	if GetGearType(gear) == gtHedgehog then trackDeletion(gear) end end

function onGameStart()
	trackTeams()
end

function GiveWeapons()
	for i = 0,AmmoTypeMax do
		AddAmmo(CurrentHedgehog,i,100)
	end
end

function onNewTurn()
	CheckGivenTurn()
	GiveWeapons()
end

--GiveTurn(team1n)
--GiveTurn(team2n)
--GiveTurn(team3n)
--GiveTurn(team4n)
--GiveTurn(team4n,team4[3])
--GiveTurn(team5n)