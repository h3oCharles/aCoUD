HedgewarsScriptLoad("/Scripts/Animate.lua")
HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/giveturn.lua")
HedgewarsScriptLoad("/Scripts/finish.lua")
HedgewarsScriptLoad("/Scripts/circles.lua")

team1 = {}
team2 = {}
team3 = {}
team4 = {}
team5 = {}

team1s = {}
team2s = {}
team3s = {}
team4s = {}
team5s = {}

height = 798

function onGameInit()

	Map = "Ruler"
	Theme = "Nature"

	ClearGameFlags()
	EnableGameFlags(gfOneClanMode)

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
	--team1[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	--team1[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	--team1[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team1[1], 1.2*100, height)
	--SetGearPosition(team1[2], 2*100, height)
	--SetGearPosition(team1[3], 3*100, height)
	--SetGearPosition(team1[4], 4*100, height)
	HogTurnLeft(team1[1],true)
	
	team2n,team2i = AddTeam("Team 2", -2, "Simple", "Plane", "Default_qau", "hedgewars")
	team2[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team2[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team2[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team2[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team2[1], 1*100, height)
	SetGearPosition(team2[2], 1*100, height)
	SetGearPosition(team2[3], 1*100, height)
	SetGearPosition(team2[4], 1*100, height)

	team3n,team3i = AddTeam("Team 3", -3, "Simple", "Plane", "Default_qau", "hedgewars")
	team3[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team3[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team3[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team3[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team3[1], 1*100,  height)
	SetGearPosition(team3[2], 1*100, height)
	SetGearPosition(team3[3], 1*100, height)
	SetGearPosition(team3[4], 1*100, height)
	
	team4n,team4i = AddTeam("Team 4", -4, "Simple", "Plane", "Default_qau", "hedgewars")
	team4[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team4[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team4[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team4[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team4[1], 1*100,  height)
	SetGearPosition(team4[2], 1*100, height)
	SetGearPosition(team4[3], 1*100, height)
	SetGearPosition(team4[4], 1*100, height)
	
	team5n,team5i = AddTeam("Team 5", -5, "Simple", "Plane", "Default_qau", "hedgewars")
	team5[1] = AddHog("Hedgehog 1", 0, 100, "NoHat")
	team5[2] = AddHog("Hedgehog 2", 0, 100, "NoHat")
	team5[3] = AddHog("Hedgehog 3", 0, 100, "NoHat")
	team5[4] = AddHog("Hedgehog 4", 0, 100, "NoHat")
	SetGearPosition(team5[1], 1*100,  height)
	SetGearPosition(team5[2], 1*100, height)
	SetGearPosition(team5[3], 1*100, height)
	SetGearPosition(team5[4], 1*100, height)
	
	AnimInit()
end

function onGearAdd(gear)	if GetGearType(gear) == gtHedgehog then trackGear(gear) end end
function onHogRestore(gear) if GetGearType(gear) == gtHedgehog then trackGear(gear) end end
function onGearDelete(gear) if GetGearType(gear) == gtHedgehog then trackDeletion(gear) end end
function onHogHide(gear)	if GetGearType(gear) == gtHedgehog then trackDeletion(gear) end end

function onGameStart()
	trackTeams()
	
	FinishCircle = AddCircle(2*100,height,50,3,0xFF0000FF)
end

function GiveWeapons()
	for i = 0,AmmoTypeMax do
		AddAmmo(CurrentHedgehog,i,100)
	end
end

function onNewTurn()
	--CheckGivenTurn()
	GiveWeapons()
end

function onGameTick()
	AnimatePrerequisite()
end

function AnimatePrerequisite()
	AnimUnWait()
	if ShowAnimation() == false then
		return
	end
	ExecuteAfterAnimations()
	CheckEvents()
end

function onGameTick20()
	TestForStateOfGearInsideCircle(CurrentHedgehog,FinishCircle)
end

function onGearInsideCircle(gear,circle)
     if gear == CurrentHedgehog and circle == FinishCircle then
           ConcludeGame(true,false,false)
     end
end

function onStatCollection()
	--team1s.Kills, team1s.Suicides, team1s.AIKills, team1s.TeamKills, team1s.TurnSkips, team1s.TeamDamage = GetTeamStats(team1n)
	--team1s = GetTeamStats(team1n)
	--team1s[1] = GetTeamStats(team1n)
	--GetTeamStats(team2n)
	--GetTeamStats(team3n)
	--GetTeamStats(team4n)
	--GetTeamStats(team5n)
	printDebug("statistics collected")
	printDebug("Team 1".."'s ".."Kills: "..			tostring( GetTeamStats(team1n).Kills )			)
	printDebug("Team 1".."'s ".."Suicides: "..		tostring( GetTeamStats(team1n).Suicides )			)
	printDebug("Team 1".."'s ".."AIKills: "..		tostring( GetTeamStats(team1n).AIKills )			)
	printDebug("Team 1".."'s ".."TeamKills: "..		tostring( GetTeamStats(team1n).TeamKills )			)
	printDebug("Team 1".."'s ".."TurnSkips: "..		tostring( GetTeamStats(team1n).TurnSkips )			)
	printDebug("Team 1".."'s ".."TeamDamage: "..	tostring( GetTeamStats(team1n).TeamDamage )			)
	--siMaxStepKills
	--siMaxTeamDamage
	--siKilledHHs
	--siMaxStepDamage
	--siMaxTurnSkips
	--siTeamRank
end

--GiveTurn(team1n)
--GiveTurn(team2n)
--GiveTurn(team3n)
--GiveTurn(team4n)
--GiveTurn(team4n,team4[3])
--GiveTurn(team5n)