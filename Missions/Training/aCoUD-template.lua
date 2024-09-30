-- 
-- load scripts
-- 

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")
HedgewarsScriptLoad("/Scripts/Animate.lua")

HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/circles.lua")
HedgewarsScriptLoad("/Scripts/finish.lua")

-- 
-- vars
-- 

player = {}
enemy = {}

--
-- library requirements
--

function isATrackedGear(gear)
	if (GetGearType(gear) == gtHedgehog) then return true else return false end
end

--[[
function isATrackedGear(gear)
	if 	(GetGearType(gear) == gtHedgehog) or
		(GetGearType(gear) == gtExplosives) or
		(GetGearType(gear) == gtMine) or
		(GetGearType(gear) == gtSMine) or
		(GetGearType(gear) == gtAirMine) or
		(GetGearType(gear) == gtTarget) or
		(GetGearType(gear) == gtKnife) or
		(GetGearType(gear) == gtPortal) or
		(GetGearType(gear) == gtCase)
	then
		return(true)
	else
		return(false)
	end
end
]]--

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
-- static mission stuff
--

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
		MissionStarted = false
	end
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
-- missions setup stuff
-- 

function SetupMap()
	Map = ""
	Theme = "Nature"
end

function SetupGameFlags()
	ClearGameFlags()
	EnableGameFlags(gfOneClanMode)
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
	HumanName,HumanIndex = AddMissionTeam(-1)
	player[1] = AddMissionHog(100)
	player[2] = AddMissionHog(100)
	player[3] = AddMissionHog(100)
	player[4] = AddMissionHog(100)
	
	AddTeam(loc("Enemy"), -2, "Simple", "Plane", "Default_qau", "hedgewars")
	enemy[1] = AddHog(loc("Hedgehog 1"), 3, 100, "NoHat")
	enemy[2] = AddHog(loc("Hedgehog 2"), 3, 100, "NoHat")
	enemy[3] = AddHog(loc("Hedgehog 3"), 3, 100, "NoHat")
	enemy[4] = AddHog(loc("Hedgehog 4"), 3, 100, "NoHat")
end

function SetupWeapons()
	for i = 1,#player do
	end
	
	for i = 1,#enemy do
	end
end

function SetupSprites()
end

-- 
-- cutscene stuff
-- 

function AnimationSetup()
	animIntro = {
	{func = AnimWait, args = {player1,2.5*1000}},
	{func = AnimSay, args = {player1, "test", SAY_SAY, 3*1000}}
	}
	local function ConcludeIntro() StartMission() end
    AddFunction({func = ConcludeIntro, args = {}})
	AddAnim(animIntro)
end

-- 
-- ShowBriefing
-- 

function ShowBriefing(a)
	if a == "intro" then
		ShowMission(missionName, "Objectives",
		"a".."|"..
		"",0, 0)
	end
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
	AnimationSetup()
end

function onGameTick()
	AnimatePrerequisite()
end

function onGameTick20()
end

function onPrecise()
	AnimationSkipping()
end

function onGameStart()
	SetupSprites()
	SetupWeapons()
	trackTeams()
end

function onAmmoStoreInit()
	PopulateCrates()
end

function onNewTurn()
	CheckMissionStart()
end

function onGearAdd(gear)
	if isATrackedGear(gear) then trackGear(gear) end
end

function onGearDelete(gear)
	if GetGearType(gear) == gtHedgehog then trackDeletion(gear)	end
end