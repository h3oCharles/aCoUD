hhs = {}

function onGameInit()

	Map = "aCoUD-BathEdit"
	Theme = "Bath"

	ClearGameFlags()
	EnableGameFlags(gfSwitchHog, gfDivideTeams)

	CaseFreq = 3
	HealthCaseProb = 35
	HealthCaseAmount = 25
	MaxCaseDrops = 50

	MinesNum = 0
	Explosives = 0
	
	SuddenDeathTurns = 30
	WaterRise = 0
	HealthDecrease = 1

	AddMissionTeam(-1)
	for i = 1,4 do hhs[i] = AddMissionHog(100) end
	SetGearPosition(hhs[1],1356, 194)
	SetGearPosition(hhs[2],1012, 390)
	SetGearPosition(hhs[3],835, 390)
	SetGearPosition(hhs[4],656, 390)
	
	AddTeam("Youth", -2, "Old_Apple", "Flowerhog", "Mobster_qau", "cm_iluvu")
	hhs[5] = AddHog("Red",		4, 100, "cap_red")
	hhs[6] = AddHog("Blue",		4, 100, "cap_blue")
	hhs[7] = AddHog("Green",	4, 100, "cap_green")
	hhs[8] = AddHog("Yellow",	4, 100, "cap_yellow")
	SetGearPosition(hhs[5],2741, 194)
	SetGearPosition(hhs[6],3083, 390)
	SetGearPosition(hhs[7],3255, 390)
	SetGearPosition(hhs[8],3428, 390)
	for i = 5,8 do HogTurnLeft(hhs[i],true) end
end

function onAmmoStoreInit()
	--SetAmmo(ammoType, count, probability, delay, numberInCrate)
	SetAmmo(amSkip, 9, 0, 0, 0)
	
	SetAmmo(amGrenade, 9, 0, 0, 0)
	SetAmmo(amClusterBomb, 9, 0, 0, 0)
	SetAmmo(amBazooka, 9, 0, 0, 0)
	SetAmmo(amBee, 0, 0, 0, 0)
	SetAmmo(amShotgun, 0, 1, 0, 1)
	SetAmmo(amPickHammer, 0, 0, 0, 0)
	SetAmmo(amRope, 0, 0, 0, 0)
	SetAmmo(amMine, 0, 5, 0, 3)
	SetAmmo(amDEagle, 0, 1, 0, 1)
	SetAmmo(amDynamite, 0, 0, 0, 0)
	SetAmmo(amFirePunch, 9, 0, 0, 0)
	SetAmmo(amWhip, 0, 0, 0, 0)
	SetAmmo(amBaseballBat, 0, 5, 0, 1)
	SetAmmo(amParachute, 0, 3, 0, 1)
	SetAmmo(amAirAttack, 0, 0, 0, 0)
	SetAmmo(amMineStrike, 0, 0, 0, 0)
	SetAmmo(amBlowTorch, 0, 0, 0, 0)
	SetAmmo(amGirder, 0, 1, 0, 3)
	SetAmmo(amTeleport, 0, 0, 0, 0)
	SetAmmo(amSwitch, 0, 0, 0, 0)
	SetAmmo(amMortar, 9, 0, 0, 0)
	SetAmmo(amKamikaze, 0, 0, 0, 0)
	SetAmmo(amCake, 0, 0, 0, 0)
	SetAmmo(amSeduction, 0, 0, 0, 0)
	SetAmmo(amWatermelon, 1, 1, 8, 1)
	SetAmmo(amHellishBomb, 0, 0, 0, 0)
	SetAmmo(amNapalm, 0, 0, 0, 0)
	SetAmmo(amDrill, 0, 3, 0, 1)
	SetAmmo(amBallgun, 0, 1, 0, 1)
	SetAmmo(amRCPlane, 0, 0, 0, 0)
	SetAmmo(amLowGravity, 9, 0, 0, 0)
	SetAmmo(amExtraDamage, 0, 1, 0, 1)
	SetAmmo(amInvulnerable, 0, 0, 0, 0)
	SetAmmo(amExtraTime, 0, 1, 0, 1)
	SetAmmo(amLaserSight, 0, 1, 0, 1)
	SetAmmo(amVampiric, 0, 1, 0, 1)
	SetAmmo(amSniperRifle, 0, 1, 0, 1)
	SetAmmo(amJetpack, 0, 0, 0, 0)
	SetAmmo(amMolotov, 0, 1, 0, 1)
	SetAmmo(amBirdy, 0, 0, 0, 0)
	SetAmmo(amPortalGun, 0, 0, 0, 0)
	SetAmmo(amPiano, 0, 0, 0, 0)
	SetAmmo(amGasBomb, 0, 1, 0, 1)
	SetAmmo(amSineGun, 0, 0, 0, 0)
	SetAmmo(amFlamethrower, 0, 0, 0, 0)
	SetAmmo(amSMine, 0, 3, 0, 2)
	SetAmmo(amHammer, 0, 0, 0, 0)
	SetAmmo(amResurrector, 0, 5, 0, 1)
	SetAmmo(amDrillStrike, 0, 0, 0, 0)
	SetAmmo(amSnowball, 1, 5, 0, 1)
	SetAmmo(amTardis, 0, 0, 0, 0)
	SetAmmo(amLandGun, 1, 3, 0, 1)
	SetAmmo(amIceGun, 0, 0, 0, 0)
	SetAmmo(amKnife, 1, 3, 0, 2)
	SetAmmo(amRubber, 3, 5, 0, 2)
	SetAmmo(amAirMine, 0, 3, 0, 1)
	SetAmmo(amMinigun, 0, 3, 0, 1)
end

function onGameStart()
	ShowMission("Duck Rafts","Scenario","Eliminate the enemy.",-amCreeper, 0)
end

--[[

	"Eliminate the enemy." ..
	"|" ..
	" " ..
	"|" ..
	"Remember that full power shots are the most consistent."
	
]]--
