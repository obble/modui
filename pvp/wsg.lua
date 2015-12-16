

    local h = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
    h:SetFontObject(GameFontNormalSmall)
    h:SetTextColor(0, .8, .5)
    h:SetJustifyH'LEFT'
    h:SetPoint('TOPLEFT', UIParent, 'TOP', 40, -32)

    local a = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
    a:SetFontObject(GameFontNormalSmall)
    a:SetTextColor(1, 0, 0)
    a:SetJustifyH'LEFT'
    a:SetPoint('TOPLEFT', UIParent, 'TOP', 40, -55)

    local f = CreateFrame'Frame'
    f:RegisterEvent'CHAT_MSG_BG_SYSTEM_ALLIANCE' f:RegisterEvent'CHAT_MSG_BG_SYSTEM_HORDE'
    f:SetScript('OnEvent', function()
        local s = arg1
        if string.find(s, 'The Alliance Flag was picked up')
        or string.find(s, '+ Alliance Flag') then
            local t = gsub(s, 'The Alliance Flag was picked up by (.+)!', '%1')
            a:SetText(t)
            a:Show()
        elseif string.find(s, 'The Alliance Flag was dropped')
        or string.find(s, 'captured the Alliance flag!') then
            a:Hide()
        elseif string.find(s, 'The Horde flag was picked up')
        or string.find(s, '+ Horde Flag') then
            local t = gsub(s, 'The Horde flag was picked up by (.+)!', '%1')
            h:SetText(t)
            h:Show()
        elseif  string.find(s, 'The Horde flag was dropped')
        or string.find(s, 'captured the Horde flag!') then
            h:Hide()
        end
    end)

    --
