HedgewarsScriptLoad("/Scripts/Multiplayer/HedgeEditor.lua")

local hhs = {}
--turnNumber = -1

function onGameInit()

	--ClearGameFlags()
	EnableGameFlags(gfInfAttack)
	EnableGameFlags(gfDisableWind,gfInfAttack)
	
	Map = "Tree"
	--Seed = "{44a250d1-e5a5-4663-84e9-6bb8af18e4f5}"
	Theme = "Halloween"

	TurnTime = 9999 * 1000
	
	Explosives = 0
	MinesNum = 0
	CaseFreq = 0
	Delay = 100
	HealthCaseProb = 35
	HealthCaseAmount = 25
	DamagePercent = 100
	RopePercent = 100
	MinesTime = 3000
	MineDudPercent  = 0
	SuddenDeathTurns = 50
	WaterRise = 0
	HealthDecrease = 0
	Ready = 5000
	AirMinesNum = 0
	GetAwayTime = 100
	WorldEdge = 0

	------ TEAM LIST ------

	--[[
	AddTeam(loc("Charles' Brigade"), -1, "Badger", "Wood", "Mobster", "jamaica")
	hhs[100] = AddHog(loc("Ninja"), 0, 24, "NinjaFull")
	]]--
	
	AddMissionTeam(-1)
	hhs[9] = AddMissionHog(1)
	SetGearPosition(hhs[9], 973, 126)
	--HogTurnLeft(hhs[100], true)
	
	AddTeam(loc("Team Nature"), -1, "flower", "Snail", "Default_qau", "cm_flower")
	hhs[10] = AddHog(loc("Squawk"),	0, 1, "crazyquills")
	SetGearPosition(hhs[10], 1102, 128)
	HogTurnLeft(hhs[10], true)
	SetTeamPassive(loc("Team Nature"), true)
	
	--AddTeam(loc("Bat-talion") .. " " .. loc("(cont.)"), -2, "Ghost", "Wood", "Default_qau", "cm_bat")
	AddTeam(loc("Bats to the Right"), -2, "Ghost", "Wood", "Default_qau", "cm_bat")
	hhs[3] = AddHog(loc("Echo"),		0, 100, "zoo_Bat")
	hhs[7] = AddHog(loc("Vesper"),		0, 100, "zoo_Bat")
	hhs[4] = AddHog(loc("Shadow"),		0, 100, "zoo_Bat")
	hhs[2] = AddHog(loc("Swoop"),		0, 100, "zoo_Bat")
	
	--AddTeam(loc("Bat-talion"), -2, "Ghost", "Wood", "Default_qau", "cm_bat")
	AddTeam(loc("Bats to the Left"), -2, "Ghost", "Wood", "Default_qau", "cm_bat")
	hhs[5] = AddHog(loc("Fang"),		0, 100, "zoo_Bat")
	hhs[6] = AddHog(loc("Luna"),		0, 100, "zoo_Bat")
	hhs[1] = AddHog(loc("Nocturna"),	0, 100, "zoo_Bat")
	hhs[8] = AddHog(loc("Dracul"),		0, 100, "zoo_Bat")
	
	
	SetGearPosition(hhs[1], 761, 621)
	SetGearPosition(hhs[2], 1300, 727)
	SetGearPosition(hhs[3], 1179, 334)
	SetGearPosition(hhs[4], 1259, 580)
	SetGearPosition(hhs[5], 768, 272)
	SetGearPosition(hhs[6], 703, 398)
	SetGearPosition(hhs[7], 1167, 434)
	SetGearPosition(hhs[8], 786, 785)
	HogTurnLeft(hhs[1], true)
	--HogTurnLeft(hhs[2], true)
	--HogTurnLeft(hhs[3], true)
	--HogTurnLeft(hhs[4], true)
	HogTurnLeft(hhs[5], true)
	HogTurnLeft(hhs[6], true)
	--HogTurnLeft(hhs[7], true)
	HogTurnLeft(hhs[8], true)
	SetTeamPassive(loc("Bats to the Left"), true)
	SetTeamPassive(loc("Bats to the Right"), true)
	--SetTeamPassive(loc("Bat-talion") .. " " .. loc("(cont.)"), true)

end

function onGameStart()

	AddAmmo(hhs[9], amSnowball, 100)
	AddAmmo(hhs[9], amRope, 100)
	AddAmmo(hhs[9], amParachute, 1)
	AddAmmo(hhs[9], amMine, 5)
	
	AddAmmo(hhs[9], amSkip, 100)

	tempG = AddGear(276, 840, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 1)
	tempG = AddGear(493, 158, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 1)

	tempG = AddGear(1763, 779, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 1)
	tempG = AddGear(1634, 812, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 1)
	tempG = AddGear(1759, 517, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 1)
	
	tempG = AddGear(1133, 442, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 10)
	
	tempG = AddGear(1364, 361, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 10)
	tempG = AddGear(550, 693, gtExplosives, 0, 0, 0, 0)	SetHealth(tempG, 10)
	
	tempG = AddGear(467, 764, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(530, 819, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(630, 808, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(1445, 385, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(1391, 414, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(1294, 421, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(323, 605, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(224, 382, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(543, 211, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(290, 436, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(505, 426, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	tempG = AddGear(244, 594, gtMine, 0, 0, 0, 0) SetTimer(tempG, 1000)
	
	tempG = AddGear(543, 211, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(290, 446, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(505, 440, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(244, 604, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1357, 274, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1445, 243, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1643, 219, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	
	tempG = AddGear(1733, 757, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1449, 563, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1579, 539, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1869, 500, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1704, 360, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1448, 716, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	tempG = AddGear(1580, 768, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)
	
	tempG = AddGear(1358, 413, gtMine, 0, 0, 0, 0)	SetTimer(tempG, 1000)

end

--[[
function onGearAdd(gear)
	if GetGearType(gear) == gtExplosives then SetHealth(gear, 1) end
	if GetGearType(gear) == gtMine then SetTimer(gear, 1 * 1000) end
end
]]--