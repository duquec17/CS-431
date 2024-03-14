local mq = require('mq')
local actors = require('actors')

-- Declare variable names & values
local ManaWarn = 50
local terminate = false;

-- Check if a target is selected


-- Loads spells when starting
mq.cmd.Say('Memorizing spells')
mq.cmd.MemSpellSet('ReAutoHeal')
mq.delay(5000)

-- Start of macro
print("")
print("start of macro")

-- All functions definitions --
-- Heal function 1 when health is slightly low --
local function heal1()
    --print("casting healing")
    if mq.TLO.Group.Member(1).PctHPs() < 85 then
        mq.cmd.Target(mq.TLO.Group.Member(1))
    elseif mq.TLO.Group.Member(2).PctHPs() < 85 then
        mq.cmd.Target(mq.TLO.Group.Member(2))
    end
    
    mq.cmd.Cast(2)
    mq.delay(3000)
    if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
        mq.cmd.Sit()
    end
    mq.delay(5000)
    print("end of heal 1")
end

-- Heal function 2 when health is very low --
local function heal2()
    --print("casting Greater healing")
    if mq.TLO.Group.Member(1).PctHPs() <= 65 then
        mq.cmd.Target(mq.TLO.Group.Member(1))
    elseif mq.TLO.Group.Member(2).PctHPs() <= 65 then
        mq.cmd.Target(mq.TLO.Group.Member(2))
    end

    mq.cmd.Cast(1)
    mq.delay(3000)
    if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
        mq.cmd.Sit()
    end
    mq.delay(3000)
    print("end of heal 2")
end

-- Buff function 1 that checks and applies 1st buff --
local function buff1()
-- Check if Spirit Armor buff is already applied
    if mq.TLO.Target.Buff('Spirit Armor').ID() then
        print("Armor buff already applied")
    else
        for i = 1, 2 do
            mq.cmd.Target(mq.TLO.Group.Member(i))
            mq.cmd.Cast(3)
            mq.delay(8000)
        end
    end
   
end

-- Buff function 2 that checks and applies 2nd buff --
local function buff2()
    if mq.TLO.Target.Buff('Reckless Strength').ID() then
        print("Strength buff already applied")
    else
        for i = 1, 2 do
            mq.cmd.Target(mq.TLO.Group.Member(i))
            mq.cmd.Cast(4)
            mq.delay(10000)
        end
    end
    
end

-- Buff function 3 that checks and applies 3rd buff --
local function buff3()
    if mq.TLO.Target.Buff('Symbol of Transal').ID() then
        print("Symbol buff already applied")
    else
        for i = 1, 2 do
            mq.cmd.Target(mq.TLO.Group.Member(i))
            mq.cmd.Cast(5)
            mq.delay(7000)
        end
    end

end

-- Buff function 4 that checks and applies 3rd buff --
local function buff4()
    if mq.TLO.Target.Buff('Daring').ID() then
        print("Shield buff already applied")
    else
        for i = 1, 2 do
            mq.cmd.Target(mq.TLO.Group.Member(i))
            mq.cmd.Cast(6)
            mq.delay(6000)
        end
    end

end

-- Stun debuff function 1 when allies HP 85+, Mana 60+, and  buffs true --
local function stun1()
   -- Target the tank's target if it exists, otherwise target the last hitter
   local tank = mq.TLO.Group.Member(1)
    
   mq.cmd.assist(tank) -- Targets the tank's current target

   mq.cmd.Cast(7)  -- Assuming spell ID 7 is for stunning
   mq.delay(6000)

   mq.cmd.Cast(8)  -- Assuming spell ID 8 is for damaging
   mq.delay(6000)
end

-- DMG spell function that occurs after Stun debuff function -- 

-- Create While loop that ends when macro is ended
while not terminate 
do
    -- Check Buff current conditions
    if mq.TLO.Group.Member(1).PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 and mq.TLO.Group.Member(2).PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 75 then
        buff1()
        buff2()
        buff3()
        buff4()

        --print("Moving to Heal Check")
        
        if mq.TLO.Me.Standing() and not mq.TLO.Me.Mount.ID() then
            mq.cmd.Sit()
        end
        mq.delay(3000)
    end

    -- Heal check --
    --print("Running heal check")
    if mq.TLO.Group.Member(1).PctHPs() < 85 and mq.TLO.Group.Member(1).PctHPs() > 65 or mq.TLO.Group.Member(2).PctHPs() < 85 and mq.TLO.Group.Member(2).PctHPs() > 65 then
        heal1()
    elseif mq.TLO.Group.Member(1).PctHPs() <= 65 or mq.TLO.Group.Member(2).PctHPs() <= 65 then
        heal2()
    elseif mq.TLO.Group.Member(1).PctHPs() == 100 and mq.TLO.Me.PctMana() == 100 then
        print("All characters at full health")
        terminate = true;
    end
    -- End of Heal check -- 

    -- Debuff/DMG check -- 
    if mq.TLO.Group.Member(1).PctHPs() >= 85 and mq.TLO.Me.PctMana() >= 60 then
        stun1()
    elseif mq.TLO.Me.PctMana() <= 60 then
        --print("Not enough resources to debuff")
    end

    -- Mana call out --
    if mq.TLO.Me.PctMana() <= 30 then
        mq.cmd.Say("My mana is at " .. mq.TLO.Me.PctMana() .. " percent.")
        mq.cmd.Sit()
        terminate = true;
    end
    -- Checks to see whether to terminate script --
end
return