#modname "Cataclysm Rework v0.1"
#description "Rework the original cataclysm mechanic as an end game crisis kinda thing"
#icon "temp_icon.png"
#version 0.1

#newmonster
#copystats 308
#copyspr 308
#name "Roaming Horror"
#descr "This horror moves around :)"
#indepmove 50 -- allows horror to move around independently
#end

#newsite
#name "Source of Cataclysm"
#look -1
#rarity 5
#level 0
#end

#newsite
#name "Cataclysmic Ruins"
#look -1
#rarity 5
#level 0
#end


-- REWORK ALL OF THIS SPAWN A SITE ON ARCANE NEXUS AND OPEN GATES TO IT. HORRORS WILL SPREAD OUT OF THOSE GATES. cast nexus gate?

-- Cataclysm begins with indie thrones gaining Source of Cataclysm spawning more and more roaming horror.

#newevent -- Spawn Source of Cataclysm on indie thrones. Will initially spawn a group of horrors.
-- requirements
#rarity 5 --always happen
#req_indepok 1 -- allow event to happen to indie
#req_thronesite 1
#req_fornation -- default indie
#req_fornation 2 -- event can occur to indie thrones
#req_turn 5

-- effects
#msg "Cataclysm spours out of this unclaimed throne. [Source of Cataclysm]"
#req_site 0 
#addsite -1 -- Add source of cataclysm to indie thrones.
-- Initial attack
#2com "Roaming Horror"
#2d6units 308
#end


#newevent -- Spawn roaming horror on Source of Cataclysm everyturn with 50% chance
-- requirements
#rarity 5 --always happen
#req_rare 30 -- 30% chance of spawning more horror every turn. 
#req_indepok 1 -- allow event to happen to indie
#req_turn 5
#msg "Source of Cataclysm spawns more horror [Source of Cataclysm]"
#req_site 0

-- effects
#com "Roaming Horror"
#1d6units 308
#end



-- Cataclysms will spread Cataclysmic Ruins to surrounding provinces, each spawning more and more horror.



-- Player owned thrones will have a notice on incoming cataclysm attack, the first being normal horrors, the second being an army with doom horrors. If doom horror is defeated there will be a boon of gems and gold.
-- If the player 


-- Investigate to remove ruins, investigating at source of cataclysm will cause a battle of doom horror, after that a site would spawn.