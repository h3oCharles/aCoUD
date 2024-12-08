HedgewarsScriptLoad("/Scripts/Locale.lua")
HedgewarsScriptLoad("/Missions/Campaign/A_Collection_of_Unimaginative_Dreams/Scripts/finish.lua")

player = {}
npc = {}
enemy = {}

function onGameInit()
	Map = "Ruler"
	Theme = "Nature"

	ClearGameFlags()
	EnableGameFlags(gfOneClanMode)

	PlayerTeam,PlayerIndex = AddMissionTeam(-1)
	player[1] = AddMissionHog(100)
	player[2] = AddMissionHog(100)
	player[3] = AddMissionHog(100)
	player[4] = AddMissionHog(100)
	
	NPCTeam,NPCIndex = AddTeam(loc("Friendly NPCs"), -1, "Simple", "Plane", "Default_qau", "hedgewars")
	npc[1] = AddHog(loc("Hedgehog 1"), 3, 100, "NoHat")
	
	Enemy1Team,Enemy1Index = AddTeam(loc("Enemy"), -2, "Simple", "Plane", "Default_qau", "hedgewars")
	enemy[1] = AddHog(loc("Hedgehog 1"), 3, 100, "NoHat")
	enemy[2] = AddHog(loc("Hedgehog 2"), 3, 100, "NoHat")
	enemy[3] = AddHog(loc("Hedgehog 3"), 3, 100, "NoHat")
	enemy[4] = AddHog(loc("Hedgehog 4"), 3, 100, "NoHat")
	enemy[5] = AddHog(loc("Hedgehog 5"), 3, 100, "NoHat")
	enemy[6] = AddHog(loc("Hedgehog 6"), 3, 100, "NoHat")
	enemy[7] = AddHog(loc("Hedgehog 7"), 3, 100, "NoHat")
	enemy[8] = AddHog(loc("Hedgehog 8"), 3, 100, "NoHat")
	
	Enemy2Team,Enemy2Index = AddTeam(loc("Enemy"), -2, "Simple", "Plane", "Default_qau", "hedgewars")
	enemy[9] = AddHog(loc("Hedgehog 1"), 3, 100, "NoHat")
	enemy[10] = AddHog(loc("Hedgehog 2"), 3, 100, "NoHat")
	enemy[11] = AddHog(loc("Hedgehog 3"), 3, 100, "NoHat")
	enemy[12] = AddHog(loc("Hedgehog 4"), 3, 100, "NoHat")
	enemy[13] = AddHog(loc("Hedgehog 5"), 3, 100, "NoHat")
	enemy[14] = AddHog(loc("Hedgehog 6"), 3, 100, "NoHat")
	enemy[15] = AddHog(loc("Hedgehog 7"), 3, 100, "NoHat")
	enemy[16] = AddHog(loc("Hedgehog 8"), 3, 100, "NoHat")
end

function onAmmoStoreInit()
	SetAmmo(amSkip,9,0,0,0)
end

function onGameStart()
	SetTeamPassive(NPCTeam,true)
end

function terminate()
	EndTurn(true)
	SetTeamPassive(Enemy1Team, true)
	SetTeamPassive(Enemy2Team, true)
	DisableGameFlags(gfOneClanMode)
end