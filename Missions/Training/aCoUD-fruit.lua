------ BEGIN SCRIPT ------
-- Copy and Paste this text into an empty text file, and save it as
-- YOURTITLEHERE.lua, in your Data/Missions/Training/ folder.

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")

local hhs = {}

function onGameInit()

	ClearGameFlags()
	EnableGameFlags(gfDisableWind, gfPerHogAmmo)
	Map = ""
	Seed = "{ac25f26e-9f28-4568-9259-6c5e1e488b51}"
	Theme = "Fruit"
	MapGen = 0
	MapFeatureSize = 12
	TemplateFilter = 3
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

	AddTeam(loc("Lemon And Lime"), -1, "Cherry", "Cake", "Surfer", "cm_banana_republic")
	hhs[9] = AddHog(loc("Lemon"), 0, 100, "fr_lemon")
	SetGearPosition(hhs[9], 2239, 1601)
	HogTurnLeft(hhs[9], true)
	hhs[10] = AddHog(loc("Lime"), 0, 100, "simple_green")
	SetGearPosition(hhs[10], 531, 1728)
	hhs[11] = AddHog(loc("Grapefruit"), 0, 100, "hair_pink")
	SetGearPosition(hhs[11], 3415, 1436)
	HogTurnLeft(hhs[11], true)
	hhs[12] = AddHog(loc("Orange"), 0, 100, "fr_orange")
	SetGearPosition(hhs[12], 2843, 1634)
	HogTurnLeft(hhs[12], true)
	hhs[13] = AddHog(loc("Apple"), 0, 100, "fr_apple")
	SetGearPosition(hhs[13], 770, 1332)
	hhs[14] = AddHog(loc("Pear"), 0, 100, "hair_green")
	SetGearPosition(hhs[14], 3180, 1582)
	HogTurnLeft(hhs[14], true)
	hhs[15] = AddHog(loc("Banana"), 0, 100, "fr_banana")
	SetGearPosition(hhs[15], 3416, 1766)
	HogTurnLeft(hhs[15], true)
	hhs[16] = AddHog(loc("Strawberry"), 0, 100, "cap_red")
	SetGearPosition(hhs[16], 1380, 1082)

	AddTeam(loc("Fruit"), -2, "Cherry", "Lonely_Island", "Default", "cpu")
	hhs[1] = AddHog(loc("Berry"), 1, 100, "fr_apple")
	SetGearPosition(hhs[1], 2029, 1691)
	hhs[2] = AddHog(loc("Pomelo"), 1, 100, "fr_lemon")
	SetGearPosition(hhs[2], 703, 1520)
	hhs[3] = AddHog(loc("Mango"), 1, 100, "fr_banana")
	SetGearPosition(hhs[3], 3617, 1486)
	HogTurnLeft(hhs[3], true)
	hhs[4] = AddHog(loc("Peach"), 1, 100, "fr_orange")
	SetGearPosition(hhs[4], 1026, 1686)
	hhs[5] = AddHog(loc("Plum"), 1, 100, "fr_apple")
	SetGearPosition(hhs[5], 2403, 1880)
	HogTurnLeft(hhs[5], true)
	hhs[6] = AddHog(loc("Kiwi"), 1, 100, "fr_banana")
	SetGearPosition(hhs[6], 2355, 1450)
	HogTurnLeft(hhs[6], true)
	hhs[7] = AddHog(loc("Apricot"), 1, 100, "fr_lemon")
	SetGearPosition(hhs[7], 3023, 1444)
	HogTurnLeft(hhs[7], true)
	hhs[8] = AddHog(loc("Fig"), 1, 100, "fr_orange")
	SetGearPosition(hhs[8], 2770, 1909)
	HogTurnLeft(hhs[8], true)


end

function LoadHogWeapons()









	AddAmmo(hhs[9], amAirAttack, 100)
	AddAmmo(hhs[9], amGirder, 100)
	AddAmmo(hhs[9], amRubber, 100)
	AddAmmo(hhs[9], amRope, 100)
	AddAmmo(hhs[9], amTeleport, 100)
	AddAmmo(hhs[9], amSwitch, 100)








end


function LoadSprite(pX, pY, pSprite, pFrame, pTint, p1, p2, p3, pLandFlags)
	PlaceSprite(pX, pY, pSprite, pFrame, pTint, p1, p2, p3, pLandFlags)
end


function LoadGearData()

	--BEGIN CORE DATA--

	------ PORTAL DISTANCE and UFO FUEL ------
	ufoFuel = 0
	portalDistance = 5000

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


end


--BEGIN HWMAP CONVERTER POINTS--
-- You can paste this data into the HWMAP converter if needed.
--[[

	5000 0 98

]]
--END HWMAP CONVERTER POINTS--

------ END GENERATED SCRIPT ------