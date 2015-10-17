

    local _AddMessage = ChatFrame1.AddMessage
    local gsub = string.gsub
    local blacklist = {[ChatFrame2] = true,}

        -- shorten some chat events
    local chatevents = {
        CHAT_MSG_BG_SYSTEM_ALLIANCE = {
            ['The Alliance Flag was picked up by (.+)!'] = '+ Alliance Flag — |cffff7d00%1|r.',
            ['The Alliance Flag was dropped by (.+)!'] = '- Alliance Flag — |cffff7d00%1|r.',
            ['The Alliance Flag was returned to its base by (.+)!'] = '%1 returned Alliance Flag.'
        },
        CHAT_MSG_BG_SYSTEM_HORDE = {
            ['The Horde flag was picked up by (.+)!'] = '+ Horde Flag — |cffff7d00%1|r.',
            ['The Horde flag was dropped by (.+)!'] = '- Horde Flag — |cffff7d00%1|r.',
            ['The Horde flag was returned to its base by (.+)!'] = '%1 returned Horde Flag.'
        },
        CHAT_MSG_COMBAT_FACTION_CHANGE = {
            ['Reputation with (.+) increased by (.+).'] = '+ %2 %1 rep.',
            ['You are now (.+) with (.+).'] = '%2 standing is now %1.',
        },
        CHAT_MSG_COMBAT_XP_GAIN = {
            ['(.+) dies, you gain (.+) experience. %(%+(.+)exp Rested bonus%)'] = '+ %2 (+%3) xp from %1.',
            ['(.+) dies, you gain (.+) experience.'] = '+ %2 xp from %1.',
            ['You gain (.+) experience.'] = '+ %1 xp.',
        },
        CHAT_MSG_CURRENCY = {
            ['You receive currency: (.+)%.'] = '+ %1.',
            ['You\'ve lost (.+)%.'] = '- %1.',
        },
        CHAT_MSG_LOOT = {
            ['You receive item: (.+)%.'] = '+ %1.',
            ['You receive loot: (.+)%.'] = '+ %1.',
            ['You create: (.+)%.'] = '+ %1.',
            ['You are refunded: (.+)%.'] = '+ %1.',
            ['You have selected (.+) for: (.+)'] = 'Selected %1 for %2.',
            ['Received item: (.+)%.'] = '+ %1.',
            ['(.+) receives item: (.+)%.'] = '+ %2 for %1.',
            ['(.+) receives loot: (.+)%.'] = '+ %2 for %1.',
            ['(.+) creates: (.+)%.'] = '+ %2 for %1.',
        },
        CHAT_MSG_SKILL = {
            ['Your skill in (.+) has increased to (.+).'] = '%1 lvl %2.'
        },
        CHAT_MSG_SYSTEM = {
            ['Received (.+), (.+).'] = '+ %1, %2.',
            ['Received (.+).'] = '+ %1.',
            ['Received (.+) of item: (.+).'] = '+ %2x%1.',
            ['(.+) completed.'] = '- Quest |cfff86256%1|r.',
            ['Quest accepted: (.+)'] = '+ Quest |cfff86256%1|r.',
            ['Received item: (.+)%.'] = '+ %1.',
            ['Experience gained: (.+).'] = '+ %1 xp.',
            ['(.+) has come online.'] = '|cff40fb40%1|r logged on.',
            ['(.+) has gone offline.'] = '|cff40fb40%1|r logged off.',
            ['You are now Busy: in combat'] = '+ Combat.',
            ['You are no longer marked Busy.'] = '- Combat.',
            ['Discovered (.+): (.+) experience gained'] = '+ %2 xp, found %1.',
            ['You are now (.+) with (.+).'] = '+ %2 faction, now %1.',
            ['Quest Accepted (.+)'] = '+ quest |cfff86256%1|r.',
            ['You are now Away: AFK'] = '+ AFK.',
            ['You are no longer Away.'] = '- AFK.',
            ['You are no longer rested.'] = '- Rested.',
            ['You don\'t meet the requirements for that quest.'] = '|cffff000!|r Quest requirements not met.',
            ['No player named \'(.+)\' is currently playing.'] = 'No such player, \'|cffff7d00%1|r\'.',
            ['(.+) has joined the party.'] = '+ Party Member |cffff7d00%1|r.',
            ['(.+) has joined the raid group'] = '+ Raider |cffff7d00%1|r.',
            ['(.+) has left the raid group'] = '- Raider |cffff7d00%1|r.',
        },
        CHAT_MSG_TRADESKILLS = {
            ['(.+) creates (.+).'] = '%1 |cffffff00->|r %2.',
        },
    }

    CHAT_GUILD_GET = '|Hchannel:Guild|hg|h %s:\32'                        -- GUILD          'g'
    CHAT_OFFICER_GET = '|Hchannel:o|ho|h %s:\32'                          -- OFFICER        'o'
    CHAT_RAID_GET = '|Hchannel:raid|hr|h %s:\32'                          -- RAID           'r'
    CHAT_RAID_WARNING_GET = 'rw %s:\32'                                   -- RAID W         'rw'
    CHAT_RAID_LEADER_GET = '|Hchannel:raid|hrl|h %s:\32'                  -- RAID L         'rl'
    CHAT_BATTLEGROUND_GET = '|Hchannel:Battleground|hbg|h %s:\32'         -- BG             'bg'
    CHAT_BATTLEGROUND_LEADER_GET = '|Hchannel:Battleground|hbl|h %s:\32'  -- BG L           'bl'
    CHAT_PARTY_GET = '|Hchannel:party|hp|h %s:\32'                        -- PARTY          'p'
    CHAT_PARTY_GUIDE_GET = '|Hchannel:party|hdg|h %s:\32'                 -- DUNGEONGUIDE   'dg'
    CHAT_MONSTER_PARTY_GET = '|Hchannel:raid|hr|h %s:\32'                 -- RAID           'r'

   local AddMessage = function(f, t, r, g, b, id)
       t = gsub(t, '%[(%d+)%. .+%].+(|Hplayer.+)', '%1 %2')               -- WORLD CHANNELS '1'
       t = gsub(t, '|H(.-)|h%[(.-)%]|h', '|H%1|h%2|h')                    -- STRIP BRACKETS
       t = gsub(t, 'Guild Message of the Day:', '/GMOTD/')	              -- MOTD
       -- t = string.format('%s %s', date'%X', t)                         -- TIMESTAMP
       for i, v in pairs(chatevents) do                                   -- CHAT EVENTS
           for k, j in pairs(v) do
               if string.find(t, k)then
                   -- print(k, 'is a match.')
                   t = gsub(t, k, j)
               end
           end
       end
       return _AddMessage(f, t, r, g, b, id)
   end

   for i = 1, 7 do
       if not blacklist[chat] then _G['ChatFrame'..i].AddMessage = AddMessage end
   end

   --
