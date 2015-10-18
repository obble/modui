
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
        if string.find(arg1, 'The Alliance Flag was picked up')
        or string.find(arg1, '+ Alliance Flag') then
            local t = gsub(arg1, 'The Alliance Flag was picked up by (.+)!', '%1')
            a:SetText(t)
            a:Show()
        elseif string.find(arg1, 'The Alliance Flag was dropped')
        or string.find(arg1, 'captured the Alliance flag!') then
            a:Hide()
        elseif string.find(arg1, 'The Horde flag was picked up')
        or string.find(arg1, '+ Horde Flag') then
            local t = gsub(arg1, 'The Horde flag was picked up by (.+)!', '%1')
            h:SetText(t)
            h:Show()
        elseif  string.find(arg1, 'The Horde flag was dropped')
        or string.find(arg1, 'captured the Horde flag!') then
            h:Hide()
        end
    end)

    --
