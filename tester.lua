-- Macro Condition Builder v0.4 - aquietone
-- Uses some basic pattern matching to provide autocompletion with filtering under specific patterns.
-- 1. When input ends "${" then it will provide short list of hardcoded TLOs commonly used in conditions.
-- 2. When input ends in "${TLONAME." then it will provide all available members of the datatype returned by ${TLONAME}.
-- 3. When input ends in "${TLONAME[params]." then it will provide all available members of the datatype returned by ${TLONAME[params]}.
-- 4. When input ends in "${TLONAME.MEMBER[params]." then it will return all available members of the datatype returned by ${TLONAME.MEMBER[params]}.
-- 5. When input ends in "${TLONAME.MEMBER." then it will return all available members of the datatype returned by ${TLONAME.MEMBER}.
-- Anything further nested will not populate available options.

local mq = require('mq')
local actors = require('actors')
local imgui = require('ImGui')

local isOpen = true

local maxHP = 100;

mq.cmd.Echo('Begin test')

local healthPercent = mq.TLO.Group.Member(1).PctHPs()


local function health()
    mq.cmd.Target(mq.TLO.Group.Member(1))
    mq.cmd.Cast(2)
end

-- Stun debuff function 1 when allies HP 85+, Mana 60+, and  buffs true --
local function stun1()
        mq.cmd.Target()
        mq.cmd.Cast(7)  -- Assuming spell ID 7 is for stunning
        print("Stunning enemy")
        mq.delay(6000)
        mq.cmd.Cast(8)  -- Assuming spell ID 8 is for damaging
        print("Damaging enemy")
        mq.delay(6000)

 end

local function sit()
        print('should be sitting')
        mq.cmd.sit()
end

if healthPercent <= 100 then
    print("First group member's health: " .. healthPercent .. "%")
    --health() -- Call the health function here

    if mq.TLO.Me.PctMana() >= 60 and mq.TLO.Me.PctMana() >= 60 then
        stun1()
    else
        print("Not enough resources to debuff")
    end

end
