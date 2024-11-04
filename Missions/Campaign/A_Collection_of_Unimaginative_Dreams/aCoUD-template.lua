-- 
-- load scripts
-- 

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")
HedgewarsScriptLoad("/Scripts/Animate.lua")

HedgewarsScriptLoad("/Scripts/generic.lua")
HedgewarsScriptLoad("/Scripts/circles.lua")
HedgewarsScriptLoad("/Scripts/giveturn.lua")
HedgewarsScriptLoad("/Scripts/finish.lua")

-- 
-- vars
-- 

missionName = "Template"
missionID = -1

--local hhs = {}

turnCounter = -1

player = {}
enemy = {}

humanHogs = 0

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
-- missions setup stuff
-- 

function SetupMap()
	Map = "Mushrooms"
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
-- cutscene stuff
-- 

function animIntro()
	animIntro = {
	{func = AnimWait, args = {a,2.5*1000}},
	{func = AnimSay, args = {player[1], "...?", SAY_THINK, 3*1000}}
	}
	local function SkipIntro() end
	AddSkipFunction(animIntro, SkipIntro, {})
	local function AfterIntro()
		ShowMission(missionName, "Objectives",
		"Eliminate the enemy.".."|"..
		"",-amBazooka, 0)
		GiveTurn(PlayerTeam)
	end
    AddFunction({func = AfterIntro, args = {}})
	AddAnim(animIntro)
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
	CheckGivenTurn()
	
	if AnimInProgress() == true then
		--AnimFollowGear(triggered)
		SetSoundMask(sndYesSir, true)
		SetSoundMask(sndHmm, true)
	else
		SetSoundMask(sndYesSir, false)
		SetSoundMask(sndHmm, false)
	end
end

function onEndTurn()
	SetSoundMask(sndYesSir, false)
	SetSoundMask(sndHmm, false)
end

function onGearAdd(gear)
	if isATrackedGear(gear) then trackGear(gear) end

	if GetGearType(gear) == gtHedgehog then
		if IsHogLocal(gear) == true then
			humanHogs = humanHogs + 1
		end
	end
end

function onGearDelete(gear)
	if isATrackedGear(gear) then trackDeletion(gear) end
	
	if GetHogLevel(gear) == 0 and IsHogLocal(gear) == true then
		humanHogs = humanHogs - 1
		if humanHogs == 0 then
			ConcludeGame(false,true,false)
		end
	end
end

function onHogRestore(gear)
	if isATrackedGear(gear) then trackGear(gear) end
end

function onHogHide(gear)
	if isATrackedGear(gear) then trackDeletion(gear) end
end

-- 
-- mission specific stuff
-- 
