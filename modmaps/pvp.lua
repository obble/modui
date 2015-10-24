

    local faction = UnitFactionGroup'player'

    local enable = function()
        local bu = CreateFrame('Frame', nil, BattlefieldMinimap)
        bu:SetPoint('TOPLEFT', BattlefieldMinimap2, -2, 0)
        bu:SetPoint('BOTTOMRIGHT', BattlefieldMinimap11, 0, 20)

        modSkin(bu, 16)
        modSkinPadding(bu, 2)
        modSkinColor(bu, .2, .2, .2)

        for _, v in pairs ({
            BattlefieldMinimap1, BattlefieldMinimap5, BattlefieldMinimap9,
            BattlefieldMinimap4, BattlefieldMinimap8, BattlefieldMinimap12
        }) do
            v:Hide()
        end

        BattlefieldMinimap:SetScale(1.05)
        BattlefieldMinimap:SetPoint('TOPLEFT', BattlefieldMinimapTab, 'BOTTOMLEFT', -52, 0)
        BattlefieldMinimapCloseButton:SetScale(.8) BattlefieldMinimapCloseButton:SetPoint('TOPRIGHT', BattlefieldMinimap3)
        BattlefieldMinimapCorner:Hide()
        BattlefieldMinimapBackground:Hide()
    end

    local logic = function(name, s)
        if string.find(s, 'The Alliance Flag was picked up')
        or string.find(s, '+ Alliance Flag')
        or string.find(s, 'The Horde flag was picked up')
        or string.find(s, '+ Horde Flag') then
            local t   = gsub(s, 'was picked up by (.+)!', '%1')
            local sub = gsub(s, 'Flag — (.+)', '%1')
            if name and (string.find(name, t) or string.find(name, sub)) then
                return 1
            end
        elseif string.find(s, 'The Horde flag was dropped')
            or string.find(s, '- Horde Flag')
            or string.find(s, 'The Alliance Flag was dropped')
            or string.find(s, '- Alliance Flag') then
            return 0 -- boolean to prevent conflicting false returns in handler
        end
    end


    local blips = function(s)
        for i = 1, 40 do
            local blip = _G['BattlefieldMinimapRaid'..i]
            local icon = _G['BattlefieldMinimapRaid'..i..'Icon']
            local unit = blip.unit
            local name = blip.name or UnitName(blip.unit)
            if not name then break end

            blip:SetWidth(24) blip:SetHeight(24)

            if string.find(unit, 'raid', 1, true) then
                local _, _, subgroup = GetRaidRosterInfo(string.sub(unit, 5))
                local class  = UnitClass(unit)
                local colour = class and RAID_CLASS_COLORS[string.upper(class)] or {r = 1, g = .8, b = 0}
                if s ~= nil then
                    local fc = logic(name, s)
                    if fc == 1 then
                        local path = faction == 'Alliance' and [[Interface\WorldStateFrame\AllianceFlag]]
                                                            or [[Interface\WorldStateFrame\HordeFlag]]
                        icon:SetTexture(path)
                        icon:SetVertexColor(1, 1, 1)
                    elseif fc == 0 then
                        icon:SetTexture(string.format([[Interface\AddOns\modui\modmaps\blips\raid]]..'%d', subgroup))
                        icon:SetVertexColor(colour.r, colour.g, colour.b)
                    end
                else
                    icon:SetTexture(string.format([[Interface\AddOns\modui\modmaps\blips\raid]]..'%d', subgroup))
                    icon:SetVertexColor(colour.r, colour.g, colour.b)
                end
            end
        end
    end

    local f = CreateFrame'Frame'
    f:RegisterEvent'ADDON_LOADED'
    f:SetScript('OnEvent', function()
        if f.loaded then
            if event == 'CHAT_MSG_BG_SYSTEM_HORDE'
            or event == 'CHAT_MSG_BG_SYSTEM_ALLIANCE' then
                local s = arg1 blips(s)
            else
                local s = nil  blips(s)
            end
        end
        if arg1 == 'Blizzard_BattlefieldMinimap' then
            local s = nil
            enable() blips(s)
            this:RegisterEvent'CHAT_MSG_BG_SYSTEM_ALLIANCE' this:RegisterEvent'CHAT_MSG_BG_SYSTEM_HORDE'
            this:RegisterEvent'RAID_ROSTER_UPDATE'
            this:UnregisterEvent'ADDON_LOADED'
            f.loaded = true
        end
    end)

    --
