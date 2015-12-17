

    local TEXTURE  = [[Interface\AddOns\modui\statusbar\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}
    local class    = UnitClass'player'
    local p    = {} local t     = {}
    local Cast = {} local casts = {}
    local Heal = {} local heals = {}
    Cast.__index   = modcast
    Heal.__index   = modheal
    local enabled  = true               -- TOGGLE NAMEPLATES VISIBILITY DEFAULT
    local showpet  = false              -- TOGGLE NON_COMBAT PET VISIBILITY


    local pets = {
        'Orange Tabby', 'Silver Tabby', 'Bombay', 'Cornish Rex', 'Siamese',
        'Hawk Owl', 'Great Horned Owl', 'Cockatiel', 'Senegal', 'Green Wing Macaw', 'Hyacinth Macaw',
        'Black Kingsnake', 'Brown Snake', 'Crimson Snake',
        'Prairie Dog',
        'Cockroach',
        'Ancona Chicken',
        'Worg Pup',
        'Smolderweb Hatchling',
        'Mechanical Chicken', 'Mechanical Squirrel', 'Lifelike Mechanical Toad', 'Pet Bombling', 'Lil\' Smokey',
        'Sprite Darter', 'Tiny Black Whelpling', 'Tiny Emerald Whelpling', 'Tiny Crimson Whelpling',
        'Unconscious Dig Rat', }

    local isPlate = function(frame)     -- GO FISH
        local overlayRegion = frame:GetRegions()
        if not overlayRegion or overlayRegion:GetObjectType() ~= 'Texture'
        or overlayRegion:GetTexture() ~= [[Interface\Tooltips\Nameplate-Border]] then
            return false
        end
        return true
    end

    local isPet = function(name)
        for _, pname in pairs(pets) do
            if name == pname then return true end
        end
        return false
    end

    local isPlayer = function(n)
        if not t[n] then
            TargetByName(n, true)
            table.insert(t, n)
            t[n] = 'ok'
            if UnitIsPlayer'target' then
                local class = UnitClass'target'
                table.insert(p, n)
                p[n] = {['class'] = string.upper(class)}
            end
        end
    end

    local getTimerLeft = function(tEnd)
        local t = tEnd - GetTime()
        if t > 5 then return decimal_round(t, 0) else return decimal_round(t, 1) end
    end

    Cast.create = function(caster, spell, icon, dur, time)
        local acnt = {}
        setmetatable(acnt, modcast)
        acnt.caster    = caster
        acnt.spell     = spell
        acnt.icon      = icon
        acnt.timeStart = time
        acnt.timeEnd   = time + dur
        return acnt
    end

    Heal.create = function(n, no, crit, time)
       local acnt = {}
       setmetatable(acnt, modheal)
       acnt.target    = n
       acnt.amount    = no
       acnt.crit      = crit
       acnt.timeStart = time
       acnt.timeEnd   = time + 2
       acnt.y         = 0
       return acnt
    end

    local removeDoubleCast = function(caster)
    	local k = 1
    	for i, j in casts do
    		if j.caster == caster then table.remove(casts, k) end
    		k = k + 1
    	end
    end

    local newCast = function(caster, spell)
    	local time = GetTime()
    	local info = nil
    	removeDoubleCast(caster)
    	if MODUI_SPELLCASTS_TO_TRACK[spell] ~= nil then info = MODUI_SPELLCASTS_TO_TRACK[spell] end
    	if info ~= nil then
    		local n = Cast.create(caster, spell, info[1], info[2], time)
    		table.insert(casts, n)
    	end
    end

    local newHeal = function(n, no, crit)
        local time = GetTime()
        local h = Heal.create(n, no, crit, time)
        table.insert(heals, h)
    end

    local modPlate = function(plate)    -- STYLE
        local health = plate:GetChildren()
        local border, glow, name, level, _, raidicon = plate:GetRegions()
        local n = name:GetText()

        border:SetVertexColor(.2, .2, .2)

        name:SetFont(STANDARD_TEXT_FONT, 12)
        name:ClearAllPoints()
        name:SetPoint('BOTTOMRIGHT', plate, 'TOPRIGHT', -4, -16)
        name:SetJustifyH'RIGHT'

        health:SetStatusBarTexture(TEXTURE)
        health:SetBackdrop(BACKDROP)
        health:SetBackdropColor(0, 0, 0)

        plate.cast = CreateFrame('StatusBar', nil, plate)
        plate.cast:SetStatusBarTexture(TEXTURE)
        plate.cast:SetStatusBarColor(1, .4, 0)
        plate.cast:SetBackdrop(BACKDROP)
        plate.cast:SetBackdropColor(0, 0, 0)
        plate.cast:SetHeight(8)
        plate.cast:SetPoint('LEFT', plate, 24, 0)
        plate.cast:SetPoint('RIGHT', plate, -4, 0)
        plate.cast:SetPoint('TOP', health, 'BOTTOM', 0, -8)

        plate.cast.text = plate.cast:CreateFontString(nil, 'OVERLAY')
        plate.cast.text:SetTextColor(1, 1, 1)
        plate.cast.text:SetFont(STANDARD_TEXT_FONT, 10)
        plate.cast.text:SetShadowOffset(1, -1)
        plate.cast.text:SetShadowColor(0, 0, 0)
        plate.cast.text:SetPoint('TOPLEFT', plate.cast, 'BOTTOMLEFT', 0, -2)

        plate.cast.timer = plate.cast:CreateFontString(nil, 'OVERLAY')
        plate.cast.timer:SetTextColor(1, 1, 1)
        plate.cast.timer:SetFont(STANDARD_TEXT_FONT, 9)
        plate.cast.timer:SetPoint('RIGHT', plate.cast)

        plate.cast.icon = plate.cast:CreateTexture(nil, 'OVERLAY', nil, 7)
        plate.cast.icon:SetWidth(16) plate.cast.icon:SetHeight(14)
        plate.cast.icon:SetPoint('RIGHT', plate.cast, 'LEFT', -5, 0)
        plate.cast.icon:SetTexture[[Interface\Icons\Spell_nature_purge]]
        plate.cast.icon:SetTexCoord(.1, .9, .1, .9)

        plate.cast.border = plate.cast:CreateTexture(nil, 'OVERLAY')
        plate.cast.border:SetTexture[[Interface\AddOns\modui\statusbar\texture\Nameplate-Castbar.blp]]
        plate.cast.border:SetHeight(32)
        plate.cast.border:SetPoint('TOPLEFT', plate, 'BOTTOMLEFT', 0, 8)
        plate.cast.border:SetPoint('TOPRIGHT', plate, 'BOTTOMRIGHT', 0, 8)
        plate.cast.border:SetVertexColor(.2, .2, .2)

        plate.heal = plate:CreateFontString(nil, 'OVERLAY')
        plate.heal:SetTextColor(0, .6, 0, .6)
        plate.heal:Hide()

        if class == 'Rogue' or class == 'Druid' then
            plate.cp = plate:CreateFontString(nil, 'OVERLAY')
            plate.cp:SetFont(STANDARD_TEXT_FONT, 20, 'OUTLINE')
            plate.cp:SetPoint('LEFT', health)
            plate.cp:Hide()
        end

        if not showpet then if isPet(n) then plate:Hide() end end

        plate.skinned = true
    end

    local addClass = function(plate)    -- CLASS COLOUR
        local health = plate:GetChildren()
        local _, _, name = plate:GetRegions()
        local n = name:GetText()
        local r = health:GetStatusBarColor()

        if not p[n] and not UnitName'target'
        and not string.find(n, '%s') and string.len(n) < 13
        and not t[n] then
            isPlayer(n) ClearTarget()
        end

        if p[n] and r > .9 then
            local colour = RAID_CLASS_COLORS[p[n]['class']]
            health:SetStatusBarColor(colour.r, colour.g, colour.b)
        end
    end

    local addCP = function(plate)       -- COMBOPOINT
        if plate.cp then
            local health = plate:GetChildren()
            local _, _, name = plate:GetRegions()
            local text   = name:GetText()
            local target = GetUnitName'target'
            local cp 	 = GetComboPoints()
            plate.cp:Hide()
            if target == text and health:GetAlpha() == 1 and cp > 0 then
                plate.cp:Show()
                plate.cp:SetText(cp)
                plate.cp:SetTextColor(.5*(cp - 1), 2/(cp - 1), .5/(cp - 1))
            end
        end
    end

    local addCast = function(plate)
        local health = plate:GetChildren()
        local _, _, name = plate:GetRegions()
        local text = name:GetText()
        local target = GetUnitName'target'
        plate.cast.text:SetText'' plate.cast.timer:SetText'' plate.cast.icon:SetTexture''
        plate.cast:Hide()
        for k, v in pairs(casts) do
            if v.caster == text then
                if GetTime() < v.timeEnd then
                    plate.cast:SetMinMaxValues(0, v.timeEnd - v.timeStart)
                	plate.cast:SetValue(mod((GetTime() - v.timeStart), v.timeEnd - v.timeStart))
                	plate.cast.text:SetText(v.spell)
                	plate.cast.timer:SetText(getTimerLeft(v.timeEnd)..'s')
                	plate.cast.icon:SetTexture(v.icon)
                    plate.cast:SetAlpha(plate:GetAlpha())
                	plate.cast:Show()
                end
            end
        end
    end

    local addHeal = function(plate)
        local _, _, name = plate:GetRegions()
        local text = name:GetText()
        plate.heal:Hide()
        for _, v in pairs(heals) do
            if v.target == text then
                if GetTime() < v.timeEnd then
                    local y = 14
                    if v.crit == 1 then
                        plate.heal:SetFont(STANDARD_TEXT_FONT, 28, 'OUTLINE')
                    else
                        plate.heal:SetFont(STANDARD_TEXT_FONT, 24, 'OUTLINE')
                        y = y + v.y
                        if y + v.y < y + 20 then v.y = v.y + 1 end
                    end
                    plate.heal:SetPoint('CENTER', plate, 0, y)
                    if (v.timeEnd - GetTime()) < .6 then
                        plate.heal:SetAlpha(mod((v.timeEnd - GetTime()), 1))
                    else
                        plate.heal:SetAlpha(.6)
                    end
                    plate.heal:SetText('+'..v.amount)
                    plate.heal:Show()
                end
            end
        end
    end

    local handleCast = function()
        local time = GetTime()
        local cast    = '(.+) begins to cast (.+).'        local fcast    = string.find(arg1, cast)
        local craft   = '(.+) -> (.+).'                    local fcraft   = string.find(arg1, craft)
        local perform = '(.+) begins to perform (.+).'     local fperform = string.find(arg1, perform)
        local gain    = '(.+) gains (.+).'                 local fgain    = string.find(arg1, gain)
        local afflict = '(.+) is afflicted by (.+).'       local fafflict = string.find(arg1, afflict)
        local hits    = '(.+)\'s (.+) hits (.+) for (.+)'  local fhits    = string.find(arg1, hits)
        local crits   = '(.+)\'s (.+) crits (.+) for (.+)' local fcrits   = string.find(arg1, crits)
        local phits   = 'Your (.+) hits (.+) for (.+)'     local fphits   = string.find(arg1, phits)
        local pcrits  = 'Your (.+) crits (.+) for (.+)'    local fpcrits  = string.find(arg1, pcrits)
        local fear  = '(.+) attempts to run away in fear!' local ffear    = string.find(arg1, fear)
        if fcast or fcraft or fperform then
            local t = fcast and cast or fcraft and craft or perform
            local c = gsub(arg1, t, '%1')
            local s = gsub(arg1, t, '%2')
            newCast(c, s)
        elseif fgain or fafflict or fhits or fcrits or fphits or fpcrits or ffear then
            local t, c, s
            if     fgain    then t = gain    c = gsub(arg1, t, '%1')
            elseif fafflict then t = afflict c = gsub(arg1, t, '%1')
            elseif fhits    then t = hits    c = gsub(arg1, t, '%3')
            elseif fcrits   then t = crits   c = gsub(arg1, t, '%3')
            elseif fphits   then t = phits   c = gsub(arg1, t, '%2')
            elseif fpcrits  then t = pcrits  c = gsub(arg1, t, '%2')
            elseif ffear    then t = fear    c = arg2 end
            if not ffear then s = gsub(arg1, t, '%2') end
            if fphits or fpcrits then s = gsub(arg1, t, '%1') end
            for k, v in pairs(casts) do
                if MODUI_INTERRUPTS_TO_TRACK[s] ~= nil or ffear then
                    if (time < v.timeEnd) and (v.caster == c) then
                        v.timeEnd = time - 10000 -- force hide
                    end
                end
            end
        end
    end

    local handleHeal = function()
        local h   = 'Your (.+) heals (.+) for (.+).'
        local c   = 'Your (.+) critically heals (.+) for (.+).'
        local hot = '(.+) gains (.+) health from your (.+).'
        if string.find(arg1, h) or string.find(arg1, c) then
            local n  = gsub(arg1, h, '%2')
            local no = gsub(arg1, h, '%3')
            newHeal(n, no, string.find(arg1, c) and 1 or 0)
        elseif string.find(arg1, hot) then
            local n  = gsub(arg1, hot, '%1')
            local no = gsub(arg1, hot, '%2')
            newHeal(n, no, 0)
        end
    end

    local f = CreateFrame'Frame'
    f:SetScript('OnUpdate', function()
        local frames = {WorldFrame:GetChildren()}
	    for _, plate in ipairs(frames) do
            if isPlate(plate) and plate:IsVisible() then
                local _, _, name = plate:GetRegions()
                if not plate.skinned then modPlate(plate) end
                addClass(plate) addCP(plate) addCast(plate) addHeal(plate)
            end
        end
    	local i = 1
    	for k, v in pairs(casts) do
    		if GetTime() > v.timeEnd then
    			table.remove(casts, i)
    		end
    		i = i + 1
    	end
        i = 1
        for k, v in pairs(heals) do
    		if GetTime() > v.timeEnd then
    			table.remove(heals, i)
    		end
    		i = i + 1
    	end
    end)

    f:RegisterEvent'CHAT_MSG_MONSTER_EMOTE'
    f:RegisterEvent'CHAT_MSG_SPELL_SELF_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_SELF_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PARTY_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PARTY_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS'
    f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:SetScript('OnEvent', function()
        if event == 'PLAYER_ENTERING_WORLD' then
             if enabled then ShowNameplates() end
        else handleCast() handleHeal() end
    end)


    --
