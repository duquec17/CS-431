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
mq.delay(5000)

-- Start of macro
print("")
print("start of macro")
mq.cmd.Say("${Group.Member[1]} is the tank")

-- All functions definitions --
-- Heal function 1 when health is slightly low --
local function heal1()
    mq.cmd.Say("casting minor healing")
    mq.cmd.Target(mq.TLO.Group.Member(1))
    mq.cmd.Cast(2)
    mq.delay(5000)
    if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
        mq.cmd.Sit()
        print("should be sitting")
    end
    mq.delay(5000)
    print("end of heal 1")
end

-- Heal function 2 when health is very low --
local function heal2()
    mq.cmd.Say("casting healing")
    mq.cmd.Target("${Group.Member[1]}")
    mq.cmd.Cast(1)
    mq.delay(3000)
    if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
        mq.cmd.Sit()
        mq.Echo("should be sitting")
    end
    mq.delay(3000)
    print("end of heal 2")
end

-- Buff function 1 that checks and applies 1st buff --
local function buff1()
-- Check if Spirit Armor buff is already applied
    if mq.TLO.Target.Buff('Spirit Armor').ID() then
        print("Armor buff already applied")
    end
    for i = 1, 2 do
        mq.cmd.Target(mq.TLO.Group.Member(i))
        mq.cmd.Say("Armor buff for 'i' ")
        mq.cmd.Cast(3)
        mq.delay(5000)
    end
    print("end of buff 1")
end

-- Buff function 2 that checks and applies 2nd buff --
local function buff2()
    if mq.TLO.Target.Buff('Blessing of Piety').ID() then
        print("Blessing buff already applied")
    end
    for i = 1, 2 do
        mq.cmd.Target(mq.TLO.Group.Member(i))
        mq.cmd.Say("Blessing buff for 'i' ")
        mq.cmd.Cast(4)
        mq.delay(10000)
    end
    print("end of buff 2")
end

-- Create While loop that ends when macro is ended
--while true do

    -- Check current conditions
    if mq.TLO.Group.Member(1).PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 and mq.TLO.Group.Member(2).PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 then
        print("Heading to buff1")
        buff1()
        buff2()
    end

    -- Heal check --
    print("Running heal check")
    if mq.TLO.Group.Member(1).PctHPs() < 85 and mq.TLO.Group.Member(1).PctHPs() > 65 or mq.TLO.Group.Member(2).PctHPs() < 85 and mq.TLO.Group.Member(2).PctHPs() > 65 then
        print("Heading to heal 1")
        heal1()
    elseif mq.TLO.Group.Member(1).PctHPs() <= 65 or mq.TLO.Group.Member(2).PctHPs() <= 65 then
        print("Heading to heal 2")
        heal2()
    else
        print("All characters at full health")
    end

    if mq.TLO.Me.PctMana() <= 100 then
        mq.cmd.Say("My mana is at " .. mq.TLO.Me.PctMana() .. " percent.")
    end

    print("end of heal check")
-- End of Heal check --


-- Check if can or has cast Debuffs
-- End of Debuff actions --

-- Check if can cast DMG/Stun spell
-- End of DMG/Stun actions --

-- Placeholder for code logic or conditions

-- End of macro
print("The macro is ending")
return