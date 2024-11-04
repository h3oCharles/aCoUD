HedgewarsScriptLoad("/Scripts/Animate.lua")

-- Mandatory code for Animate library
function onGameTick()
    AnimUnWait()
    if ShowAnimation() == false then
        return
    end
    ExecuteAfterAnimations()
    CheckEvents()
end

-- Store hegehog ID here
local hog1

function onGameInit()
    -- Mandatory code for Animate library
    AnimInit()

    -- Configure mission
    Map = "Ruler"
    Theme = "Nature"
    Explosives = 0
    MinesNum = 0
    CaseFreq = 0
    GameFlags = gfOneClanMode

    -- Add team and hog
    AddTeam("Test Team", -1, "egg", "Castle", "Default_qau", "cm_test")
    hog1 = AddHog("Hog 1", 0, 100, "NoHat")
    SetGearPosition(hog1, 1100, 770)
end

-- Skip animation when pressing [Precise]
function onPrecise()
    if AnimInProgress() then
        SetAnimSkip(true)
    end
end

-- This function sets up the example animation
local function addWalkAnim()
    -- X coordinate that hog walks to
    local goalX = 900

    -- Animation example: Hog says hello and then walks to the left and then speaks again
    local animation = {
        -- List of animation steps
        {func = AnimSay, args = {hog1, "Hello. I will walk to the left.", SAY_SAY, 2000}},
        {func = AnimMove, args = {hog1, "Left", goalX, 0}},
        {func = AnimSay, args = {hog1, "I reached my goal!", SAY_SAY, 2000}},
    }

    -- Add skip function if player presses the skip key
    local function afterAnimSkip(args)
        -- Teleport hog
        SetGearPosition(hog1, goalX, GetY(hog1))
        -- Face left (because hog walked left)
        HogTurnLeft(hog1, true)
        -- Stop walking
        SetGearMessage(hog1, 0)
    end
    AddSkipFunction(animation, afterAnimSkip, {})

    -- This will be execuded when the animation ended
    local function afterWalkAnim()
        AddCaption("Animation completed!")
        ShowMission("Animation completed!", "It's over!", "You can return to the menu now.", 0, 0)
    end
    AddFunction({func = afterWalkAnim, args = {}})

    -- Add the animation to the animation list.
    -- In our case, it wiill be perfmored immediately.
    AddAnim(animation)
end

-- This makes sure the animation starts on the first turn
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