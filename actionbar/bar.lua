

    local _, class = UnitClass'Player'
    local colour = RAID_CLASS_COLORS[class]

    local icon = CreateFrame('Button', 'modmenu', MainMenuBar)
    icon:SetWidth(18) icon:SetHeight(35)
    icon:SetPoint('LEFT', MainMenuBarPerformanceBarFrameButton, 'RIGHT', 0, -1)
    icon:SetFrameLevel(4)
    icon:Show()

    local t = icon:CreateFontString(nil, 'ARTWORK') -- MENU OPTIONS ICON
    t:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
    t:SetPoint('CENTER', icon, .5, .5)
    t:SetText'M'
    t:SetTextColor(colour.r, colour.g, colour.b)

    --
