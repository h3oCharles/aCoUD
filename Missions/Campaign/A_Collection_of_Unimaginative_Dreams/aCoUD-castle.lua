-- 
-- load scripts
-- 

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")
HedgewarsScriptLoad("/Scripts/Animate.lua")

HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/generic.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/circles.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/giveturn.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/finish.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/soundmasks.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/counthogs.lua")

-- 
-- vars
-- 

missionName = "Castle"
missionIcon = -amSeduction
missionID = 1

turnCounter = -1

player = {}
helper = {}
enemy = {}

Heaven = true

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
	Map = "aCoUD-CastleEdit"
	Theme = "Castle"
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
	SetGearPosition(player[1], 1807, 933)
	SetGearPosition(player[2], 1662, 932)
	SetGearPosition(player[3], 1740, 917)
	SetGearPosition(player[4], 1873, 961)
	HogTurnLeft(player[1], true)
	HogTurnLeft(player[2], true)
	HogTurnLeft(player[3], true)
	HogTurnLeft(player[4], true)
	
	PrincessTeam,PrincessIndex = AddTeam(loc("Princess"), -1, "heart", "Flowerhog", "Singer_qau", "cm_heart")
	princess = AddHog(loc("Princess Mango"), 0, 100, "sm_peach")
	SetGearPosition(princess, 341, 931)
	HogTurnLeft(princess, false)
	SetTeamPassive(PrincessTeam, true)
	SetGearAIHints(princess, aihDoesntMatter)
	
	AngelTeam,AngelIndex = AddTeam(loc("Guardian Angels"), -1, "ring", "Earth", "Default_qau", "cm_bubbles")
	angel = AddHog(loc("Shine"), 1, 666, "angel")
	SetGearPosition(angel, 1592, 204)
	HogTurnLeft(angel, true)
	SetGearAIHints(angel, aihDoesntMatter)

	HelperTeam,HelperIndex = AddTeam(loc("Hedgehogland"), -1, "Statue", "Castle", "Default_qau", "cm_bloodyblade")
	helper[1] = AddHog(loc("Sir Quilliam"), 3, 100, "knight")
	helper[2] = AddHog(loc("Lady Prickles"), 3, 100, "knight")
	helper[3] = AddHog(loc("Sir Bramble"), 3, 100, "knight")
	helper[4] = AddHog(loc("Sir Thornley"), 3, 100, "knight")
	SetGearPosition(helper[1], 1807, 933-32)
	SetGearPosition(helper[2], 1662, 932-32)
	SetGearPosition(helper[3], 1740, 917-32)
	SetGearPosition(helper[4], 1873, 961-32)
	HogTurnLeft(helper[1], true)
	HogTurnLeft(helper[2], true)
	HogTurnLeft(helper[3], true)
	HogTurnLeft(helper[4], true)
	
	KingTeam,KingIndex = AddTeam(loc("Royalty"), -2, "dragonball", "Castle", "British_qau", "cm_crown")
	king = AddHog(loc("Actual King"), 1, 250, "crown")
	SetGearPosition(king, 827, 302)
	
	EnemyTeam,EnemyIndex = AddTeam(loc("Hogera"), -2, "Grave", "Castle", "British_qau", "cm_swordshield")
	enemy[1] = AddHog(loc("Sir Thornblade"), 3, 100, "royalguard")
	enemy[2] = AddHog(loc("Lady Bramble"), 3, 100, "royalguard")
	enemy[3] = AddHog(loc("Sir Quillhelm"), 3, 100, "royalguard")
	enemy[4] = AddHog(loc("Squire Pinetuft"), 3, 100, "royalguard")
	enemy[5] = AddHog(loc("Dame Roseclaw"), 3, 100, "royalguard")
	enemy[6] = AddHog(loc("Sir Needlesworth"), 3, 100, "royalguard")
	enemy[7] = AddHog(loc("Lady Briarwing"), 3, 100, "royalguard")
	enemy[8] = AddHog(loc("Sir Thistlestone"), 3, 100, "royalguard")
	SetGearPosition(enemy[1], 1050, 709)
	SetGearPosition(enemy[2], 1165, 752)
	SetGearPosition(enemy[3], 712, 63)
	SetGearPosition(enemy[4], 813, 167)
	SetGearPosition(enemy[5], 575, 102)
	SetGearPosition(enemy[6], 1106, 787)
	SetGearPosition(enemy[7], 1239, 879)
	SetGearPosition(enemy[8], 870, 125)
end

function onGivenTurn()
	SetTeamPassive(PrincessTeam,true)
	if enemyHogs == 0 then SetTeamPassive(HelperTeam,true) end
end

function SetupWeapons()
	for i = 1,#player do
		AddAmmo(player[i],amBazooka,100)
		AddAmmo(player[i],amBee,5)
		AddAmmo(player[i],amMortar,5)
		AddAmmo(player[i],amFlamethrower,1)
		AddAmmo(player[i],amGrenade,100)
		AddAmmo(player[i],amMolotov,2)
		AddAmmo(player[i],amShotgun,100)
		AddAmmo(player[i],amDEagle,2)
		AddAmmo(player[i],amMinigun,1)
		AddAmmo(player[i],amFirePunch,100)
		AddAmmo(player[i],amWhip,100)
		AddAmmo(player[i],amBaseballBat,1)
		AddAmmo(player[i],amDynamite,1)
		AddAmmo(player[i],amSeduction,1)
		AddAmmo(player[i],amBlowTorch,3)
		AddAmmo(player[i],amGirder,3)
		AddAmmo(player[i],amParachute,100)
		AddAmmo(player[i],amSwitch,3)
		
		AddAmmo(player[i],amSnowball,100)
		AddAmmo(player[i],amWatermelon,100)
		AddAmmo(player[i],amRope,100)
		AddAmmo(player[i],amTeleport,100)
		AddAmmo(player[i],amGirder,100)
	end
	
	for i = 1,#helper do
		AddAmmo(helper[i],amBazooka,100)
		AddAmmo(helper[i],amMortar,100)
		AddAmmo(helper[i],amGrenade,100)
		AddAmmo(helper[i],amShotgun,100)
		AddAmmo(helper[i],amDEagle,100)
		AddAmmo(helper[i],amFirePunch,100)
		AddAmmo(helper[i],amWhip,100)
	end
	
	AddAmmo(angel,amBazooka,100)
	AddAmmo(angel,amMortar,100)
	AddAmmo(angel,amGrenade,100)
	AddAmmo(angel,amWatermelon,100)
	AddAmmo(angel,amShotgun,100)
	AddAmmo(angel,amDEagle,100)
	AddAmmo(angel,amSniperRifle,100)
	AddAmmo(angel,amMinigun,100)
	AddAmmo(angel,amFirePunch,100)
	AddAmmo(angel,amWhip,100)
	
	for i = 1,#enemy do
		AddAmmo(enemy[i],amBazooka,100)
		AddAmmo(enemy[i],amGrenade,100)
		AddAmmo(enemy[i],amShotgun,100)
		AddAmmo(enemy[i],amSniperRifle,100)
		AddAmmo(enemy[i],amFirePunch,100)
		AddAmmo(enemy[i],amWhip,100)
	end
	
	AddAmmo(king,amWatermelon,100)
	AddAmmo(king,amBazooka,100)
	AddAmmo(king,amGrenade,100)
	AddAmmo(king,amShotgun,100)
	AddAmmo(king,amSniperRifle,100)
	AddAmmo(king,amFirePunch,100)
	AddAmmo(king,amWhip,100)
	
	AddAmmo(princess,amSeduction,100)
	AddAmmo(princess,amResurrector,100)
	
end

function SetupSprites()
	--two girders next to rocks
	PlaceSprite(1570, 1005, sprAmGirder, 0, U_LAND_TINT_INDESTRUCTIBLE, nil, nil, nil, lfIndestructible)
	PlaceSprite(1950, 950, sprAmGirder, 3, U_LAND_TINT_INDESTRUCTIBLE, nil, nil, nil, lfIndestructible)
	
	--princess cage
	PlaceSprite(305, 893, sprAmGirder, 7, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(351, 862, sprAmGirder, 5, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	
	--enemy fortifications
	PlaceSprite(1238, 909, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1253, 938, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1164, 782, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1176, 813, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1054, 734, sprAmGirder, 3, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
	PlaceSprite(1066, 770, sprAmGirder, 2, U_LAND_TINT_NORMAL, nil, nil, nil, lfNormal)
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
	{func = AnimSay, args = {player[1], "...", SAY_THINK, 3*1000}},
	{func = AnimSay, args = {princess, "HELP!", SAY_SHOUT, 3*1000}},
	{func = AnimSay, args = {player[1], "...!", SAY_THINK, 3*1000}}
	}
	local function SkipIntro() end
	AddSkipFunction(animIntro, SkipIntro, {})
	local function AfterIntro()
		ShowMission(missionName, "Objectives",
		"Eliminate the enemy.".."|"..
		"Escort the Princess to your starting position.".."|"..
		" ".."|"..
		"Hint: Focus on getting to the Princess, as Shine will focus on the enemy.".."|"..
		"",missionIcon, 0)
		GiveTurn(PlayerTeam)
		AddEvent(checkReinforcements, {}, doReinforcements, {}, 0)
		AddEvent(checkPrincess, {}, doPrincess, {}, 0)
		AddEvent(checkWin, {}, doWin, {}, 0)
	end
    AddFunction({func = AfterIntro, args = {}})
	AddAnim(animIntro)
end

function animReinforcements()
		animReinforcements = {
		{func = AnimFollowGear, args = {triggered}},
		{func = AnimWait, args = {a,2.5*1000}},
		{func = AnimSay, args = {triggered, "...?", SAY_THINK, 3*1000}},
		
		{func = RestoreHog, args = {helper[2]}},
		{func = AnimOutOfNowhere, args = {helper[2]}},
		{func = AnimTurn, args = {helper[2],"Left"}},
		{func = AnimWait, args = {a,0.5*1000}},
		
		{func = RestoreHog, args = {helper[3]}},
		{func = AnimOutOfNowhere, args = {helper[3]}},
		{func = AnimTurn, args = {helper[3],"Left"}},
		{func = AnimWait, args = {a,0.5*1000}},
		
		{func = RestoreHog, args = {helper[1]}},
		{func = AnimOutOfNowhere, args = {helper[1]}},
		{func = AnimTurn, args = {helper[1],"Left"}},
		{func = AnimWait, args = {a,0.5*1000}},
		
		{func = RestoreHog, args = {helper[4]}},
		{func = AnimOutOfNowhere, args = {helper[4]}},
		{func = AnimTurn, args = {helper[4],"Left"}},
		{func = AnimWait, args = {a,0.5*1000}},
		
		{func = AnimSay, args = {helper[3], "FOR HEDGEHOGLAND!!!", SAY_SHOUT, 1.5*1000}},
		{func = AnimSay, args = {triggered, "...?!", SAY_THINK, 3*1000}},
		}
		local function SkipReinforcements()
			for i = 1,#helper do
				RestoreHog(helper[i])
				HogTurnLeft(helper[i],true)
			end
		end
		AddSkipFunction(animReinforcements, SkipReinforcements, {})
		
		local function AfterReinforcements()
			if enemyHogs == 0 then
				--EndTurn(true)
				GiveTurn(PlayerTeam,triggered)
				SetTeamPassive(HelperTeam,true)
			else
				GiveTurn(HelperTeam)
			end
		end
		AddFunction({func = AfterReinforcements, args = {}})
		AddAnim(animReinforcements)
		cutsceneAllies = false
end

function animPrincess()
	animPrincess = {
		{func = AnimFollowGear, args = {triggered}},
		{func = AnimWait, args = {a,2.5*1000}},
		{func = AnimSay, args = {princess, "Oh my goodness, it's so good to see you"..", "..GetHogName(triggered).."!", SAY_SAY, 3*1000}},
		{func = AnimSay, args = {triggered, "...!", SAY_SAY, 4.5*1000}},
		{func = AnimSay, args = {triggered, "...?", SAY_SAY, 3*1000}},
		{func = AnimSay, args = {princess, "Oh, right...", SAY_SAY, 3*1000}},
		{func = AnimSay, args = {princess, "Here, take these supplies!", SAY_SAY, 3*1000}}
		}
		local function SkipPrincess()
		end
		AddSkipFunction(animPrincess, SkipPrincess, {})
		
		local function AfterPrincess()
			--SpawnSupplyCrate(92, 970,	amExtraTime, 1)
			SpawnSupplyCrate(133, 954,	amSnowball, 100)
			SpawnSupplyCrate(177, 945,	amGirder, 10)
			SpawnSupplyCrate(219, 940,	amSwitch, 100)
			--SpawnSupplyCrate(425, 888,	amExtraTime, 1)
			--SpawnSupplyCrate(466, 883,	amExtraTime, 1)
			--SpawnSupplyCrate(506, 868,	amExtraTime, 1)
			--SpawnSupplyCrate(544, 832,	amExtraTime, 1)
			--SpawnSupplyCrate(571, 804,	amExtraTime, 1)
			GiveTurn(PlayerTeam,triggered)
		end
		AddFunction({func = AfterPrincess, args = {}})
		AddAnim(animPrincess)
		cutscenePrincess = false
end

function animWin()
	animWin = {
		{func = AnimFollowGear, args = {triggered}},
		{func = AnimWait, args = {a,2.5*1000}},
		{func = AnimSay, args = {princess, "At last, I'm safe!", SAY_SHOUT, 3*1000}},
		{func = AnimSay, args = {princess, "Thank you"..", "..GetHogName(triggered).."!", SAY_SAY, 3*1000}},
		{func = AnimSay, args = {triggered, "...", SAY_SAY, 3*1000}},
		{func = AnimSay, args = {princess, "You are My Hero!", SAY_SHOUT, 3*1000}},
		{func = AnimSay, args = {triggered, "...!", SAY_SAY, 3*1000}},
		{func = AnimSay, args = {princess, "Okay, okay, fine...", SAY_SAY, 3*1000}},
		{func = AnimSay, args = {princess, "You are all My Heroes! tee-hee~~", SAY_SAY, 3*1000}}
		}
	local function SkipWin()
	end
	AddSkipFunction(animWin, SkipWin, {})
	local function AfterWin()
		--DisableGameFlags(gfOneClanMode)
		ConcludeGame(true)
	end
	AddFunction({func = AfterWin, args = {}})
	AddAnim(animWin)
end

--
-- events
--

function checkPrincess()
	if	GetHogTeamName(CurrentHedgehog) == PlayerTeam and
		TestForGearInsideCircle(CurrentHedgehog, PrincessCircle) == true then
		return true
	end
end

function doPrincess()
	CutsceneTriggered()
	triggered = CurrentHedgehog
	cutscenePrincess = true
end

--

function checkWin()
	pdx,pdy = GetGearVelocity(princess)
	if	TestForGearInsideCircle(princess, RockCircle) == true and
		pdx == 0 and
		pdy == 0 then
		return true
	end
end

function doWin()
	--CutsceneTriggered()
	triggered = CurrentHedgehog
	--cutsceneWin = true
	animWin()
end

--

function checkReinforcements()
	if	GetHogTeamName(CurrentHedgehog) == PlayerTeam and
		gearIsInBox(CurrentHedgehog, middleOfCastle-10, -1024, 20, 2048) == true then
		return true
	end
end

function doReinforcements()
	CutsceneTriggered()
	triggered = CurrentHedgehog
	cutsceneAllies = true
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
	if Heaven == true then runOnHogs(HeadInTheClouds) end
	SetCirclePosition(PrincessCircle, GetX(princess), GetY(princess))
end

function onPrecise() AnimationSkipping() end

function onGameStart()
	SetupSprites()
	SetupWeapons()
	trackTeams()
	CountHogs()
	
	for i = 1,#helper do HideHog(helper[i]) end
	
	CloudCircle = AddCircle(1535,310,300,3,0xFFFFFF00)
	PrincessCircle = AddCircle(340,930,100,3,0xFF808000)
	RockCircle = AddCircle(1740,917,100,3,0x80808000)
	
	middleOfCastle = 817
	--testline = AddVisualGear(0,0,vgtLineTrail,0,true)
	--SetVisualGearValues(testline, middleOfCastle, -LAND_HEIGHT, middleOfCastle, LAND_HEIGHT*2, nil, nil, nil, nil, 2147483647, 0, nil)
end

function onAmmoStoreInit() PopulateCrates() end

function onNewTurn()
	CheckGivenTurn()
	SoundMasks(0)
	
	if		cutsceneAllies		== true then animReinforcements()
	elseif	cutscenePrincess	== true then animPrincess()
	end
	
	if GetHogTeamName(CurrentHedgehog) == HelperTeam and enemyHogs == 0 then
		SkipTurn()
		SetTeamPassive(HelperTeam,true)
	end
	
	turnCounter = turnCounter + 1
	if turnCounter ~= 0 and turnCounter % 2 == 1 then
		HealHog(princess, 100-GetHealth(princess))
	elseif turnCounter ~= 0 and turnCounter % 2 == 0 then
		runOnHogsInTeam(PrincessHeal, PlayerTeam)
		runOnHogsInTeam(PrincessHeal, HelperTeam)
	end
end

function onEndTurn() SoundMasks(1) end

function onGearAdd(gear) if GetGearType(gear) == gtHedgehog then trackGear(gear) end end

function onGearDelete(gear)
	if GetGearType(gear) == gtHedgehog then
		trackDeletion(gear)
		clan = GetHogClan(gear)
		isHogFromPlayerTeam = GetHogTeamName(gear) == PlayerTeam
		UpdateCounts()
		
		if gear == king then HeavenGone() for i = 1,#enemy do SetHealth(enemy[i],0) end end

		if gear == princess then
			--ConcludeGame(false)
			EndTurn(true)
			SetTeamPassive(PlayerTeam,true)
			SetTeamPassive(PrincessTeam,true)
			SetTeamPassive(AngelTeam,true)
			SetTeamPassive(HelperTeam,true)
			DisableGameFlags(gfOneClanMode)
		end
	
		if gear == angel and Heaven == true then HeavenGone() end
	end
end

function onHogRestore(gear)	if GetGearType(gear) == gtHedgehog then trackRestoring(gear) end end
function onHogHide(gear) if GetGearType(gear) == gtHedgehog then trackHiding(gear) end end

-- 
-- mission specific stuff
-- 

function HeadInTheClouds(gear) TestForStateOfGearInsideCircle(gear,CloudCircle) end

function PrincessHeal(gear)
	if TestForGearInsideCircle(gear, PrincessCircle) == true then
		HealHog(gear, 100-GetHealth(gear))
	end
end

function HeavenGone()
	if angel ~= nil then
		SetGearCollisionMask(angel, 0x0000)
		Explode(1535,310,300,EXPLNoGfx+EXPLDoNotTouchAny+EXPLNoDamage)
		DeleteCircle(CloudCircle)
		Heaven = false
	end
end

function onGearInsideCircle(gear, circle)
	if GetGearType(gear) == gtHedgehog and circle == CloudCircle and gear ~= angel then
		SetGearCollisionMask(gear, 0x0000)
	end
end

function onGearOutsideCircle(gear, circle)
	if GetGearType(gear) == gtHedgehog and circle == CloudCircle and gear ~= angel then
		SetGearCollisionMask(gear, 0xFFFF)
	end
end