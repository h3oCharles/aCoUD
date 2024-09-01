------ BEGIN SCRIPT ------
-- Copy and Paste this text into an empty text file, and save it as
-- YOURTITLEHERE.lua, in your Data/Missions/Training/ folder.

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")

local hhs = {}

function printDebug(message)
	WriteLnToConsole(message)
	WriteLnToChat(message)
end

function onGameInit()

	ClearGameFlags()
	EnableGameFlags(gfOneClanMode)
	
	Map = "Castle"
	Theme = "Castle"
	
	TurnTime = 45 * 1000
	Explosives = 0
	MinesNum = 0
	CaseFreq = 0
	Delay = 100
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

	------ TEAM LIST ------

	AddTeam(loc("Princess"), -1, "heart", "Castle", "Singer", "cm_heart")
	hhs[15] = AddHog(loc("Princess Mango"), 0, 100, "sm_peach")
	SetGearPosition(hhs[15], 341, 931)
	HogTurnLeft(hhs[15], false)
	SetTeamPassive(loc("Princess"), true)
	SetGearAIHints(hhs[15], aihDoesntMatter)
	
	AddMissionTeam(-1)
	hhs[16] = AddMissionHog(100)
	hhs[17] = AddMissionHog(100)
	hhs[18] = AddMissionHog(100)
	hhs[19] = AddMissionHog(100)
	SetGearPosition(hhs[16], 1807, 933)
	SetGearPosition(hhs[17], 1662, 932)
	SetGearPosition(hhs[18], 1740, 917)
	SetGearPosition(hhs[19], 1873, 961)
	HogTurnLeft(hhs[16], true)
	HogTurnLeft(hhs[17], true)
	HogTurnLeft(hhs[18], true)
	HogTurnLeft(hhs[19], true)
	
	AddTeam(loc("Guardian Angels"), -1, "ring", "Earth", "Default", "cm_bubbles")
	hhs[10] = AddHog(loc("Shine"), 1, 666, "angel")
	SetGearPosition(hhs[10], 1592, 204)
	HogTurnLeft(hhs[10], true)
	SetGearAIHints(hhs[10], aihDoesntMatter)
	
	--[[
	AddTeam(loc("Hedgehogland"), -1, "Grave", "Castle", "Default", "cm_bloodyblade")
	hhs[11] = AddHog(loc("Sir Quilliam"), 3, 100, "knight")
	hhs[12] = AddHog(loc("Lady Prickles"), 3, 100, "knight")
	hhs[13] = AddHog(loc("Sir Bramble"), 3, 100, "knight")
	hhs[14] = AddHog(loc("Sir Thornley"), 3, 100, "knight")
	SetGearPosition(hhs[11], 1850, 149)
	SetGearPosition(hhs[12], 1931, 154)
	SetGearPosition(hhs[13], 1958, 149)
	SetGearPosition(hhs[14], 1888, 154)
	HogTurnLeft(hhs[11], true)
	HogTurnLeft(hhs[12], true)
	HogTurnLeft(hhs[13], true)
	HogTurnLeft(hhs[14], true)
	]]--
	
	AddTeam(loc("Royalty"), -2, "dragonball", "Castle", "British", "cm_crown")
	hhs[1] = AddHog(loc("Actual King"), 1, 250, "crown")
	SetGearPosition(hhs[1], 827, 302)
	
	AddTeam(loc("Hogera"), -2, "Statue", "Castle", "British", "cm_swordshield")
	hhs[2] = AddHog(loc("Sir Thornblade"), 3, 100, "royalguard")
	hhs[3] = AddHog(loc("Lady Bramble"), 3, 100, "royalguard")
	hhs[4] = AddHog(loc("Sir Quillhelm"), 3, 100, "royalguard")
	hhs[5] = AddHog(loc("Squire Pinetuft"), 3, 100, "royalguard")
	hhs[6] = AddHog(loc("Dame Roseclaw"), 3, 100, "royalguard")
	hhs[7] = AddHog(loc("Sir Needlesworth"), 3, 100, "royalguard")
	hhs[8] = AddHog(loc("Lady Briarwing"), 3, 100, "royalguard")
	hhs[9] = AddHog(loc("Sir Thistlestone"), 3, 100, "royalguard")
	SetGearPosition(hhs[2], 1050, 709)
	SetGearPosition(hhs[3], 1165, 752)
	SetGearPosition(hhs[4], 712, 63)
	SetGearPosition(hhs[5], 813, 167)
	SetGearPosition(hhs[6], 575, 102)
	SetGearPosition(hhs[7], 1106, 787)
	SetGearPosition(hhs[8], 1239, 879)
	SetGearPosition(hhs[9], 870, 125)

end

function LoadHogWeapons()
	AddAmmo(hhs[16],amBazooka,100)
	AddAmmo(hhs[16],amBee,5)
	AddAmmo(hhs[16],amMortar,5)
	AddAmmo(hhs[16],amFlamethrower,1)
	
	AddAmmo(hhs[16],amGrenade,100)
	AddAmmo(hhs[16],amMolotov,2)
	
	AddAmmo(hhs[16],amShotgun,100)
	AddAmmo(hhs[16],amDEagle,2)
	AddAmmo(hhs[16],amMinigun,1)
	
	AddAmmo(hhs[16],amFirePunch,100)
	AddAmmo(hhs[16],amWhip,100)
	
	AddAmmo(hhs[16],amDynamite,1)
	AddAmmo(hhs[16],amSeduction,1)
	
	AddAmmo(hhs[16],amBlowTorch,3)
	AddAmmo(hhs[16],amGirder,3)
	
	AddAmmo(hhs[16],amSwitch,3)
	
	
	
	AddAmmo(hhs[10],amSniperRifle,100)
	AddAmmo(hhs[10],amWatermelon,100)
	
	for i = 1,2 do
		AddAmmo(hhs[i],amBazooka,100)
		AddAmmo(hhs[i],amGrenade,100)
		AddAmmo(hhs[i],amShotgun,100)
		AddAmmo(hhs[i],amSniperRifle,100)
		AddAmmo(hhs[i],amFirePunch,100)
		AddAmmo(hhs[i],amWhip,100)
	end
	AddAmmo(hhs[1],amWatermelon,100)
	
	
	
end

function LoadSprite(pX, pY, pSprite, pFrame, pTint, p1, p2, p3, pLandFlags)
	PlaceSprite(pX, pY, pSprite, pFrame, pTint, p1, p2, p3, pLandFlags)
end


function LoadGearData()

	--BEGIN CORE DATA--

	------ PORTAL DISTANCE and UFO FUEL ------
	ufoFuel = 0
	portalDistance = 5000

	------ GIRDER LIST ------
	LoadSprite(1570, 982, sprAmGirder, 4, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(1907, 988, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(305, 893, sprAmGirder, 7, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(351, 862, sprAmGirder, 5, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(1238, 909, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(1253, 938, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(1164, 782, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(1176, 813, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(1054, 734, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	LoadSprite(1066, 770, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)

	------ RUBBER LIST ------
	--LoadSprite(1903, 176, sprAmRubber, 0, U_LAND_TINT_NORMAL, nil, nil, nil, lfBouncy)

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
	
	if gear == hhs[1] then
		--printDebug("the king has died")
		for i = 2,9 do SetHealth(hhs[i],0) end
		DismissTeam(loc("Guardian Angels"))
	end
	
	if gear == hhs[15] then
		--printDebug("the king has died")
		for i = 16,19 do SetHealth(hhs[i],0) end
		DismissTeam(loc("Guardian Angels"))
		EndGameIn("failure")
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

	PreviewGirder(1570, 982, 4)
	PreviewGirder(1907, 988, 3)
	PreviewGirder(305, 893, 7)
	PreviewGirder(351, 862, 5)
	PreviewGirder(1238, 909, 3)
	PreviewGirder(1253, 938, 2)
	PreviewGirder(1164, 782, 3)
	PreviewGirder(1176, 813, 2)
	PreviewGirder(1054, 734, 3)
	PreviewGirder(1066, 770, 2)
	PreviewRubber(1903, 176, 0)

end

--BEGIN HWMAP CONVERTER POINTS--
-- You can paste this data into the HWMAP converter if needed.
--[[

	5000 0 98
	1570 982 104
	1907 988 103
	305 893 107
	351 862 105
	1238 909 103
	1253 938 102
	1164 782 103
	1176 813 102
	1054 734 103
	1066 770 102
	1903 176 124

]]
--END HWMAP CONVERTER POINTS--

------ END GENERATED SCRIPT ------