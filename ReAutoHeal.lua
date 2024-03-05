local mq = require('mq')
local actors = require('actors')

-- Declare variable names & values
local ManaWarn = 50

-- Check if a target is selected
if not mq.TLO.Target.ID() then
    mq.cmd.Say('No target selected, exiting macro.')
    return
end

-- Loads spells when starting
mq.cmd.Say('Memorizing spells')
mq.cmd.MemSpellSet('autoHeal20')
mq.cmd.Delay(5)

-- Start of macro
print("")
print("start of macro")
mq.cmd.Say("${Group.Member[1]} is the tank")

-- Create While loop that ends when macro is ended
while true do

    -- Check current conditions
    if mq.TLO.Group.Member(1).PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 or mq.TLO.Group.Member(2).PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 then
        goto buff1
    end

    -- Heal check
    print("Running heal check")
    if mq.TLO.Group.Member(1).PctHPs() < 85 and mq.TLO.Group.Member(1).PctHPs() > 65 or mq.TLO.Group.Member(2).PctHPs() < 85 and mq.TLO.Group.Member(2).PctHPs() > 65 then
        goto heal1
    elseif mq.TLO.Group.Member(1).PctHPs() <= 65 then
        goto heal2
    elseif mq.TLO.Me.PctMana() < 100 then
        mq.cmd.Say("My mana is at " .. mq.TLO.Me.PctMana() .. " percent.")
    end
    print("end of heal check")

    ::endCheck::
    mq.cmd.Delay(5)

    ::loop::
end

::heal1::
mq.cmd.Say("casting minor healing")
mq.cmd.Target(mq.TLO.Group.Member(1))
mq.cmd.Cast(2)
mq.Delay(3)
if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
    mq.cmd.Sit()
    print("should be sitting")
end
mq.cmd.Delay(3)
goto body

::heal2::
mq.cmd.Say("casting healing")
mq.cmd.Target("${Group.Member[1]}")
mq.cmd.Cast(1)
mq.cmd.Delay(3)
if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
    mq.cmd.Sit()
    mq.Echo("should be sitting")
end
mq.cmd.Delay(3)
goto body

::buff1::
-- Check if Spirit Armor buff is already applied
if mq.TLO.Target.Buff('Spirit Armor').ID() then
    print("Armor buff already applied")
    goto healCheck
end
for i = 1, 2 do
    mq.cmd.Target(mq.TLO.Group.Member(i))
    --mq.cmd.Say("Armor buff  " .. mq.TLO.Group.Member(i))
    mq.cmd.Cast(3)
    mq.cmd.Delay(5)
end
goto buff2
-- Returns to healCheck loop --

-- Check if Blessing is already applied --
::buff2::
if mq.TLO.Target.Buff('Blessing of Piety').ID() then
    print("Blessing buff already applied")
    goto healCheck
end
for i = 1, 2 do
    mq.cmd.Target(mq.TLO.Group.Member(i))
    --mq.cmd.Say("Blessing buff " .. mq.TLO.Group.Member(i))
    mq.cmd.Cast(4)
    mq.cmd.Delay(5)
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
print("The macro is ending")
return