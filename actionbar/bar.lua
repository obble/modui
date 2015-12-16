

    MODUI_HORIZONTAL = true                         -- TOGGLE FULL HORIZONTALLY DISPLAYED ACTIONBARS

    local _, class = UnitClass'Player'
    local colour = RAID_CLASS_COLORS[class]

    local icon = CreateFrame('Button', 'modmenu', MainMenuBar)
    icon:SetWidth(18) icon:SetHeight(35)
    icon:SetPoint('LEFT', MainMenuBarPerformanceBarFrameButton, 'RIGHT', 0, -1)
    icon:SetFrameLevel(4)
    icon:Show()

    local t = icon:CreateFontString(nil, 'ARTWORK')
    t:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    t:SetPoint('CENTER', icon, .5, .5)
    t:SetText'M'
    t:SetTextColor(colour.r, colour.g, colour.b)

    if MODUI_HORIZONTAL then
        for i = 1, 12 do
            local bu = _G['MultiBarRightButton'..i]
            bu:SetFrameStrata'LOW' bu:ClearAllPoints()
            if i == 1 then
                bu:SetPoint('BOTTOM', MultiBarBottomLeftButton1, 'TOP', 0, 8)
            else
                local previous = _G['MultiBarRightButton'..i - 1]
                bu:SetPoint('LEFT', previous, 'RIGHT', 6, 0)
            end
        end

        for i = 1, 12 do
            local bu = _G['MultiBarLeftButton'..i]
            bu:SetFrameStrata'LOW' bu:ClearAllPoints()
            if i == 1 then
                bu:SetPoint('LEFT', MultiBarRightButton12, 'RIGHT', 12, 0)
            else
                local previous = _G['MultiBarLeftButton'..i - 1]
                bu:SetPoint('LEFT', previous, 'RIGHT', 6, 0)
            end
        end
    end

    --
