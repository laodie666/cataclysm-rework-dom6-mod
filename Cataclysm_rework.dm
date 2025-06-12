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


------------------------------------------- EVENTS -------------------------------------------------
-- Cataclysm begins with thrones gaining Gate of Cataclysm spawning more and more roaming horror.

#newevent -- Spawn Source of Cataclysm on indie thrones. Will initially spawn a group of horrors.
-- requirements
#rarity 5 --always happen
#req_indepok 1 -- allow event to happen to indie
#req_thronesite 1
#req_turn 5
#req_site 0 -- Avoid multiple Gate of Cataclysm
#req_freesites 1 -- supposedly I need to do this

-- effects
#msg "Cataclysm spours out of this throne. [Gate of Cataclysm]"
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
#req_fornation -- only occur to indie
#req_fornation 2 -- special indies
#msg "Source of Cataclysm spawns more horror [Gate of Cataclysm]"
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

-- Ruins will spread corruption further
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

-- If the player patrol to remove ruins, it will cause a battle with horrors, after that cataclysm corruption site will be destroyed.
#newevent
#rarity 5
#req_site 1
#req_targorder 3 -- someone need to set to patrol on the province to clear out the ruins.

#nation -- indie attack
#msg "Purifying these Cataclysm Corruption disturbs what's beyond this world. [Cataclysm Corruption]"
#com "Roaming Lesser Horror"

#removesite 2150

#end


-- Player owned thrones will have a notice on incoming cataclysm attack, the first being normal horrors, the second being an army with doom horrors. If doom horror is defeated there will be a boon of gems and gold.



