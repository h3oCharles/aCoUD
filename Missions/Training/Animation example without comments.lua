HedgewarsScriptLoad("/Scripts/Animate.lua")

function onGameTick()
    AnimUnWait()
    if ShowAnimation() == false then
        return
    end
    ExecuteAfterAnimations()
    CheckEvents()
end

local hog1

function onGameInit()
    AnimInit()

    Map = "Ruler"
    Theme = "Nature"
    Explosives = 0
    MinesNum = 0
    CaseFreq = 0
    GameFlags = gfOneClanMode

    AddTeam("Test Team", -1, "egg", "Castle", "Default_qau", "cm_test")
    hog1 = AddHog("Hog 1", 0, 100, "NoHat")
    SetGearPosition(hog1, 1100, 770)
end

function onPrecise()
    if AnimInProgress() then
        SetAnimSkip(true)
    end
end

local function addWalkAnim()
    local goalX = 900

    local animation = {
        {func = AnimSay, args = {hog1, "Hello. I will walk to the left.", SAY_SAY, 2000}},
        {func = AnimMove, args = {hog1, "Left", goalX, 0}},
        {func = AnimSay, args = {hog1, "I reached my goal!", SAY_SAY, 2000}},
    }

    local function afterAnimSkip(args)
        SetGearPosition(hog1, goalX, GetY(hog1))
        HogTurnLeft(hog1, true)
        SetGearMessage(hog1, 0)
    end
    AddSkipFunction(animation, afterAnimSkip, {})

    local function afterWalkAnim()
        AddCaption("Animation completed!")
        ShowMission("Animation completed!", "It's over!", "You can return to the menu now.", 0, 0)
    end
    AddFunction({func = afterWalkAnim, args = {}})
    AddAnim(animation)
end

local hasAnimationStarted = false
function onGameStart()
    if hasAnimationStarted then
        return
    end
    if CurrentHedgehog ~= hog1 then
        SwitchHog(hog1)
    end
    addWalkAnim()
    hasAnimationStarted = true
end