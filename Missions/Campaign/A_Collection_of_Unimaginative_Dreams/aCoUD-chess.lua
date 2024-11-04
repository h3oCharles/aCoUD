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

-- 
-- vars
-- 

missionName = "Template"
missionID = -1

--local hhs = {}

turnCounter = -1

player = {}
white = {}
black = {}

humanHogs = 0

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
	Map = "Chess_v3"
	Theme = "Chess_v3"
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
	
	WPieceTeam,WPieceIndex = AddTeam(loc("White Pieces"), 0xddba56, "Simple", "Plane", "Default_qau", "norway")
	white[1] = AddHog(loc("White Queenside Rook"), 3, 100, "TeamSoldier")
	white[2] = AddHog(loc("White Queenside Knight"), 3, 100, "TeamSoldier")
	white[3] = AddHog(loc("White Dark-Squared Bishop")	, 3, 100, "TeamSoldier")
	white[4] = AddHog(loc("White Queen"), 3, 100, "TeamSoldier")
	white[5] = AddHog(loc("White King"), 3, 100, "TeamSoldier")
	white[6] = AddHog(loc("White Light-Squared Bishop"), 3, 100, "TeamSoldier")
	white[7] = AddHog(loc("White Kingside Knight"), 3, 100, "TeamSoldier")
	white[8] = AddHog(loc("White Kingside Rook"), 3, 100, "TeamSoldier")
	
	WPawnTeam,WPawnIndex = AddTeam(loc("White Pawns"), 0xddba56, "Simple", "Plane", "Default_qau", "norway")
	white[9]  = AddHog(loc("White a-Pawn"), 3, 100, "cap_team")
	white[10] = AddHog(loc("White b-Pawn"), 3, 100, "cap_team")
	white[11] = AddHog(loc("White c-Pawn"), 3, 100, "cap_team")
	white[12] = AddHog(loc("White d-Pawn"), 3, 100, "cap_team")
	white[13] = AddHog(loc("White e-Pawn"), 3, 100, "cap_team")
	white[14] = AddHog(loc("White f-Pawn"), 3, 100, "cap_team")
	white[15] = AddHog(loc("White g-Pawn"), 3, 100, "cap_team")
	white[16] = AddHog(loc("White h-Pawn"), 3, 100, "cap_team")
	
	BPieceTeam,BPieceIndex = AddTeam(loc("Black Pieces"), 0x8b670d, "Simple", "Plane", "Default_qau", "united_states")
	black[1] = AddHog(loc("Black Queenside Rook"), 3, 100, "TeamSoldier")
	black[2] = AddHog(loc("Black Queenside Knight"), 3, 100, "TeamSoldier")
	black[3] = AddHog(loc("Black Dark-Squared Bishop"), 3, 100, "TeamSoldier")
	black[4] = AddHog(loc("Black Queen"), 3, 100, "TeamSoldier")
	black[5] = AddHog(loc("Black King"), 3, 100, "TeamSoldier")
	black[6] = AddHog(loc("Black Light-Squared Bishop")	, 3, 100, "TeamSoldier")
	black[7] = AddHog(loc("Black Kingside Knight"), 3, 100, "TeamSoldier")
	black[8] = AddHog(loc("Black Kingside Rook"), 3, 100, "TeamSoldier")
	
	WPawnsTeam,WPawnsIndex = AddTeam(loc("Black Pawns"), 0x8b670d, "Simple", "Plane", "Default_qau", "united_states")
	black[9]  = AddHog(loc("Black a-Pawn"), 3, 100, "cap_team")
	black[10] = AddHog(loc("Black b-Pawn"), 3, 100, "cap_team")
	black[11] = AddHog(loc("Black c-Pawn"), 3, 100, "cap_team")
	black[12] = AddHog(loc("Black d-Pawn"), 3, 100, "cap_team")
	black[13] = AddHog(loc("Black e-Pawn"), 3, 100, "cap_team")
	black[14] = AddHog(loc("Black f-Pawn"), 3, 100, "cap_team")
	black[15] = AddHog(loc("Black g-Pawn"), 3, 100, "cap_team")
	black[16] = AddHog(loc("Black h-Pawn"), 3, 100, "cap_team")

end

function onGivenTurn()
	--SetTeamPassive(PrincessTeam,true)
end

function SetupWeapons()
	for i = 1,#player do
		AddAmmo(player[i],amBazooka,100)
	end
	
	--for i = 1,#enemy do
	--	AddAmmo(enemy[i],amGrenade,100)
	--end
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
	{func = AnimWait, args = {a,2.5*1000}},
	{func = AnimSay, args = {player[1], "...?", SAY_THINK, 3*1000}}
	}
	local function SkipIntro() end
	AddSkipFunction(animIntro, SkipIntro, {})
	local function AfterIntro()
		ShowMission(missionName, "Objectives",
		"Eliminate the enemy.".."|"..
		"",-amBazooka, 0)
		GiveTurn(PlayerTeam)
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

	if GetGearType(gear) == gtHedgehog then
		if IsHogLocal(gear) == true then
			humanHogs = humanHogs + 1
		end
	end
end

function onGearDelete(gear)
	if isATrackedGear(gear) then trackDeletion(gear) end
	
	if GetHogLevel(gear) == 0 and IsHogLocal(gear) == true then
		humanHogs = humanHogs - 1
		if humanHogs == 0 then
			ConcludeGame(false,true,false)
		end
	end
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