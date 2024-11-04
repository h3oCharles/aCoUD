HedgewarsScriptLoad("/Scripts/Multiplayer/HedgeEditor.lua")

local hhs = {}
turnNumber = -1

function onGameInit()

	--ClearGameFlags()
	EnableGameFlags(gfInfAttack)
	
	--EnableGameFlags(gfSharedAmmo)
	EnableGameFlags(gfDisableGirders, gfDisableLandObjects, gfOneClanMode)

	Map = "aCoUD-plane-trickshot-2"
	Theme = "Planes"
	Seed = "{c3fdb9c7-982f-4157-806c-10ff0182b1e5}"
	
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
	
	StartHealth = 100
	
	--[[
	AddTeam(loc("Charles' Brigade"), -1, "Badger", "Wood", "Mobster", "jamaica")
	hhs[1] = AddHog(loc("Charles"), 0, 100, "cap_team")]]--
	HumanTeam, HumanIndex = AddMissionTeam(-1)
	hhs[1] = AddMissionHog(StartHealth)
	SetGearPosition(hhs[1], 73, 971)
	
	AddTeam(loc("Drill Instructors"), -1, "deadhog", "Plane", "Pirate_qau", "cm_bazooka")
	hhs[2] = AddHog(loc("Sgt Quirion"), 0, StartHealth, "war_desertofficer")
	hhs[3] = AddHog(loc("Lauderback"), 0, StartHealth, "Gasmask")
	SetGearPosition(hhs[2], 178, 974)
	SetGearPosition(hhs[3], 1982, 966)
	HogTurnLeft(hhs[2], true)
	HogTurnLeft(hhs[3], true)
	SetTeamPassive(loc("Drill Instructors"), true)
	
	AddTeam(loc("Construction Workers"), -1, "Statue", "Castle", "Default_qau", "cm_girder")
	hhs[4] = AddHog(loc("Oliver"), 0, StartHealth, "constructor")
	hhs[5] = AddHog(loc("Gerry"), 0, StartHealth, "constructor")
	hhs[6] = AddHog(loc("Cornflake"), 0, StartHealth, "constructor")
	--hhs[7] = AddHog(loc("Mini"), 0, StartHealth, "constructor")
	SetGearPosition(hhs[4], 1350, 500)
	SetGearPosition(hhs[5], 789, 511)
	SetGearPosition(hhs[6], 1062, 870)
	--SetGearPosition(hhs[7], 1356, 509)
	--HogTurnLeft(hhs[4], true)
	HogTurnLeft(hhs[5], true)
	SetTeamPassive(loc("Construction Workers"), true)
end

function onGameStart()
--[[
	PlaceSprite(753, 519, sprAmGirder, 6, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)	--Gerry
	PlaceSprite(1388, 504, sprAmGirder, 6, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)	--Oliver
	--PlaceSprite(1415, 883, sprAmGirder, 6, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)	--Mini
	PlaceSprite(1103, 887, sprAmGirder, 6, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)	--Cornflake
	PlaceSprite(387, 978, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(485, 981, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(434, 934, sprAmGirder, 4, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(733, 933, sprAmGirder, 1, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(780, 887, sprAmGirder, 1, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(719, 870, sprAmGirder, 7, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(584, 662, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(584, 708, sprAmGirder, 6, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(582, 711, sprAmGirder, 4, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(1438, 1000, sprAmGirder, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1573, 1000, sprAmGirder, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1714, 998, sprAmGirder, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1330, 890, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1375, 945, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1384, 887, sprAmGirder, 5, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1574, 701, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1460, 694, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1517, 743, sprAmGirder, 4, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(561, 941, sprAmGirder, 6, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(630, 936, sprAmGirder, 6, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(597, 852, sprAmGirder, 4, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(591, 835, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(570, 836, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(614, 834, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(634, 836, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(656, 834, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(588, 818, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(637, 816, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(614, 815, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(616, 796, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(385, 917, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(484, 914, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(464, 914, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(411, 913, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(449, 913, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(426, 913, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(399, 894, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(469, 892, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(451, 890, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(427, 891, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(420, 871, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(455, 868, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(437, 869, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(435, 850, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1551, 980, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1584, 978, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1565, 961, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1697, 978, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1723, 980, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1435, 979, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1488, 722, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1542, 727, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(607, 689, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(752, 905, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1353, 912, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(750, 429, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1387, 414, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1101, 801, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(546, 836, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(562, 818, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(579, 796, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(598, 795, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(600, 774, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(1339, 857, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1318, 877, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(1321, 837, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1309, 861, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1293, 889, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1266, 890, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1281, 868, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1294, 842, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(1308, 819, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(1333, 815, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	--PlaceSprite(1319, 793, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1191, 554, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1249, 559, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(993, 588, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(948, 554, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(853, 522, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(902, 538, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(530, 578, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(571, 539, 140, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
]]--

	SetSoundMask(sndWarp, true)
	SetSoundMask(sndGraveImpact, true)
	SetSoundMask(sndGrenadeImpact, true)
	
	--ammoCrate = SpawnFakeAmmoCrate(1177, 552)
	--setGearValue(tempG, "contents", "amBazooka")
	--AddGear(968, 854, gtTarget, 0, 0, 0, 0)		--Cornflake
	--AddGear(1339, 877, gtTarget, 0, 0, 0, 0)	--Mini
	AddGear(1429, 506, gtTarget, 0, 0, 0, 0)	--Oliver
	AddGear(696, 510, gtTarget, 0, 0, 0, 0)		--Gerry
	AddGear(1163, 842, gtTarget, 0, 0, 0, 0)	--Cornflake new
	AddGear(1900, 961, gtTarget, 0, 0, 0, 0)	--Lauderback
	
	AddAmmo(hhs[1], amRCPlane, 100)
	AddAmmo(hhs[1], amSkip, 100)
	
	--[[for i = 1,#hhs do
		AddAmmo(hhs[i], amSkip, 100)
	end]]--
end

function onNewTurn()
	turnNumber = turnNumber + 1
	if turnNumber == 0 then
		SetSoundMask(sndWarp, false)
		SetSoundMask(sndGraveImpact, false)
		SetSoundMask(sndGrenadeImpact, false)
	end
end