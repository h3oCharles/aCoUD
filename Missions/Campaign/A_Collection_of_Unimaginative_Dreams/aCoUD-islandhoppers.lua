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

missionName = "Island Hoppers"
missionID = -1

--local hhs = {}

turnCounter = -1

hopper = {}

humanHogs = 0

hopperCircles = {}
proxCircles = {}

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
	Map = "Islands"
	Theme = "Deepspace"
end

function SetupGameFlags()
	ClearGameFlags()
	EnableGameFlags(gfOneClanMode)
end

function SetupScheme()
	TurnTime = 30 * 1000
	Explosives = 0
	MinesNum = 0
	CaseFreq = 1
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
	player = AddMissionHog(1)
	SetTeamPassive(PlayerTeam, true)
	SetGearPosition(player, 69, 298)
	
	WillowTeam,WillowIndex = AddTeam(loc("Team Nature"), -1, "flower", "Snail", "Default_qau", "cm_flower")
	willow = AddHog(loc("Willow"), 0, 1, "zoo_Beaver")
	SetTeamPassive(WillowTeam, true)
	SetGearPosition(willow, 142, 281)
	HogTurnLeft(willow, true)
	
	Hopper1Team,Hopper1Index = AddTeam(loc("Island Hoppers"), -1, "Ghost", "Earth", GetHogVoicepack(player), "cm_galaxy")
	hopper[1] = AddHog(loc("Ceres"),0,1,"cyborg2") 
	hopper[2] = AddHog(loc("Crimson"),0,1,"InfernalHorns")
	hopper[3] = AddHog(loc("Bird"),0,1,"mechanicaltoy")
	hopper[4] = AddHog(loc("Nibbles"),0,1,"zoo_Bat") 
	hopper[5] = AddHog(loc("Soda"),0,1,"StrawHat") 
	hopper[6] = AddHog(loc("Seymour"),0,1,"pirate_bandana")
	
	Hopper2Team,Hopper1Index = AddTeam(loc("Island Hoppers").." "..loc("(cont.)"), -1, "Ghost", "Earth", GetHogVoicepack(player), "cm_galaxy")
	hopper[7] = AddHog(loc("Frankie"),0,1,"cap_junior") 
	hopper[8] = AddHog(loc("Cheddar"),0,1,"chef") 
	hopper[9] = AddHog(loc("Eggshell"),0,1,"eastertop") 
	hopper[10] = AddHog(loc("Geoff"),0,1,"Viking") 
	hopper[11] = AddHog(loc("Nicholas"),0,1,"Santa") 
	hopper[12] = AddHog(loc("Nemo"),0,1,"zoo_fish") 
end

function onGivenTurn()
	SetTeamPassive(PlayerTeam,true)
	SetTeamPassive(WillowTeam,true)
end

function SetupWeapons()
	for i = 1,#hopper do
		AddAmmo(hopper[i],amRope,100)
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
	{func = AnimFollowGear, args = {player}},
	{func = AnimWait, args = {a,2.5*1000}},
	{func = AnimSay, args = {player, "...?", SAY_THINK, 3*1000}},
	{func = AnimSay, args = {willow, "...?", SAY_THINK, 3*1000}}
	}
	local function SkipIntro() end
	AddSkipFunction(animIntro, SkipIntro, {})
	local function AfterIntro()
		ShowMission(missionName, "Objectives",
		loc("Guide each of the Island Hoppers to the approporiate island.") .. "|" ..
		" " .. "|" ..
		loc("All hedgehogs must survive.") .. "|" ..
		"",-amLowGravity, 0)
		GiveTurn(Hopper1Team)
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

targetAreaX = {1655,3345,694,2145,357,2979,3809,1385,2131,995,2361,175,3327}
targetAreaY = {887,1512,567,1414,1140,977,738,75,90,1424,726,162,170}
targetAreaRad = {195,246,194,195,277,197,314,362,215,405,290,238,308}

function onGameStart()
	SetupSprites()
	SetupWeapons()
	trackTeams()
	
	for i = 1,#targetAreaX do
		hopperCircles[i] = AddCircle(targetAreaX[i], targetAreaY[i], targetAreaRad[i], 3, 0xFF000080)
		proxCircles[i] = AddCircle(targetAreaX[i], targetAreaY[i], 1536, 3, 0x00FFFF20)
	end
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

	--[[if GetGearType(gear) == gtHedgehog then
		if IsHogLocal(gear) == true then
			humanHogs = humanHogs + 1
		end
	end]]--
end

function onGearDelete(gear)
	if isATrackedGear(gear) then trackDeletion(gear) end
	
	if GetHogLevel(gear) == 0 and IsHogLocal(gear) == true
	and gear ~= player and gear ~= willow then
			ConcludeGame(false,true,false)
	end
	
	--[[if GetHogLevel(gear) == 0 and IsHogLocal(gear) == true then
		humanHogs = humanHogs - 1
		if humanHogs == 0 then
			ConcludeGame(false,true,false)
		end
	end]]--
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
