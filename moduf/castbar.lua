

    local TEXTURE  = [[Interface\AddOns\modui\modsb\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}
    local f = CreateFrame'Frame'
    local Cast = {} local casts = {}
    Cast.__index = modtcast

    TargetFrame.cast = CreateFrame('StatusBar', 'TargetFrame_modCastbar', TargetFrame)
    TargetFrame.cast:SetStatusBarTexture(TEXTURE)
    TargetFrame.cast:SetStatusBarColor(1, .4, 0)
    TargetFrame.cast:SetBackdrop(BACKDROP)
    TargetFrame.cast:SetBackdropColor(0, 0, 0)
    TargetFrame.cast:SetHeight(8)
    TargetFrame.cast:SetPoint('LEFT', TargetFrame, 33.5, 0)
    TargetFrame.cast:SetPoint('RIGHT', TargetFrame, -50, 0)
    TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -2)
    TargetFrame.cast:SetValue(0)
    TargetFrame.cast:Hide()

    TargetFrame.cast.text = TargetFrame.cast:CreateFontString(nil, 'OVERLAY')
    TargetFrame.cast.text:SetTextColor(1, 1, 1)
    TargetFrame.cast.text:SetFont(STANDARD_TEXT_FONT, 12)
    TargetFrame.cast.text:SetShadowOffset(1, -1)
    TargetFrame.cast.text:SetShadowColor(0, 0, 0)
    TargetFrame.cast.text:SetPoint('TOPLEFT', TargetFrame.cast, 'BOTTOMLEFT', 2, -5)
    TargetFrame.cast.text:SetText'Evocation'

    TargetFrame.cast.timer = TargetFrame.cast:CreateFontString(nil, 'OVERLAY')
    TargetFrame.cast.timer:SetTextColor(1, 1, 1)
    TargetFrame.cast.timer:SetFont(STANDARD_TEXT_FONT, 9)
    TargetFrame.cast.timer:SetShadowOffset(1, -1)
    TargetFrame.cast.timer:SetShadowColor(0, 0, 0)
    TargetFrame.cast.timer:SetPoint('RIGHT', TargetFrame.cast, -1, 1)
    TargetFrame.cast.timer:SetText'3.5s'

    TargetFrame.cast.icon = TargetFrame.cast:CreateTexture(nil, 'OVERLAY', nil, 7)
    TargetFrame.cast.icon:SetWidth(18) TargetFrame.cast.icon:SetHeight(18)
    TargetFrame.cast.icon:SetPoint('RIGHT', TargetFrame.cast, 'LEFT', -9, 0)
    TargetFrame.cast.icon:SetTexCoord(.1, .9, .1, .9)

    local ic = CreateFrame('Frame', nil, TargetFrame.cast)
    ic:SetAllPoints(TargetFrame.cast.icon)

    modSkin(TargetFrame.cast, 12)
    modSkinPadding(TargetFrame.cast, 2, 2, 2, 2, 2, 3, 2, 3)
    modSkinColor(TargetFrame.cast, .2, .2, .2)

    modSkin(ic, 13.5)
    modSkinPadding(ic, 3)
    modSkinColor(ic, .2, .2, .2)

    local getTimerLeft = function(tEnd)
        local t = tEnd - GetTime()
        if t > 5 then return decimal_round(t, 0) else return decimal_round(t, 1) end
    end

    Cast.create = function(caster, spell, icon, dur, time)
        local acnt = {}
        setmetatable(acnt, modtcast)
        acnt.caster    = caster
        acnt.spell     = spell
        acnt.icon      = icon
        acnt.timeStart = time
        acnt.timeEnd   = time + dur
        return acnt
    end

    local removeDoubleCast = function(caster)
    	local k = 1
    	for i, j in casts do
    		if j.caster == caster then table.remove(casts, k) end
    		k = k + 1
    	end
    end

    local removeCast = function()
        local i = 1
        for k, v in pairs(casts) do
            if GetTime() > v.timeEnd then table.remove(casts, i) end
            i = i + 1
        end
        f:SetScript('OnUpdate', nil)
        TargetFrame.cast:Hide()
    end

    local checkAuras = function()
        local n = 0
        for i = 1,  5 do
            local b = UnitBuff('target', i)
            if b then n = n + 1 end
        end
        for i = 1, 16 do
            local d = UnitDebuff('target', i)
            if d then n = n + 1 end
        end
        return n
    end

    local position = function()
        local aura = checkAuras()
        if TargetofTargetFrame:IsShown() then
            if aura < 11 then
                TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -35)
            elseif aura < 16 then
                TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -50)
            else
                TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -75)
            end
        else
            if aura < 7 then
                TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -2)
            elseif aura < 13 then
                TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -25)
            elseif aura < 19 then
                TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -50)
            else
                TargetFrame.cast:SetPoint('TOP', TargetFrame, 'BOTTOM', 0, -75)
            end
        end
    end

    local showCast = function()
        local target = GetUnitName'target'
        TargetFrame.cast:Hide()
        for k, v in pairs(casts) do
            if v.caster == target then
                if GetTime() < v.timeEnd then
                    TargetFrame.cast:SetMinMaxValues(0, v.timeEnd - v.timeStart)
                	TargetFrame.cast:SetValue(mod((GetTime() - v.timeStart), v.timeEnd - v.timeStart))
                	TargetFrame.cast.text:SetText(v.spell)
                	TargetFrame.cast.timer:SetText(getTimerLeft(v.timeEnd)..'s')
                	TargetFrame.cast.icon:SetTexture(v.icon)
                	TargetFrame.cast:Show()
                    position()
                else removeCast()
                end
            end
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
            f:SetScript('OnUpdate', showCast)
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
            local t, c
            if     fgain    then t = gain    c = '%1'
            elseif fafflict then t = afflict c = '%1'
            elseif fhits    then t = hits    c = '%3'
            elseif fcrits   then t = crits   c = '%3'
            elseif fphits   then t = phits   c = UnitName'player'
            elseif fpcrits  then t = pcrits  c = UnitName'player'
            elseif ffear    then t = fear    c = arg2 end
            if not ffear then local s = gsub(arg1, t, '%2') end
            for k, v in pairs(casts) do
                if MODUI_INTERRUPTS_TO_TRACK[s] ~= nil or ffear then
                    if (time < v.timeEnd) and (v.caster == c) then
                        v.timeEnd = time - 10000 -- force hide
                    end
                end
        	end
    	end
    end

    f:RegisterEvent'CHAT_MSG_MONSTER_EMOTE'
    f:RegisterEvent'CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PARTY_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_PARTY_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_CREATURE_BUFFS'
    f:RegisterEvent'CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE'
    f:RegisterEvent'CHAT_MSG_SPELL_SELF_BUFF'
    f:RegisterEvent'CHAT_MSG_SPELL_SELF_DAMAGE'
    f:SetScript('OnEvent', handleCast)

    --
