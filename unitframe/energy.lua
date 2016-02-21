

    if tonumber(GetCVar'modUnitFrame') == 0 then return end

    local class = UnitClass'player'
    if not (class == 'Rogue' or class == 'Druid') then return end

    local t    = 0
    local last = 0
    local tick = 0

    local energy = CreateFrame('Statusbar', nil, PlayerFrameTexture:GetParent())
    energy:SetStatusBarTexture[[Interface\TargetingFrame\UI-StatusBar]]
    energy:SetMinMaxValues(0, 2) energy:SetValue(0)
    energy:SetAllPoints(PlayerFrameManaBar)
    energy:SetStatusBarColor(0, 0, 0, 0)

    local spark = energy:CreateTexture(nil, 'OVERLAY')
    spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
    spark:SetWidth(32) spark:SetHeight(32)
    spark:SetBlendMode'ADD'

    local energy_OnUpdate = function()
        local v = mod((GetTime() - t), 2)
        energy:SetValue(v)
        spark:SetPoint('CENTER', energy, 'LEFT', energy:GetWidth()*(v/2), 0)
        tick = v
    end

    energy:SetScript('OnEvent', function()
        if arg1 == 'PLAYER_AURAS_CHANGED' then
            local stance = GetShapeshiftForm(true)
            local power  = UnitPowerType'player'
            if (class == 'Druid' and stance == 3) or power == 3 then
                 energy:Show()
            else energy:Hide()
            end
        else
            local p = UnitMana'player'
        	if arg1 == 'player' and p < 100 then
        		if p == last + 20 then t = GetTime() end
        		last = p
                energy:SetScript('OnUpdate', energy_OnUpdate)
                energy:Show()
            else
                energy:SetScript('OnUpdate', nil)
                energy:Hide()
        	end
        end
    end)

    energy:RegisterEvent'PLAYER_AURAS_CHANGED'
    energy:RegisterEvent'UNIT_ENERGY'

    --
