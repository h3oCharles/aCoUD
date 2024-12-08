-- 
-- load scripts
-- 

HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Scripts/Tracker.lua")
HedgewarsScriptLoad("/Scripts/Utils.lua")
HedgewarsScriptLoad("/Scripts/Animate.lua")

HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/generic.lua")
--HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/circles.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/giveturn.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/finish.lua")

-- 
-- vars
-- 

missionName = "Fool's Mate"
missionIcon = 0
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
	TurnTime = 90 * 1000
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
	SetGearAIHints(player[1], aihDoesntMatter)
	
	WPieceTeam,WPieceIndex = AddTeam(loc("White Pieces"), 0xeedc97, "Simple", "Plane", "Default_qau", "norway")
	white[1] = AddHog(loc("White Queenside Rook"), 3, 100, "TeamSoldier")
	white[2] = AddHog(loc("White Queenside Knight"), 3, 100, "TeamSoldier")
	white[3] = AddHog(loc("White Dark-Squared Bishop")	, 3, 100, "TeamSoldier")
	white[4] = AddHog(loc("White Queen"), 3, 100, "TeamSoldier")
	white[5] = AddHog(loc("White King"), 3, 100, "TeamSoldier")
	white[6] = AddHog(loc("White Light-Squared Bishop"), 3, 100, "TeamSoldier")
	white[7] = AddHog(loc("White Kingside Knight"), 3, 100, "TeamSoldier")
	white[8] = AddHog(loc("White Kingside Rook"), 3, 100, "TeamSoldier")
	
	WPawnTeam,WPawnIndex = AddTeam(loc("White Pawns"), 0xeedc97, "Simple", "Plane", "Default_qau", "norway")
	white[9]  = AddHog(loc("White a-Pawn"), 3, 100, "cap_team")
	white[10] = AddHog(loc("White b-Pawn"), 3, 100, "cap_team")
	white[11] = AddHog(loc("White c-Pawn"), 3, 100, "cap_team")
	white[12] = AddHog(loc("White d-Pawn"), 3, 100, "cap_team")
	white[13] = AddHog(loc("White e-Pawn"), 3, 100, "cap_team")
	white[14] = AddHog(loc("White f-Pawn"), 3, 100, "cap_team")
	white[15] = AddHog(loc("White g-Pawn"), 3, 100, "cap_team")
	white[16] = AddHog(loc("White h-Pawn"), 3, 100, "cap_team")
	
	BPieceTeam,BPieceIndex = AddTeam(loc("Black Pieces"), 0x964d22, "Simple", "Plane", "Default_qau", "united_states")
	black[1] = AddHog(loc("Black Queenside Rook"), 3, 100, "TeamSoldier")
	black[2] = AddHog(loc("Black Queenside Knight"), 3, 100, "TeamSoldier")
	black[3] = AddHog(loc("Black Dark-Squared Bishop"), 3, 100, "TeamSoldier")
	black[4] = AddHog(loc("Black Queen"), 3, 100, "TeamSoldier")
	black[5] = AddHog(loc("Black King"), 3, 100, "TeamSoldier")
	black[6] = AddHog(loc("Black Light-Squared Bishop")	, 3, 100, "TeamSoldier")
	black[7] = AddHog(loc("Black Kingside Knight"), 3, 100, "TeamSoldier")
	black[8] = AddHog(loc("Black Kingside Rook"), 3, 100, "TeamSoldier")
	
	BPawnTeam,BPawnIndex = AddTeam(loc("Black Pawns"), 0x964d22, "Simple", "Plane", "Default_qau", "united_states")
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
		AddAmmo(player[i],amRope,100)
		AddAmmo(player[i],amFirePunch,100)
	end
	
	for i = 1,#white do
		AddAmmo(white[i],amShotgun,100)
		AddAmmo(white[i],amDEagle,100)
		AddAmmo(white[i],amSniperRifle,100)
	end
	
	for i = 1,#black do
		AddAmmo(black[i],amShotgun,100)
		AddAmmo(black[i],amDEagle,100)
		AddAmmo(black[i],amSniperRifle,100)
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
	SetAmmo(amSkip, 9, 0, 0, 0)
end

-- 
-- cutscene stuff
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
		"Checkmate White the quickest way possible.".."|"..
		"",missionIcon, 0)
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

function onNewTurn() CheckGivenTurn() end

function onEndTurn() end

function onGearAdd(gear)
	if GetGearType(gear) == gtHedgehog then
		trackGear(gear)
		SetEffect(gear, heResurrectable, 1)
	end
end

function onGearDelete(gear)
	if GetGearType(gear) == gtHedgehog then
		trackDeletion(gear)
		
		if gear == white[5] then
			--EndTurn(true)
			printDebug("passive")
			--SetTeamPassive(WPieceTeam, true)
			--SetTeamPassive(WPawnTeam, true)
			--SetTeamPassive(BPieceTeam, true)
			--SetTeamPassive(BPawnTeam, true)
			
			DismissTeam(WPieceTeam)
			DismissTeam(WPawnTeam)
			DismissTeam(BPieceTeam)
			DismissTeam(BPawnTeam)
			
			DisableGameFlags(gfOneClanMode)
		end
	end
end

function onHogRestore(gear)	if GetGearType(gear) == gtHedgehog then trackRestoring(gear) end end
function onHogHide(gear) if GetGearType(gear) == gtHedgehog then trackHiding(gear) end end

-- 
-- mission specific stuff
-- 

function onGearDamage(gear, damage)
	if GetGearType(gear) == gtHedgehog and
		CurrentHedgehog == player[1] then
		printDebug(GetHogName(gear) .. " has been tagged")
		
		if gear == white[14] then
			printDebug("it's the white f-pawn")
		elseif gear == white[15] then
			printDebug("it's the white g-pawn")
		elseif gear == black[13] then
			printDebug("it's the black e-pawn")
		elseif gear == black[4] then
			printDebug("it's the black queen")
		else
			printDebug("no, that's not it")
		end
	end
end

function Checkmate()
	printDebug("checkmate")
	EndTurn(true)
	SetEffect(white[5], heResurrectable, 0)
	SetHealth(white[5],0)
end