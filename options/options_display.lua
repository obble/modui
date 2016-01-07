

    local _, class = UnitClass'player'
    local colour   = RAID_CLASS_COLORS[class]
    local menu     = _G['modui_options']

    RegisterCVar('modGryphon',    1, true)
    RegisterCVar('modEndcap',     1, true)
    RegisterCVar('modTimestamp',  0, true)
    RegisterCVar('modChatFormat', 1, true)
    RegisterCVar('modItemLink',   1, true)
    RegisterCVar('modAuraFormat', 0, true)

    local highlight = function()
        if modSkinned(this) then
            for _, v in pairs({modui_optionsactionbar, modui_display, modui_status, modui_elements, modui_colour, modui_optionsmodraid}) do modSkinColor(v, .2, .2, .2) end
            modSkinColor(this, 1, .8, 0)
        end
    end

    local reload = function()
        if not menu.reload:IsShown() then
            menu.reload:Show()
            menu:SetHeight(menu:GetHeight() + 50)
        end
    end

    local gryphon = function()
        if this:GetValue() == 1 then
            SetCVar('modGryphon', 1)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
                v:SetTexture[[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]]
            end
        else
            SetCVar('modGryphon', 0)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
                v:SetTexture[[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Dwarf]]
            end
        end
    end

    local auraformat = function()
        if this:GetValue() == 1 then SetCVar('modAuraFormat', 1, true) else SetCVar('modAuraFormat', 0, true) end
    end

    local timer = function(t, i)
        local time  = GetTime()
        local count = math.floor((t + i) - time)
        local mins  = floor(mod(count, 3600)/60 + 1)
        local f  = _G['modui_optionsaurabutton2text']
        if count <= 0 then count = 0 end
        _G['modui_optionsaurabutton1text']:SetText('|cffffffff'..mins..'|rm')
        _G['modui_optionsaurabutton2text']:SetText(SecondsToTimeAbbrev(count, true))
    end

    local aura = function()
        if not this:IsShown() then this:SetScript('OnUpdate', nil) return end
        local t = GetTime()
        local i = 1800
        this:SetScript('OnUpdate', function() timer(t, i) end)
    end

    menu.gryphon = CreateFrame('Slider', 'modui_gryphon', menu, 'OptionsSliderTemplate')
    menu.gryphon:SetWidth(200) menu.gryphon:SetHeight(20)
    menu.gryphon:SetPoint('TOP', menu, 0, -115)
    menu.gryphon:SetMinMaxValues(0, 1)
    menu.gryphon:SetValue(0)
    menu.gryphon:SetValueStep(1)
    menu.gryphon:SetScript('OnValueChanged', gryphon)
    menu.gryphon:Hide()
    _G[menu.gryphon:GetName()..'Low']:SetText'Gryphon'
    _G[menu.gryphon:GetName()..'High']:SetText'Lion'
    _G[menu.gryphon:GetName()..'Text']:SetText'Switch End Cap Textures'

    menu.gryphon.title = menu.gryphon:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.gryphon.title:SetTextColor(colour.r, colour.g, colour.b)
    menu.gryphon.title:SetPoint('TOPLEFT', menu, 30, -85)
    menu.gryphon.title:SetText'—MainBar Gryphon Options'

    menu.endcap = CreateFrame('CheckButton', 'modui_endcap', menu, 'UICheckButtonTemplate')
    menu.endcap:SetHeight(20) menu.endcap:SetWidth(20)
    menu.endcap:SetPoint('TOPLEFT', menu, 25, -145)
    menu.endcap:Hide()
    _G[menu.endcap:GetName()..'Text']:SetJustifyH'LEFT'
    _G[menu.endcap:GetName()..'Text']:SetWidth(270)
    _G[menu.endcap:GetName()..'Text']:SetPoint('LEFT', menu.endcap, 'RIGHT', 4, 0)
    _G[menu.endcap:GetName()..'Text']:SetText'Toggle Display of MainMenu End Cap Textures'

    menu.chatstamp = CreateFrame('CheckButton', 'modui_chatstamp', menu, 'UICheckButtonTemplate')
    menu.chatstamp:SetHeight(20) menu.chatstamp:SetWidth(20)
    menu.chatstamp:SetPoint('TOPLEFT', menu, 25, -185)
    menu.chatstamp:Hide()
    _G[menu.chatstamp:GetName()..'Text']:SetJustifyH'LEFT'
    _G[menu.chatstamp:GetName()..'Text']:SetWidth(270)
    _G[menu.chatstamp:GetName()..'Text']:SetPoint('LEFT', menu.chatstamp, 'RIGHT', 4, 0)
    _G[menu.chatstamp:GetName()..'Text']:SetText'Toggle Timestamps on Chat Messages'

    menu.chatstamp.title = menu.chatstamp:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.chatstamp.title:SetTextColor(colour.r, colour.g, colour.b)
    menu.chatstamp.title:SetPoint('TOPLEFT', menu, 30, -170)
    menu.chatstamp.title:SetText'—Chat Messages'

    menu.chatformat = CreateFrame('CheckButton', 'modui_chatformat', menu, 'UICheckButtonTemplate')
    menu.chatformat:SetHeight(20) menu.chatformat:SetWidth(20)
    menu.chatformat:SetPoint('TOPLEFT', menu, 25, -205)
    menu.chatformat:Hide()
    _G[menu.chatformat:GetName()..'Text']:SetJustifyH'LEFT'
    _G[menu.chatformat:GetName()..'Text']:SetWidth(270)
    _G[menu.chatformat:GetName()..'Text']:SetPoint('LEFT', menu.chatformat, 'RIGHT', 4, 0)
    _G[menu.chatformat:GetName()..'Text']:SetText'Toggle Custom Chat Channel Formatting.'

    menu.itemlink = CreateFrame('CheckButton', 'modui_itemlink', menu, 'UICheckButtonTemplate')
    menu.itemlink:SetHeight(20) menu.itemlink:SetWidth(20)
    menu.itemlink:SetPoint('TOPLEFT', menu, 25, -225)
    menu.itemlink:Hide()
    _G[menu.itemlink:GetName()..'Text']:SetJustifyH'LEFT'
    _G[menu.itemlink:GetName()..'Text']:SetWidth(270)
    _G[menu.itemlink:GetName()..'Text']:SetPoint('LEFT', menu.itemlink, 'RIGHT', 4, 0)
    _G[menu.itemlink:GetName()..'Text']:SetText'Toggle |cffc600ff[Brackets]|r on Item Links.'

    menu.auraformat = CreateFrame('Slider', 'modui_optionsauraformat', menu, 'OptionsSliderTemplate')
    menu.auraformat:SetWidth(200) menu.auraformat:SetHeight(20)
    menu.auraformat:SetPoint('TOP', menu, 0, -275)
    menu.auraformat:SetMinMaxValues(0, 1)
    menu.auraformat:SetValue(0)
    menu.auraformat:SetValueStep(1)
    menu.auraformat:SetScript('OnValueChanged', auraformat)
    menu.auraformat:Hide()
    _G[menu.auraformat:GetName()..'Low']:SetText'Round Numbers'
    _G[menu.auraformat:GetName()..'High']:SetText'H:M:S'
    _G[menu.auraformat:GetName()..'Text']:SetText'Aura Duration Formatting'

    menu.auraformat.title = menu.auraformat:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    menu.auraformat.title:SetTextColor(colour.r, colour.g, colour.b)
    menu.auraformat.title:SetPoint('TOPLEFT', menu, 30, -250)
    menu.auraformat.title:SetText'—Auras'

    for i = 1, 2 do
        menu.aurabutton = CreateFrame('CheckButton', 'modui_optionsaurabutton'..i, menu)
        menu.aurabutton:SetHeight(28) menu.aurabutton:SetWidth(28)
        menu.aurabutton:SetPoint(i == 1 and 'TOPRIGHT' or 'TOPLEFT',
                                 i == 1 and _G[menu.auraformat:GetName()..'Low'] or _G[menu.auraformat:GetName()..'High'],
                                 i == 1 and 'BOTTOMLEFT' or 'BOTTOMRIGHT',
                                 i == 1 and -15 or 15,
                                 15)
        menu.aurabutton:Hide()

        menu.aurabutton.icon = menu.aurabutton:CreateTexture(nil, 'ARTWORK')
        menu.aurabutton.icon:SetAllPoints()
        menu.aurabutton.icon:SetTexture[[Interface\Icons\Spell_holy_magicalsentry]]
        menu.aurabutton.icon:SetTexCoord(.1, .9, .1, .9)

        menu.aurabutton.duration = menu.aurabutton:CreateFontString('modui_optionsaurabutton'..i..'text', 'OVERLAY', 'GameFontNormalSmall')
        menu.aurabutton.duration:SetPoint('TOP', menu.aurabutton, 'BOTTOM', 2, -6)
        menu.aurabutton.duration:SetText'|cffffffff30|rm'
    end

    menu.display = CreateFrame('Button', 'modui_display', menu, 'UIPanelButtonTemplate')
    menu.display:SetWidth(100) menu.display:SetHeight(20)
    menu.display:SetText'Display'
    menu.display:SetFont(STANDARD_TEXT_FONT, 10)
    menu.display:SetPoint('TOPLEFT', menu, 25, -30)

    menu.display:SetScript('OnClick', function()
        highlight()
        for _, v in pairs({menu.intro, menu.uilink, menu.description, menu.whisper, menu.horizontal, menu.value, menu.consolidate, menu.elements.title, menu.elements.description, menu.elementcontainer, menu.allelement, menu.actionlayout, menu.modraid.apology}) do v:Hide() end
        for i = 1, 11 do _G['modui_element'..i]:Hide() end
        for i = 1, 60 do _G['modui_actionbutton'..i]:Hide() end
        for _, v in pairs({menu.gryphon, menu.endcap, menu.chatstamp, menu.chatformat, menu.itemlink, menu.auraformat}) do v:Show() end
        for i = 1,  2 do _G['modui_optionsaurabutton'..i]:Show() end
        menu.reload:SetPoint('TOP', menu, 0, -370)
        if menu.reload:IsShown() then
            menu:SetHeight(410)
        else
            menu:SetHeight(370)
        end
    end)

    menu.gryphon:SetScript('OnValueChanged', gryphon)

    menu.endcap:SetScript('OnClick', function()
        if this:GetChecked() == 1 then
            SetCVar('modEndcap', 1)
            OptionsFrame_EnableSlider(menu.gryphon)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do v:Show() end
        else
            SetCVar('modEndcap', 0)
            OptionsFrame_DisableSlider(menu.gryphon)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do v:Hide() end
         end
    end)

    menu.chatstamp:SetScript('OnClick', function()
        if this:GetChecked() == 1 then SetCVar('modTimestamp', 1) else SetCVar('modTimestamp', 0) end
    end)

    menu.chatformat:SetScript('OnClick', function()
        if this:GetChecked() == 1 then SetCVar('modChatFormat', 1) reload() else SetCVar('modChatFormat', 0) reload() end
    end)

    menu.itemlink:SetScript('OnClick', function()
        if this:GetChecked() == 1 then SetCVar('modItemLink', 1) else SetCVar('modItemLink', 0) end
    end)

    menu.aurabutton:SetScript('OnShow', aura)
    menu.aurabutton:SetScript('OnHide', aura)

    local f = CreateFrame'Frame'
    f:RegisterEvent'PLAYER_ENTERING_WORLD'
    f:SetScript('OnEvent', function()
        local cv = tonumber(GetCVar'modGryphon')
        if cv == 1 then
            menu.gryphon:SetValue(1)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
                v:SetTexture[[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Human]]
            end
        else
            menu.gryphon:SetValue(0)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do
                v:SetTexture[[Interface\MainMenuBar\UI-MainMenuBar-EndCap-Dwarf]]
            end
        end
        local cv = tonumber(GetCVar'modEndcap')
        if cv == 1 then
            menu.endcap:SetChecked(true)
            OptionsFrame_EnableSlider(menu.gryphon)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do v:Show() end
        else
            menu.endcap:SetChecked(false)
            OptionsFrame_DisableSlider(menu.gryphon)
            for _, v in pairs({MainMenuBarLeftEndCap, MainMenuBarRightEndCap}) do v:Hide() end
        end
        local cv = tonumber(GetCVar'modTimestamp')
        if cv == 1 then menu.chatstamp:SetChecked(true) else menu.chatstamp:SetChecked(false) end
        local cv = tonumber(GetCVar'modChatFormat')
        if cv == 1 then menu.chatformat:SetChecked(true) else menu.chatstamp:SetChecked(false) end
        local cv = tonumber(GetCVar'modItemLink')
        if cv == 1 then menu.itemlink:SetChecked(true) else menu.itemlink:SetChecked(false) end
        local cv = tonumber(GetCVar'modAuraFormat')
        if cv == 1 then menu.auraformat:SetValue(1) else menu.auraformat:SetValue(0) end
    end)

    --
