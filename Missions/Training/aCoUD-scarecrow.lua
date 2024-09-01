------ BEGIN SCRIPT ------
-- Copy and Paste this text into an empty text file, and save it as
-- YOURTITLEHERE.lua, in your Data/Missions/Training/ folder.

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")

local hhs = {}

function onGameInit()

	ClearGameFlags()
	EnableGameFlags(gfDisableWind,gfInfAttack)
	Map = "Tree"
	Seed = "{44a250d1-e5a5-4663-84e9-6bb8af18e4f5}"
	Theme = "Halloween"
	MapGen = 5
	MapFeatureSize = 12
	TemplateFilter = 2
	TemplateNumber = 0
	TurnTime = 9999000
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
	hhs[100] = AddMissionHog(1)
	SetGearPosition(hhs[100], 963, 11)
	--HogTurnLeft(hhs[100], true)
	
	AddTeam(loc("Bat-talion"), -2, "Ghost", "Wood", "Default_qau", "cm_bat")
	hhs[1] = AddHog(loc("Nocturna"),	5, 100, "zoo_Bat")
	hhs[2] = AddHog(loc("Swoop"),		5, 100, "zoo_Bat")
	hhs[3] = AddHog(loc("Echo"),		5, 100, "zoo_Bat")
	hhs[4] = AddHog(loc("Shadow"),		5, 100, "zoo_Bat")
	hhs[5] = AddHog(loc("Fang"),		5, 100, "zoo_Bat")
	hhs[6] = AddHog(loc("Luna"),		5, 100, "zoo_Bat")
	hhs[7] = AddHog(loc("Vesper"),		5, 100, "zoo_Bat")
	hhs[8] = AddHog(loc("Dracul"),		5, 100, "zoo_Bat")
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

end

function LoadHogWeapons()
	AddAmmo(hhs[100], amSnowball, 100)
	AddAmmo(hhs[100], amRope, 100)
	AddAmmo(hhs[100], amParachute, 1)
end


function LoadSprite(pX, pY, pSprite, pFrame, pTint, p1, p2, p3, pLandFlags)
	PlaceSprite(pX, pY, pSprite, pFrame, pTint, p1, p2, p3, pLandFlags)
end


function LoadGearData()

	--BEGIN CORE DATA--

	------ PORTAL DISTANCE and UFO FUEL ------
	ufoFuel = 0
	portalDistance = 5000

	------ BARREL LIST ------
	tempG = AddGear(1535, 750, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(1674, 750, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(1452, 549, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(1572, 525, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(1770, 517, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(1579, 392, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(1591, 223, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(1466, 229, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	tempG = AddGear(276, 840, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)
	--tempG = AddGear(557, 601, gtExplosives, 0, 0, 0, 0)
	--SetHealth(tempG, 1)
	--tempG = AddGear(484, 424, gtExplosives, 0, 0, 0, 0)
	--SetHealth(tempG, 1)
	--tempG = AddGear(328, 435, gtExplosives, 0, 0, 0, 0)
	--SetHealth(tempG, 1)
	tempG = AddGear(493, 158, gtExplosives, 0, 0, 0, 0)
	SetHealth(tempG, 1)

	------ MINE LIST ------
	tempG = AddGear(467, 764, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(530, 819, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(630, 808, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(1445, 385, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(1391, 414, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(1294, 421, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(323, 605, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(224, 382, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(543, 211, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(290, 436, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(505, 426, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)
	tempG = AddGear(244, 594, gtMine, 0, 0, 0, 0)
	SetTimer(tempG, 1000)

	------ TARGET LIST ------
	--tempG = AddGear(1094, 132, gtTarget, 0, 0, 0, 0)

	--END CORE DATA--

	LoadHogWeapons()

end


function onGameStart()

	LoadGearData()
	DetermineMissionGoal()

end


function onNewTurn()
	--insert code according to taste
end


function onGameTick()
	runOnGears(UpdateTagCircles)
end

function UpdateTagCircles(gear)
	if getGearValue(gear,"tag") ~= nil then
		if getGearValue(gear,"tCirc") == nil then
			setGearValue(gear, "tCirc",AddVisualGear(0,0,vgtCircle,0,true))
		end

		if getGearValue(gear,"tag") == "victory" then
			SetVisualGearValues(getGearValue(gear,"tCirc"), GetX(gear), GetY(gear), 100, 255, 1, 10, 0, 150, 3, 0xff0000ff)
		elseif getGearValue(gear,"tag") == "failure" then
			SetVisualGearValues(getGearValue(gear,"tCirc"), GetX(gear), GetY(gear), 100, 255, 1, 10, 0, 150, 3, 0x00ff00ff)
		elseif getGearValue(gear,"tag") == "collection" then
			SetVisualGearValues(getGearValue(gear,"tCirc"), GetX(gear), GetY(gear), 100, 255, 1, 10, 0, 150, 3, 0x0000ffff)
		end
	end
end

function CheckForConditions(gear)
	if getGearValue(gear,"tag") == "victory" then
		victoryObj = victoryObj +1
	elseif getGearValue(gear,"tag") == "failure" then
		failObj = failObj +1
	elseif getGearValue(gear,"tag") == "collection" then
		collectObj = collectObj +1
	end
end

function CheckForConclusion(gear)

	if getGearValue(gear,"tag") == "failure" then 
		EndGameIn("failure")
	else 

		victoryObj = 0
		failObj = 0
		collectObj = 0
		runOnGears(CheckForConditions)

		if GetGearType(gear) ~= gtCase then

			victoryObj = victoryObj - 1 

			if (victoryObj == 0) and (collectObj == 0) then
				EndGameIn("victory")
			end

		else

			if (GetGearMessage(gear) == 256) and (getGearValue(gear,"tag") == "collection") then 
				if GetHogLevel(CurrentHedgehog) ~= 0 then
					EndGameIn("failure")
				else
					collectObj = collectObj - 1
					if (victoryObj == 0) and (collectObj == 0) then
						EndGameIn("victory")
					end
				end
			elseif (GetGearMessage(gear) == 0) and (getGearValue(gear,"tag") == "victory") then
				victoryObj = victoryObj - 1
				if (victoryObj == 0) and (collectObj == 0) then 
					EndGameIn("victory")
				end
			else
				EndGameIn("failure")
			end

		end

	end

end

function DetermineMissionGoal()

	victoryObj = 0
	failObj = 0
	collectObj = 0
	vComment = ""
	fComment = ""
	collectComment = ""

	runOnGears(CheckForConditions)

	if victoryObj > 0 then 
		if victoryObj == 1 then 
			vComment = loc("- Destroy the red target") .. "|"
		else 
			vComment = loc("- Destroy the red targets") .. "|"
		end
	end

	if collectObj > 0 then 
		if collectObj == 1 then 
			collectComment = loc("- Collect the blue crate") .. "|"
		else 
			collectComment = loc("- Collect all the blue crates") .. "|"
		end
	end

	if (collectObj == 0) and (victoryObj == 0) then
		vComment = loc("- Destroy the enemy") .. "|"
	end

	if failObj > 0 then 
		if failObj == 1 then 
			fComment = loc("- The green target must survive") .. "|"
		else 
			fComment = loc("- The green targets must survive") .. "|"
		end
	end

	ShowMission(loc("User Mission"), loc("Mission"), collectComment .. vComment .. fComment, 1, 0)

end

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


function onGearAdd(gear)
	if isATrackedGear(gear) then
		trackGear(gear)
	end
	
	if GetGearType(gear) == gtFlame then DeleteGear(gear) end
end


function EndGameIn(c)

	teamCounter = 0
	lastRecordedTeam = "" 
	for i = 1, #hhs do

		if GetHogTeamName(hhs[i]) ~= lastRecordedTeam then --er, is this okay without nill checks?

			lastRecordedTeam = GetHogTeamName(hhs[i])
			teamCounter = teamCounter + 1
			if teamCounter == 9 then
				teamCounter = 1
			end

			if (c ==  "victory") and (GetHogLevel(hhs[i]) ~= 0) then
				DismissTeam(GetHogTeamName(hhs[i]))
				AddCaption(loc("Victory!"), capcolDefault, capgrpGameState)
				ShowMission(loc("User Mission"), loc("Mission"), loc("Mission succeeded!"), 0, 0)
			elseif (c ==  "failure") and (GetHogLevel(hhs[i]) == 0) then
				DismissTeam(GetHogTeamName(hhs[i]))
				AddCaption(loc("Defeat!"), capcolDefault, capgrpGameState)
				ShowMission(loc("User Mission"), loc("Mission"), loc("Mission failed!"), -amSkip, 0)
			elseif (c ==  "victory") and (GetHogLevel(hhs[i]) == 0) then
				PlaySound(sndVictory,hhs[i]) -- check if we actually need this
			end

		end

	end

end


function onGearDelete(gear)

	--insert code according to taste

	if isATrackedGear(gear) then

		if getGearValue(gear,"tag") ~= nil then
			CheckForConclusion(gear)
		end

		if getGearValue(gear, "tCirc") ~= nil then
			DeleteVisualGear(getGearValue(gear, "tCirc"))
		end

		trackDeletion(gear)

	end

end


--enable and/or alter code according to taste
function onAmmoStoreInit()

	for i = 0, AmmoTypeMax do
		if i ~= amNothing then
			SetAmmo(i, 0, 0, 0, 1)
		end
	end

	SetAmmo(amSkip, 9, 0, 0, 0)

end

------ END GENERATED MISSION ------

function GeneratePreviewData()

	PreviewPlacedGear(1535, 750)
	PreviewPlacedGear(1674, 750)
	PreviewPlacedGear(1452, 549)
	PreviewPlacedGear(1572, 525)
	PreviewPlacedGear(1770, 517)
	PreviewPlacedGear(1579, 392)
	PreviewPlacedGear(1591, 223)
	PreviewPlacedGear(1466, 229)
	PreviewPlacedGear(276, 840)
	PreviewPlacedGear(557, 601)
	PreviewPlacedGear(484, 424)
	PreviewPlacedGear(328, 435)
	PreviewPlacedGear(493, 158)
	PreviewPlacedGear(640, 228)

end


--BEGIN HWMAP CONVERTER POINTS--
-- You can paste this data into the HWMAP converter if needed.
--[[

	5000 0 98
	1094 132 14
	467 764 2
	530 819 2
	630 808 2
	1445 385 2
	1391 414 2
	1294 421 2
	323 605 2
	224 382 2
	543 211 2

]]
--END HWMAP CONVERTER POINTS--

------ END GENERATED SCRIPT ------