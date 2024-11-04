radius = 100
drawCircle = nil

function onGameTick20()
	if CursorX == NO_CURSOR then
		DeleteVisualGear(circle)
		drawCircle = false
	elseif CursorX ~= NO_CURSOR then
		if drawCircle == false then
			circle = AddVisualGear(CursorX, CursorY, vgtCircle, 0, true)
			drawCircle = true
		end
		
		if drawCircle == true then
			AddCaption("X: "..CursorX.." Y: "..CursorY, 0xFFFFFFFF, capgrpMessage)
			AddCaption("rad: "..radius, 0xFFFFFFFF, capgrpMessage2)
			SetVisualGearValues(circle, CursorX, CursorY, nil, nil, nil, nil, nil, radius, 3, nil, nil)
			
			if increase == true then radius = radius + 1 end
			if decrease == true then radius = radius - 1 end
		end
	end
end

function onUp() increase = true end
function onUpUp() increase = false end
function onDown() decrease = true end
function onDownUp() decrease = false end

function onHogAttack(ammoType)
	if ammoType == amAirAttack then
		PlaySound(sndPlaced)
		WriteLnToConsole("x,y: "..CursorX..","..CursorY.." rad: "..radius)
		--Explode(CursorX, CursorY, radius)
	end
end

function onGearAdd(gear)
	--HogSay(CurrentHedgehog,GetGearType(gear),SAY_SAY)
	if GetGearType(gear) == gtAirAttack then
		--HogSay(CurrentHedgehog,"meow",SAY_SAY)
		SetHealth(gear,0)
	end
end

function onGameStart()
	--SetSoundMask(sndPlane, true)
	SetSoundMask(sndIncoming, true)
end