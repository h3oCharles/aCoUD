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

missionName = "A Hypothetical Became a Reality"
missionIcon = 3
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
	CaseFreq = 2
	Delay = 0.1 * 1000
	HealthCaseProb = 100
	HealthCaseAmount = 25
	DamagePercent = 100
	RopePercent = 100
	MinesTime = 0 * 1000
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
	player[1] = AddMissionHog(20)
	player[2] = AddMissionHog(20)
	player[3] = AddMissionHog(20)
	player[4] = AddMissionHog(20)
	SetGearPosition(player[1], 782, 252)
	SetGearPosition(player[2], 901, 489)
	SetGearPosition(player[3], 1060, 390)
	SetGearPosition(player[4], 1249, 251)
	HogTurnLeft(player[1], true)
	HogTurnLeft(player[3], true)
	HogTurnLeft(player[4], true)
	
	EnemyTeam,EnemyIndex = AddTeam(loc("Rookies"), -2, "Simple", "Plane", "Default_qau", "hedgewars")
	enemy[1] = AddHog(loc("Diego"), 3, 180, "NoHat")
	enemy[2] = AddHog(loc("Boggy"), 3, 180, "NoHat")
	enemy[3] = AddHog(loc("Arnold"), 3, 180, "NoHat")
	enemy[4] = AddHog(loc("Adrian"), 3, 180, "NoHat")
	SetGearPosition(enemy[1], 427, 199)
	SetGearPosition(enemy[2], 490, 167)
	SetGearPosition(enemy[3], 694, 186)
	SetGearPosition(enemy[4], 743, 218)
	--HogTurnLeft(enemy[4], true)
end

function onGivenTurn()
	--SetTeamPassive(PrincessTeam,true)
end

function SetupWeapons()
	for i = 1,#player do
		AddAmmo(player[i],amBazooka,100)
		AddAmmo(player[i],amMortar,5)
		AddAmmo(player[i],amDrill,1)
		AddAmmo(player[i],amSnowball,2)
		
		AddAmmo(player[i],amGrenade,100)
		AddAmmo(player[i],amClusterBomb,3)
		AddAmmo(player[i],amMolotov,2)
		
		AddAmmo(player[i],amShotgun,100)
		AddAmmo(player[i],amDEagle,3)
		AddAmmo(player[i],amMinigun,1)
		
		AddAmmo(player[i],amFirePunch,100)
		AddAmmo(player[i],amWhip,100)
		AddAmmo(player[i],amHammer,1)
		
		AddAmmo(player[i],amMine,3)
		AddAmmo(player[i],amSMine,1)
		
		AddAmmo(player[i],amGirder,1)
		
		AddAmmo(player[i],amRope,4)
		AddAmmo(player[i],amParachute,3)
		
		AddAmmo(player[i],amResurrector,3)
		
		AddAmmo(player[i],amSwitch,3)
	end
	
	for i = 1,#enemy do
		AddAmmo(enemy[i],amBazooka,100)
		AddAmmo(enemy[i],amGrenade,100)
		AddAmmo(enemy[i],amShotgun,100)
		AddAmmo(enemy[i],amFirePunch,100)
		AddAmmo(enemy[i],amWhip,100)
		AddAmmo(enemy[i],amSMine,5)
	end
end

function SetupSprites()
	AddGear(86, 630, gtMine, 0, 0, 0, 0)
	AddGear(124, 560, gtMine, 0, 0, 0, 0)
	AddGear(160, 514, gtMine, 0, 0, 0, 0)
	AddGear(216, 465, gtMine, 0, 0, 0, 0)
	AddGear(1777, 512, gtMine, 0, 0, 0, 0)
	AddGear(1824, 548, gtMine, 0, 0, 0, 0)
	AddGear(1861, 593, gtMine, 0, 0, 0, 0)
	AddGear(1893, 651, gtMine, 0, 0, 0, 0)
	AddGear(1491, 810, gtMine, 0, 0, 0, 0)
	AddGear(1587, 781, gtMine, 0, 0, 0, 0)
	AddGear(1541, 773, gtMine, 0, 0, 0, 0)
	AddGear(1458, 769, gtMine, 0, 0, 0, 0)
	AddGear(1445, 719, gtMine, 0, 0, 0, 0)
	AddGear(1441, 693, gtMine, 0, 0, 0, 0)
	AddGear(1435, 653, gtMine, 0, 0, 0, 0)
	AddGear(1433, 640, gtMine, 0, 0, 0, 0)
	AddGear(1623, 762, gtMine, 0, 0, 0, 0)
	AddGear(1640, 722, gtMine, 0, 0, 0, 0)
	AddGear(1158, 862, gtMine, 0, 0, 0, 0)
	AddGear(1182, 829, gtMine, 0, 0, 0, 0)
	AddGear(1210, 801, gtMine, 0, 0, 0, 0)
	AddGear(1234, 833, gtMine, 0, 0, 0, 0)
	AddGear(1251, 864, gtMine, 0, 0, 0, 0)
	AddGear(761, 897, gtMine, 0, 0, 0, 0)
	AddGear(809, 894, gtMine, 0, 0, 0, 0)
	AddGear(856, 892, gtMine, 0, 0, 0, 0)
	AddGear(901, 890, gtMine, 0, 0, 0, 0)
	AddGear(950, 889, gtMine, 0, 0, 0, 0)
	AddGear(998, 888, gtMine, 0, 0, 0, 0)
	AddGear(1056, 888, gtMine, 0, 0, 0, 0)
	AddGear(1120, 890, gtMine, 0, 0, 0, 0)
	AddGear(1286, 898, gtMine, 0, 0, 0, 0)
	AddGear(1327, 901, gtMine, 0, 0, 0, 0)
	AddGear(821, 674, gtMine, 0, 0, 0, 0)
	AddGear(794, 716, gtMine, 0, 0, 0, 0)
	AddGear(758, 717, gtMine, 0, 0, 0, 0)
	AddGear(719, 778, gtMine, 0, 0, 0, 0)
	AddGear(691, 809, gtMine, 0, 0, 0, 0)
	AddGear(677, 802, gtMine, 0, 0, 0, 0)
	AddGear(663, 755, gtMine, 0, 0, 0, 0)
	AddGear(646, 720, gtMine, 0, 0, 0, 0)
	AddGear(619, 754, gtMine, 0, 0, 0, 0)
	AddGear(599, 804, gtMine, 0, 0, 0, 0)
	AddGear(380, 685, gtMine, 0, 0, 0, 0)
	AddGear(395, 756, gtMine, 0, 0, 0, 0)
	AddGear(415, 830, gtMine, 0, 0, 0, 0)
	AddGear(432, 892, gtMine, 0, 0, 0, 0)
	AddGear(434, 758, gtMine, 0, 0, 0, 0)
	AddGear(469, 811, gtMine, 0, 0, 0, 0)
	AddGear(487, 860, gtMine, 0, 0, 0, 0)
	AddGear(488, 857, gtMine, 0, 0, 0, 0)
	AddGear(493, 810, gtMine, 0, 0, 0, 0)
	AddGear(494, 792, gtMine, 0, 0, 0, 0)
	AddGear(502, 648, gtMine, 0, 0, 0, 0)
	AddGear(1682, 960, gtMine, 0, 0, 0, 0)
	AddGear(1719, 973, gtMine, 0, 0, 0, 0)
	AddGear(1759, 990, gtMine, 0, 0, 0, 0)
	AddGear(1794, 1012, gtMine, 0, 0, 0, 0)
	AddGear(1742, 801, gtMine, 0, 0, 0, 0)
	AddGear(1708, 830, gtMine, 0, 0, 0, 0)
	AddGear(1677, 862, gtMine, 0, 0, 0, 0)
	
	AddGear(1491, 256, gtExplosives, 0, 0, 0, 0)
	AddGear(1734, 481, gtExplosives, 0, 0, 0, 0)
	AddGear(1491, 827, gtExplosives, 0, 0, 0, 0)
	AddGear(1588, 798, gtExplosives, 0, 0, 0, 0)
	AddGear(1166, 877, gtExplosives, 0, 0, 0, 0)
	AddGear(1205, 878, gtExplosives, 0, 0, 0, 0)
	AddGear(1245, 880, gtExplosives, 0, 0, 0, 0)
	AddGear(1184, 846, gtExplosives, 0, 0, 0, 0)
	AddGear(1228, 849, gtExplosives, 0, 0, 0, 0)
	AddGear(1210, 818, gtExplosives, 0, 0, 0, 0)

	SpawnSupplyCrate(1662, 471, amKamikaze)
	SpawnSupplyCrate(1425, 528, amLowGravity)
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
		"",missionIcon, 0)
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
end

function onAmmoStoreInit() PopulateCrates() end

function onNewTurn()
	CheckGivenTurn()
end

function onEndTurn()
end

function onGearAdd(gear) if GetGearType(gear) == gtHedgehog then trackGear(gear) end end

function onGearDelete(gear)	if GetGearType(gear) == gtHedgehog then trackDeletion(gear)	end end

function onHogRestore(gear)	if GetGearType(gear) == gtHedgehog then trackRestoring(gear) end end
function onHogHide(gear) if GetGearType(gear) == gtHedgehog then trackHiding(gear) end end

-- 
-- mission specific stuff
-- 