    if tonumber(GetCVar'modUnitFrame') == 0 then return end

    local _, class = UnitClass('player')
    if not (class == 'ROGUE' or class == 'DRUID') then return end


    local lastEnergyValue       = 0
    local currentEnergyValue    = 0
    local lastPulseTime         = 0

    local energy = CreateFrame('Statusbar', nil, PlayerFrameManaBar)
    energy:SetWidth(PlayerFrameManaBar:GetWidth())
    energy:SetAllPoints(PlayerFrameManaBar)

    local spark = energy:CreateTexture(nil, 'OVERLAY')
    spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
    spark:SetWidth(32) spark:SetHeight(32)
    spark:SetBlendMode('ADD')

    local energy_OnUpdate = function()
        local v = mod((GetTime() - lastPulseTime), 2)
        spark:SetPoint('CENTER', energy, 'LEFT', energy:GetWidth()*(v/2), 0)
    end

    energy:SetScript('OnEvent', function()
        if arg1 == 'PLAYER_AURAS_CHANGED' then
            local stance = GetShapeshiftForm(true)
            local power  = UnitPowerType('player')
            if (class == 'DRUID' and stance == 3) or power == 3 then
                 energy:Show()
            else 
                energy:Hide()
            end
        else
            if arg1 == 'player' then
                currentEnergyValue = UnitMana('player')
                if currentEnergyValue == lastEnergyValue + 20 then 
                    lastPulseTime = GetTime()
                end
                lastEnergyValue = currentEnergyValue
            end
        end
    end)

    energy:SetScript('OnUpdate', energy_OnUpdate)

    energy:RegisterEvent('PLAYER_AURAS_CHANGED')
    energy:RegisterEvent('UNIT_ENERGY')