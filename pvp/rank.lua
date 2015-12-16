

    local p = function() local x = (math.floor(GetPVPRankProgress(target)*10000))/100 return x end
    local c = function() local x = (UnitPVPRank'player' - 6)*5000 + 5000*p()/100 if x == -30000 then x = 0 end return x end
    local n = function() local x = (UnitPVPRank'player' - 5)*5000 - c()*.8 if x == -25000 then x = '15 HK' end return x end

    local modprint = function()
        SendChatMessage('— PvP Rank: ['..(UnitPVPRank'player' - 4)..'] '..'Progress: ['..p()..'%] '..'Current RP: ['..c()..'] RP to next rank: ['..n()..'].', 'emote')
    end

    local modtip = function()
        GameTooltip:SetOwner(this, 'ANCHOR_NONE')
        GameTooltip:AddLine'|cffff6c6cmodRank|r'
        GameTooltip:AddLine' '
        GameTooltip:AddLine('These totals give a projection of the honour points needed to reach a new rank at the end of the week. PvP rankings are fluid & dependent on total RP earned across the server — therefore results may vary.', 1, .8, 0, true)
        GameTooltip:AddLine' '
        GameTooltip:AddDoubleLine('|cffeec265Progress:|r', p()..'%')
        GameTooltip:AddDoubleLine('|cffeec265Current RP:|r', c())
        GameTooltip:AddDoubleLine('|cffeec265RP to next rank:|r', n())
        GameTooltip:AddLine' '
        GameTooltip:AddLine('Click to broadcast data in chat window.', .3, 1, .6)
        GameTooltip:Show()
    end

    local f = CreateFrame('Button', 'modrp', HonorFrame, 'UIPanelButtonTemplate')
    f:SetWidth(40) f:SetHeight(20)
    f:SetText'—RP'
    f:SetFont(STANDARD_TEXT_FONT, 10)
    f:SetPoint('TOPRIGHT', HonorFrame, -50, -40)
    f:SetScript('OnClick', modprint)
    f:SetScript('OnEnter', modtip)
    f:SetScript('OnLeave', function() GameTooltip:Hide() end)

    --
