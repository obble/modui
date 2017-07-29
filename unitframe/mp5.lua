

    if tonumber(GetCVar'modUnitFrame') == 0 then return end

    local classes = {
        ['DRUID']      = true,
        ['HUNTER']     = true,
        ['MAGE']       = true,
        ['PALADIN']    = true,
        ['PRIEST']     = true,
        ['SHAMAN']     = true,
        ['WARLOCK']    = true
    }

    local _, class = UnitClass'player'
    if not classes[strupper(class)]  then return end

    local t    = 0
    local last = 0
    local tick = 0

    local MP5 = CreateFrame('Statusbar', nil, PlayerFrameManaBar)
    MP5:SetWidth(PlayerFrameManaBar:GetWidth())
    MP5:SetAllPoints(PlayerFrameManaBar)
    MP5:Hide()

    local spark = MP5:CreateTexture(nil, 'OVERLAY')
    spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
    spark:SetWidth(32) spark:SetHeight(32)
    spark:SetBlendMode'ADD'
    spark:SetAlpha(.2)

    local OnUpdate = function()
        local v = mod((GetTime() - t), 5)
        MP5:SetValue(v)
        spark:SetPoint('CENTER', MP5, 'LEFT', MP5:GetWidth()*(v/5), 0)
        tick = v
    end

    local OnEvent = function(unit)
        if  event == 'PLAYER_REGEN_DISABLED' then
            spark:SetAlpha(1)
        elseif event == 'PLAYER_REGEN_ENABLED' then
            spark:SetAlpha(.2)
        elseif event == 'PLAYER_AURAS_CHANGED' then
            if  UnitPowerType'player' == 0 then
                MP5:Show()
            else
                MP5:Hide()
            end
        else
            if  unit == 'player' and UnitPowerType'player' == 0 then
                local v = UnitMana'player'
                if v > last then t = GetTime() end
        		last = v
                MP5:SetScript('OnUpdate', OnUpdate)
            end
        end
        --
    end

    local e = CreateFrame'Frame'
    e:RegisterEvent'PLAYER_REGEN_ENABLED'
    e:RegisterEvent'PLAYER_REGEN_DISABLED'
    e:RegisterEvent'PLAYER_AURAS_CHANGED'
    e:RegisterEvent'UNIT_MANA'
    e:SetScript('OnEvent', OnEvent)
