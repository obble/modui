

    local _, class = UnitClass'player'
    local colour   = RAID_CLASS_COLORS[class]
    local menu     = _G['modui_options']

    local highlight = function()
        if modSkinned(this) then
            for _, v in pairs({modui_optionsactionbar, modui_display, modui_status, modui_elements, modui_colour, modui_optionsmodraid}) do modSkinColor(v, .2, .2, .2) end
            modSkinColor(this, 1, .8, 0)
        end
    end

    menu.modraid = CreateFrame('Button', 'modui_optionsmodraid', menu, 'UIPanelButtonTemplate')
    menu.modraid:SetWidth(100) menu.modraid:SetHeight(20)
    menu.modraid:SetText'Raid Frames'
    menu.modraid:SetFont(STANDARD_TEXT_FONT, 10)
    menu.modraid:SetPoint('LEFT', menu.actionbar, 'RIGHT', 3, 0)

    menu.modraid.apology = menu.modraid:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
    menu.modraid.apology:SetPoint('TOP', menu, 0, -150)
    menu.modraid.apology:SetText'Coming Soon!'
    menu.modraid.apology:Hide()

    menu.modraid:SetScript('OnClick', function()
        highlight()
        for _, v in pairs({modui_optionsactionlayout, menu.intro, menu.uilink, menu.description, menu.whisper, menu.gryphon, menu.endcap, menu.chatstamp, menu.chatformat, menu.itemlink, menu.auraformat, menu.horizontal, menu.value, menu.consolidate, menu.elements.title, menu.elements.description, menu.elementcontainer, menu.allelement, menu.actionlayout}) do v:Hide() end
        for i = 1,  2 do _G['modui_optionsaurabutton'..i]:Hide() end
        for i = 1, 11 do _G['modui_element'..i]:Hide() end
        for i = 1, 60 do _G['modui_actionbutton'..i]:Hide() end
        menu.modraid.apology:Show()
        menu.reload:SetPoint('TOP', menu, 0, -295)
        if menu.reload:IsShown() then menu:SetHeight(340) else menu:SetHeight(280) end
    end)

    --
