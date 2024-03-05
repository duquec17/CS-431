local mq = require('mq')
local actors = require('actors')

-- Declare variable names & values
local ManaWarn = 50

-- Check if a target is selected
if not mq.TLO.Target.ID() then
    mq.cmd('/say No target selected, exiting macro.')
    return
end

-- Loads spells when starting
mq.cmd('/say memorizing spells')
mq.cmd.MemSpellSet('autoHeal20')
mq.cmd.Delay(5)

-- Start of macro
mq.Echo()
mq.Echo("start of macro")
mq.Say("${Group.Member[1]} is the tank")

-- Create While loop that ends when macro is ended
while true do

    -- Check current conditions
    if mq.TLO.Group.Member[1].PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 or mq.TLO.Group.Member[2].PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 then
        goto buff1
    end

    -- Heal check
    mq.Echo("Running heal check")
    if mq.TLO.Group.Member[1].PctHPs() < 85 and mq.TLO.Group.Member[1].PctHPs() > 65 or mq.TLO.Group.Member[2].PctHPs() < 85 and mq.TLO.Group.Member[2].PctHPs() > 65 then
        goto heal1
    elseif mq.TLO.Group.Member[1].PctHPs() <= 65 then
        goto heal2
    elseif mq.TLO.Me.PctMana() < 100 then
        mq.Say("My mana is at " .. mq.TLO.Me.PctMana() .. " percent.")
    end
    mq.Echo("end of heal check")

    ::endCheck::
    mq.Delay(5)

    ::loop::
end

::heal1::
mq.Say("casting minor healing")
mq.Target("${Group.Member[1]}")
mq.Cast(2)
mq.Delay(3)
if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
    mq.Sit()
    mq.Echo("should be sitting")
end
mq.Delay(3)
goto body

::heal2::
mq.Say("casting healing")
mq.Target("${Group.Member[1]}")
mq.Cast(1)
mq.Delay(3)
if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
    mq.Sit()
    mq.Echo("should be sitting")
end
mq.Delay(3)
goto body

::buff1::
-- Check if Spirit Armor buff is already applied
if mq.TLO.Target.Buff["Spirit Armor"].ID() then
    mq.Echo("Armor buff already applied")
    goto healCheck
end
for i = 1, 2 do
    mq.Target("${Group.Member[i]}")
    mq.Say("it's Buff time " .. mq.TLO.Group.Member[i])
    mq.Cast(3)
    mq.Delay(5)
end
goto buff2
-- Returns to healCheck loop --

-- Check if Blessing is already applied --
::buff2::
if mq.TLO.Target.Buff["Blessing of Piety"].ID() then
    mq.Echo("Blessing buff already applied")
    goto healCheck
end
for i = 1, 2 do
    mq.Target("${Group.Member[i]}")
    mq.Say("it's Buff time " .. mq.TLO.Group.Member[i])
    mq.Cast(4)
    mq.Delay(5)
end
goto healCheck
-- Returns to healCheck loop --

-- Check if can or has cast Debuffs
-- End of Debuff actions --

-- Check if can cast DMG/Stun spell
-- End of DMG/Stun actions --

::body::
::healCheck::
-- Placeholder for code logic or conditions

-- End of macro
mq.Echo("The macro is ending")
return