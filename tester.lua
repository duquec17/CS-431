-- Macro Condition Builder v0.4 - aquietone
-- Uses some basic pattern matching to provide autocompletion with filtering under specific patterns.
-- 1. When input ends "${" then it will provide short list of hardcoded TLOs commonly used in conditions.
-- 2. When input ends in "${TLONAME." then it will provide all available members of the datatype returned by ${TLONAME}.
-- 3. When input ends in "${TLONAME[params]." then it will provide all available members of the datatype returned by ${TLONAME[params]}.
-- 4. When input ends in "${TLONAME.MEMBER[params]." then it will return all available members of the datatype returned by ${TLONAME.MEMBER[params]}.
-- 5. When input ends in "${TLONAME.MEMBER." then it will return all available members of the datatype returned by ${TLONAME.MEMBER}.
-- Anything further nested will not populate available options.
local mq = require('mq')

mq.cmd.Echo('Begin test')

-- Function to target the target of group member 1 and cast a spell
local function stun1()
    local tank = mq.TLO.Group.Member(1)
     mq.cmd.assist(tank)
     printf('%s is the tank', tank)
end

-- Check if mana is sufficient before casting the spell
if mq.TLO.Me.PctMana() <= 100 then
    stun1()
else
    print("Not enough resources to cast the spell")
end