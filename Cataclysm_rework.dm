#modname "Cataclysm Rework v0.1"
#description "Rework the original cataclysm mechanic as an end game crisis kinda thing"
#icon "temp_icon.png"
#version 0.1

----- used site number 2149 and 2150, modified montag 2100 and 2101

#newmonster
#copystats 308
#copyspr 308
#montag 2101
#name "Roaming Horror"
#descr "This horror moves around :)"
#indepmove 50 -- allows horror to move around independently
#end

#newmonster
#copystats 307
#copyspr 307
#montag 2100
#name "Roaming Lesser Horror"
#descr "This lesser horror moves around :)"
#indepmove 50 -- allows horror to move around independently
#end

#newsite 2149
#name "Gate of Cataclysm"
#look -1
#rarity 5
#level 0
#end

#newsite 2150
#name "Cataclysm Corruption"
#look -1
#rarity 5
#level 0
#end

#newsite 2151
#name "Closed Gate of Cataclysm"
#look -1
#rarity 5
#level 0

#end


------------------------------------------- EVENTS -------------------------------------------------
-- Cataclysm begins with thrones gaining Gate of Cataclysm spawning more and more roaming horror.

-- announcer global event
#newevent
#rarity 13
#req_turn 5
#req_permonth 1
#req_unique 1

#msg "THE ENDTIME IS HERE, THE CATACLYSM DESCENDS UPON THIS WORLD. v2"

#end

#newevent -- Spawn Source of Cataclysm on indie thrones. Will initially spawn a group of horrors.
-- requirements
#rarity 5 --always happen
#req_indepok 1 -- allow event to happen to indie
#req_thronesite 1
#req_turn 5
#req_site 0 -- Avoid multiple Gate of Cataclysm
#req_fornation -- only occur to indie
#req_fornation 2 -- special indies
#req_freesites 1 -- supposedly I need to do this

-- effects
#msg "Horrors spawn out of the Gate of Cataclysm. [Gate of Cataclysm]"
#addsite -1 -- Add gate of cataclysm to thrones.
-- Initial attack
#com "Roaming Horror"
#1d6units -7
#end


#newevent -- Spawn roaming horror on Gate of Cataclysm on indie thrones everyturn with 20% chance
-- requirements
#rarity 5 --always happen
#req_rare 20 -- 20% chance of spawning more horror every turn. 
#req_indepok 1 -- allow event to happen to indie
#msg "Horrors spawn out of the Gate of Cataclysm. [Gate of Cataclysm]"
#req_site 1

-- effects
#com "Roaming Horror"
#1d3units -7
#end




------------ Cataclysms will spread Cataclysm Corruption to surrounding provinces, each spawning more and more horror.----------------------------
-- Gate will spread corruption futher
#newevent
-- requirements
#rarity 5 --always happen
#req_indepok 1 -- allow event to happen to indie
#req_rare 20 -- 20% chance of cataclysm spreading
#req_fornation -- only occur to indie
#req_fornation 2 -- special indies
#req_nearbysite 1 -- requires neighboring Gate of Cataclysm
#req_nositenbr 2150 -- avoid repeat
#req_site 0 -- avoid Gate of Cataclysm
#req_freesites 1 -- supposedly I need to do this

#msg "The forces of cataclysm spreads to this province. [Gate of Cataclysm]"

-- effects
#addsite 2150
#kill 20 -- cataclysm spreading here will kill 20% of the people
#emigration 10 -- 10% of the province flee

#end

-- Corruption will spread corruption further
#newevent
-- requirements
#rarity 5 --always happen
#req_indepok 1 -- allow event to happen to indie
#req_rare 10 -- 10% chance of cataclysm spreading
#req_fornation -- only occur to indie
#req_fornation 2 -- special indies
#req_nearbysite 1 -- requires neighboring Cataclysm Corruption
#req_nositenbr 2149 -- avoid Gate of Cataclysm
#req_site 0 -- avoid repeat
#req_freesites 1 -- supposedly I need to do this

#msg "The forces of cataclysm spreads to this province. [Cataclysm Corruption]"

-- effects
#addsite 2150
#kill 20 -- cataclysm spreading here will kill 20% of the people
#emigration 10 -- 10% of the province flee

#end

-- Spawn roaming horror on Cataclysm Corruption on indie thrones everyturn with 10% chance
#newevent 
-- requirements
#rarity 5 --always happen
#req_rare 10 -- 10% chance of spawning more horror every turn. 
#req_indepok 1 -- allow event to happen to indie
#req_fornation -- only occur to indie
#req_fornation 2 -- special indies
#msg "Cataclysm Corruption spawns more horror [Cataclysm Corruption]"
#req_site 1

-- effects
#com "Roaming Lesser Horror"
#1d6units -6
#end

-- If the player patrol to remove corruption, it will cause a battle with horrors, after that cataclysm corruption site will be destroyed.
#newevent
#rarity 5
#req_site 1
#req_targorder 3 -- someone need to set to patrol on the province to clear out the corruption.

#nation -- indie attack
#msg "Purifying these Cataclysm Corruption disturbed things beyond this world. [Cataclysm Corruption]"
#com "Roaming Lesser Horror"
#1d6units -6

#removesite 2150 -- remove corruption

#end


-- Player owned thrones will have a notice on incoming cataclysm attack, the first being normal horrors, the second being an army with doom horrors. If doom horror is defeated there will be a boon of gems and gold.
#newevent -- Spawn Source of Cataclysm on player thrones. Will initially spawn a group of horrors.
-- requirements
#rarity 5 --always happen
#req_indepok 1 -- allow event to happen to indie
#req_thronesite 1
#req_turn 5
#req_site 0 -- Avoid multiple Gate of Cataclysm
#req_notfornation -- prevent occur to indie
#req_notfornation 2 -- special indies
#req_freesites 1 -- supposedly I need to do this

-- effects
-- TODO ADD DOOM HORROR ATTACK
#msg "The forces of cataclysm has descended upon your throne, and a Gate of Cataclysm has been opened. Horrors will continuously spour out of it, and you can choose to close it by patrolling and gain the treasure of what's beyond, or continue to harvest the boons of the cataclysm. Your scholars do warn you, that there is an unimaginable threat approaching in 3 months or so. [Gate of Cataclysm]"
#addsite -1 -- Add gate of cataclysm to thrones.
#code -1023 -- code for doom horror attack
#delay 3

#end

#newevent
#rarity 5
#req_code -1023
#msg "delay worked."
#code 0

#end

-- If the player patrol to remove Gate of Cataclysm, it will cause a battle with horrors, after that cataclysm corruption site will be destroyed.
-- TODO DOESNT WORK
#newevent
#rarity 5
#req_site 1
#req_targorder 3 -- someone need to set to patrol on the province to clear out the corruption.

#nation -- indie attack
#msg "The Gate of Cataclysm has been closed once and for all. A stash of treasure was found, yet along it arrives some horrors too. [Gate of Cataclysm]"
#com "Roaming Horror"
#1d6units -7

#magicitem 4
#gold 1000
-- bit of every gems
-- #2d6vis 0
-- #2d6vis 1
-- #2d6vis 2
-- #2d6vis 3
-- #2d6vis 4
-- #2d6vis 5
-- #2d6vis 6
-- #2d6vis 7
-- #2d6vis 8

#removesite 2149 -- remove gate
#addsite 2151 -- add closed gate

#end
