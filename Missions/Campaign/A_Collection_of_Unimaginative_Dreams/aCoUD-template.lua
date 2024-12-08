-- 
-- load scripts
-- 

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")
HedgewarsScriptLoad("/Scripts/Animate.lua")

HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/generic.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/circles.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/giveturn.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/finish.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/soundmasks.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/counthogs.lua")

-- 
-- vars
-- 

missionName = "Template"
missionIcon = -amBazooka
missionID = -1

--local hhs = {}

turnCounter = -1

player = {}
enemy = {}

--
-- library requirements
--

function AnimatePrerequisite()
    AnimUnWait()
    if ShowAnimation() == false then
        return
    end
    ExecuteAfterAnimations()
    CheckEvents()
end

function AnimationSkipping()
	if AnimInProgress() then
		SetAnimSkip(true)
	end
end

-- 
-- missions setup stuff
-- 

function SetupMap()
	Map = "Mushrooms"
	Theme = "Nature"
end

function SetupGameFlags()
	ClearGameFlags()
	--EnableGameFlags(gfOneClanMode)
end

function SetupScheme()
	TurnTime = 45 * 1000
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
end

function SetupTeams()
	PlayerTeam,PlayerIndex = AddMissionTeam(-1)
	player[1] = AddMissionHog(100)
	player[2] = AddMissionHog(100)
	player[3] = AddMissionHog(100)
	player[4] = AddMissionHog(100)
	
	EnemyTeam,EnemyIndex = AddTeam(loc("Enemy"), -2, "Simple", "Plane", "Default_qau", "hedgewars")
	enemy[1] = AddHog(loc("Hedgehog 1"), 3, 100, "NoHat")
	enemy[2] = AddHog(loc("Hedgehog 2"), 3, 100, "NoHat")
	enemy[3] = AddHog(loc("Hedgehog 3"), 3, 100, "NoHat")
	enemy[4] = AddHog(loc("Hedgehog 4"), 3, 100, "NoHat")
end

function onGivenTurn()
	--SetTeamPassive(PrincessTeam,true)
end

function SetupWeapons()
	for i = 1,#player do
		AddAmmo(player[i],amBazooka,100)
	end
	
	for i = 1,#enemy do
		AddAmmo(enemy[i],amGrenade,100)
	end
end

function SetupSprites()
end

function PopulateCrates()
	for i = 0, AmmoTypeMax do
		if i ~= amNothing then
			SetAmmo(i, 0, 0, 0, 1)
		end
	end
	SetAmmo(amSkip, 9, 0, 0, 0)
end

-- 
-- cutscenes
-- 

function animIntro()
	animIntro = {
	{func = AnimFollowGear, args = {player[1]}},
	{func = AnimWait, args = {a,2.5*1000}},
	{func = AnimSay, args = {player[1], "...?", SAY_THINK, 3*1000}}
	}
	local function SkipIntro() end
	AddSkipFunction(animIntro, SkipIntro, {})
	local function AfterIntro()
		ShowMission(missionName, "Objectives",
		"Eliminate the enemy.".."|"..
		"",missionIcon,0)
		GiveTurn(PlayerTeam)
		AddEvent(checkExample, {}, doExample, {}, 0)
	end
    AddFunction({func = AfterIntro, args = {}})
	AddAnim(animIntro)
end

--
-- events
--

function checkExample()

end

function doExample()
end

-- 
-- HW functions
-- 

function onGameInit()
	SetupMap()
	SetupGameFlags()
	SetupScheme()
	SetupTeams()
	AnimInit()
	animIntro()
end

function onGameTick()
	AnimatePrerequisite()
	if AnimInProgress() then AnimationInProgress = true	else AnimationInProgress = false end
end

function onGameTick20()
end

function onPrecise() AnimationSkipping() end

function onGameStart()
	SetupSprites()
	SetupWeapons()
	trackTeams()
	CountHogs()
end


function onAmmoStoreInit() PopulateCrates() end

function onNewTurn()
	CheckGivenTurn()
	SoundMasks(0)
end

function onEndTurn() SoundMasks(1) end

function onGearAdd(gear) if GetGearType(gear) == gtHedgehog then trackGear(gear) end end

function onGearDelete(gear)
	if GetGearType(gear) == gtHedgehog then
		trackDeletion(gear)
		clan = GetHogClan(gear)
		isHogFromPlayerTeam = GetHogTeamName(gear) == PlayerTeam
		UpdateCounts()
	end
end

function onHogRestore(gear)	if GetGearType(gear) == gtHedgehog then trackRestoring(gear) end end
function onHogHide(gear) if GetGearType(gear) == gtHedgehog then trackHiding(gear) end end

-- 
-- mission specific stuff
-- 