

    if tonumber(GetCVar'modUnitFrame') == 0 then return end

    local move = function()
        for _, v in pairs ({MobHealth3BlizzardHealthText, MobHealth3BlizzardPowerText}) do
            v:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
            v:SetShadowOffset(0, 0)
            v:SetJustifyV'MIDDLE'
            if GetCVar'modStatus'  == '0' and GetCVar'modBoth' == '0' then
                v:ClearAllPoints()
                v:SetPoint('CENTER',
                            TargetFrame,
                            v:GetName() == 'MobHealth3BlizzardPowerText' and -30 or -80,
                            -2)
            end
        end
    end

    function MH3Blizz:HealthUpdate()
        local v, max  = MobHealth3:GetUnitHealth('target', UnitHealth'target', UnitHealthMax'target')
        local percent = math.floor(v/max*100)
        local string  = MobHealth3BlizzardHealthText
        move()

        if MH3BlizzConfig.healthAbs then
            if max == 100 then
                -- Do nothing!
            else
                v = math.floor(v)
            end
        end

        if GetCVar'modBoth' == '1' then
            if max == 100 then
                string:SetText(percent..'%')
            else
                string:SetText(true_format(v)..'/'..true_format(max)..' — '..percent..'%')
            end
            string:SetPoint('RIGHT', -8, 0)
        elseif GetCVar'modValue'  == '1' and GetCVar'modBoth' == '0' then
            local logic = MH3BlizzConfig.healthPerc and v <= 100 and percent == v
            local t = logic and true_format(v)..'%' or true_format(v)
            string:SetText(t)
        else
            string:SetText(percent..'%')
        end
    end

    function MH3Blizz:PowerUpdate()
        local _, class = UnitClass'target'
        local v, max   = UnitMana'target', UnitManaMax'target'
        local percent  = math.floor(v/max*100)
        local string   = MobHealth3BlizzardPowerText
        move()

        if max == 0 or cur == 0 or percent == 0 then string:SetText() return end
        if MH3BlizzConfig.powerAbs then v = math.floor(v) end

        if GetCVar'modBoth' == '1' then
            if max == 100 then
                string:SetText(percent..'%')
            else
                string:SetText(true_format(v)..'/'..true_format(max)..' — '..percent..'%')
            end
            string:SetPoint('RIGHT', -8, 0)
        elseif GetCVar'modValue'  == '1' and GetCVar'modBoth' == '0' then
            local logic = MH3BlizzConfig.powerPerc and v <= 100 and percent == v and class ~= 'ROGUE'
            local t = logic and true_format(v)..'%' or true_format(v)
            string:SetText(t)
        else
            string:SetText(percent..'%')
        end
    end

    local f = CreateFrame'Frame'
    f:RegisterEvent'CVAR_UPDATE' f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:SetScript('OnEvent', function()
        if arg1 == 'STATUS_BAR_TEXT' or event == 'PLAYER_ENTERING_WORLD' then
            if GetCVar'statusBarText' == '0' then
                MobHealth3BlizzardHealthText:Hide() MobHealth3BlizzardPowerText:Hide()
                TargetFrameHealthBar:SetScript('OnEnter', function() MobHealth3BlizzardHealthText:Show() end)
                TargetFrameHealthBar:SetScript('OnLeave', function() MobHealth3BlizzardHealthText:Hide() end)
                TargetFrameManaBar:SetScript('OnEnter', function() MobHealth3BlizzardPowerText:Show() end)
                TargetFrameManaBar:SetScript('OnLeave', function() MobHealth3BlizzardPowerText:Hide() end)
            else
                MobHealth3BlizzardHealthText:Show() MobHealth3BlizzardPowerText:Show()
            end
        end
    end)

    --
