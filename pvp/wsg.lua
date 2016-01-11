

    local h = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
    h:SetFontObject(GameFontNormalSmall)
    h:SetTextColor(0, .8, .5)
    h:SetJustifyH'LEFT'
    h:SetPoint('TOPLEFT', UIParent, 'TOP', 40, -32)
    h:Hide()

    ho = CreateFrame('Button', 'modflag_hordeFC', WorldStateAlwaysUpFrame)
    ho:SetFrameLevel(2)
    ho:SetAllPoints(h)
    ho:EnableMouse(true)
    ho:SetScript('OnMouseDown', function() print'clicked!' target() end)
    ho:Hide()

    local a = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
    a:SetFontObject(GameFontNormalSmall)
    a:SetTextColor(1, 0, 0)
    a:SetJustifyH'LEFT'
    a:SetPoint('TOPLEFT', UIParent, 'TOP', 40, -55)
    a:Hide()

    al = CreateFrame('Button', 'modflag_allianceFC', WorldStateAlwaysUpFrame)
    al:SetFrameLevel(2)
    al:SetAllPoints(a)
    al:EnableMouse(true)
    al:Hide()

    local target = function()
        local text = this == ho and h or a
        local t = text:GetText()
        this:SetAttribute('macrotext', '/tar '..t)
    end

    -- ho:SetScript('OnClick', function() print'clicked!' target() end)
    -- al:SetScript('OnClick', function() print'clicked!' target() end)

    local f = CreateFrame'Frame'
    f:RegisterEvent'CHAT_MSG_BG_SYSTEM_ALLIANCE' f:RegisterEvent'CHAT_MSG_BG_SYSTEM_HORDE'
    f:SetScript('OnEvent', function()
        if tonumber(GetCVar'modPVPTimers') then
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

            ho:SetAllPoints(h) ho:SetHeight(15)
            al:SetAllPoints(a) al:SetHeight(15)

            if a:IsShown() then al:Show() else al:Hide() end
            if h:IsShown() then ho:Show() else ho:Hide() end
        end
    end)

    --
