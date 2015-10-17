
    local hi = _G['AlwaysUpFrame1DynamicIconButtonIcon']
    local ai = _G['AlwaysUpFrame2DynamicIconButtonIcon']

    local h = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
    h:SetFontObject(GameFontNormalSmall)
    h:SetTextColor(0, .8, .5)
    h:SetPoint('LEFT', hi, 'RIGHT')

    local a = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
    a:SetFontObject(GameFontNormalSmall)
    a:SetTextColor(1, 0, 0)
    a:SetPoint('LEFT', ai, 'RIGHT')

    local f = CreateFrame'Frame'
    f:RegisterEvent'CHAT_MSG_BG_SYSTEM_ALLIANCE' f:RegisterEvent'CHAT_MSG_BG_SYSTEM_HORDE'
    f:SetScript('OnEvent', function()
        if arg1 == 'CHAT_MSG_BG_SYSTEM_ALLIANCE' then
            if string.find(arg1, 'The Alliance Flag was picked up') then
                local t = gsub(arg1, 'The Alliance Flag was picked up by (.+)!', '%1')
                a:SetText(t)
                a:Show()
            elseif not ai:IsShown() then a:Hide() end
        else
            if string.find(arg1, 'The Horde flag was picked up') then
                local t = gsub(arg1, 'The Horde flag was picked up by (.+)!', '%1')
                h:SetText(t)
                h:Show()
            elseif not hi:IsShown() then h:Hide() end
        end
    end)

    --
