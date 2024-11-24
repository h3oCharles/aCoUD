-- 
-- load scripts
-- 

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")
HedgewarsScriptLoad("/Scripts/Animate.lua")

HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/generic.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/giveturn.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/finish.lua")

-- 
-- vars
-- 

missionName = "Island Hoppers"
missionID = -1

--local hhs = {}

hopper = {}

hopperCircles = {}
proxCircles = {}
cratePos1 = {}
cratePos2 = {}

startX = {3714,299,2189,1344,2908,695,2068,3427,1083,3198,227,1730}
startY = {956,1122,1380,29,967,569,82,1416,1565,255,30,1019}

isHogResurrected = false

--
-- library requirements
--

function isATrackedGear(gear)
	if (GetGearType(gear) == gtHedgehog) then return true else return false end
end

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
	HealthCaseProb = 100
	HealthCaseAmount = 0
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
	
	MaxCaseDrops = 1
end

function SetupTeams()
	PlayerTeam,PlayerIndex = AddMissionTeam(-1)
	player = AddMissionHog(1)
	SetTeamPassive(PlayerTeam, true)
	SetGearPosition(player, 69, 298)
	
	WillowTeam,WillowIndex = AddTeam(loc("Team Nature"), -1, "flower", "Snail", GetHogVoicepack(player), "cm_flower")
	willow = AddHog(loc("Willow"), 0, 1, "zoo_Beaver")
	SetTeamPassive(WillowTeam, true)
	SetGearPosition(willow, 142, 281)
	HogTurnLeft(willow, true)
	
	Hopper1Team,Hopper1Index = AddTeam(loc("Island Hoppers"), -1, "Ghost", "Earth", GetHogVoicepack(player), "cm_galaxy")
	hopper[1] = AddHog(loc("Ceres"),0,1,"cyborg2")
	hopper[3] = AddHog(loc("Bird"),0,1,"mechanicaltoy")
	hopper[5] = AddHog(loc("Soda"),0,1,"StrawHat")
	hopper[7] = AddHog(loc("Frankie"),0,1,"cap_junior")
	hopper[9] = AddHog(loc("Eggshell"),0,1,"eastertop")
	hopper[11] = AddHog(loc("Nicholas"),0,1,"Santa")
	
	Hopper2Team,Hopper2Index = AddTeam(loc("Island Hoppers").." "..loc("(cont.)"), -1, "Ghost", "Earth", GetHogVoicepack(player), "cm_galaxy")
	hopper[2] = AddHog(loc("Crimson"),0,1,"InfernalHorns")
	hopper[4] = AddHog(loc("Nibbles"),0,1,"zoo_Bat")
	hopper[6] = AddHog(loc("Seymour"),0,1,"pirate_bandana")
	hopper[8] = AddHog(loc("Cheddar"),0,1,"chef")
	hopper[10] = AddHog(loc("Geoff"),0,1,"Viking")
	hopper[12] = AddHog(loc("Nemo"),0,1,"zoo_fish")

	for i = 1,#hopper do SetEffect(hopper[i],heResurrectable,1) end
	for i = 1,#hopper do SetGearCollisionMask(hopper[i],lfLandMask+lfCurHogCrate) end

	SetGearPosition(hopper[1],3714,956)
	SetGearPosition(hopper[2],299,1122)
	SetGearPosition(hopper[3],2189,1380)
	SetGearPosition(hopper[4],1344,29)
	SetGearPosition(hopper[5],2908,967)
	SetGearPosition(hopper[6],695,569)
	SetGearPosition(hopper[7],2068,82)
	SetGearPosition(hopper[8],3427,1416)
	SetGearPosition(hopper[9],1083,1565)
	SetGearPosition(hopper[10],3198,255)
	SetGearPosition(hopper[11],227,30)
	SetGearPosition(hopper[12],1730,1019)
	
	HogTurnLeft(hopper[5], true)
	HogTurnLeft(hopper[6], true)
	HogTurnLeft(hopper[10], true)

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
	SetAmmo(amSkip, 0, 0, 0, 0)
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

targetAreaX =	{1615,	3250,		740,	2110,		360,	2980,		3820,		1250,		2180,		1150,	2285,		3355}
targetAreaY =	{830,	1620,		555,	1525,		1150,	935,		960,		130,		50,			1570,	820,		260}
--				ceres	crimson		bird	nibbles		soda	seymour		frankie		cheddar		eggshell	geoff	nicholas	nemo
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
	
	SwitchHog(hopper[turnCounter])
	FollowGear(hopper[turnCounter])
	isHogResurrected = false
end

function onEndTurn()
	if turnCounter ~= 13 and CurrentHedgehog ~= nil and crate ~= nil and isHogResurrected == false and AnimInProgress() == false then
		SetHealth(CurrentHedgehog,0)
	end
end

function onGearAdd(gear)
	if isATrackedGear(gear) then trackGear(gear) end
end

function onGearDelete(gear)
	if isATrackedGear(gear) then trackDeletion(gear) end
	
	if GetHogLevel(gear) == 0 and IsHogLocal(gear) == true
	and gear ~= player and gear ~= willow then
			SetTeamPassive(Hopper1Team, true)
			SetTeamPassive(Hopper2Team, true)
			DisableGameFlags(gfOneClanMode)
	end
	
	onCaseCollect(gear)
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

function onCaseDrop(gear)
	if gear ~= nil then crate = gear end
	SetGearPosition(gear,targetAreaX[turnCounter],targetAreaY[turnCounter]-256)
end

turnCounter = 1

function onCaseCollect(gear)
	if GetGearType(gear) == gtCase and GetGearMessage(gear) == 256 then
		turnCounter = turnCounter + 1
		SetGearVelocity(CurrentHedgehog,0,0)
		if turnCounter == 13 then
			EndTurn(true)
			for i = 1,#hopper do SetEffect(hopper[i], heInvulnerable, 1) end
			for i = 1,#hopper do RestoreHog(hopper[i]) end
			DisableGameFlags(gfOneClanMode)
		else
			x,y = GetGearPosition(CurrentHedgehog)
			AddVisualGear(x,y,vgtExplosion,0,false)
			for i = 1,25 do AddVisualGear(x,y,vgtFeather,0,false) end
			HideHog(CurrentHedgehog)
			SetTurnTimeLeft(9999 * 1000)
		end
	end
end

attempts = 3

function onGearResurrect(gear, spawnedVGear)
	if gear == CurrentHedgehog then
		isHogResurrected = true
		attempts = attempts - 1
		AddCaption(attempts .. " " .. loc("attempts left!"))
		if attempts == 0 then
			SetEffect(CurrentHedgehog,heResurrectable,0)
		else
			SetEffect(CurrentHedgehog,heResurrectable,1)
		end
			SetGearPosition(CurrentHedgehog,startX[turnCounter],startY[turnCounter])
			SetVisualGearValues(spawnedVGear, startX[turnCounter],startY[turnCounter], nil, nil, nil, nil, nil, nil, nil, nil, nil)
	end
end