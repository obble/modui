

    local BG = [[Interface\AddOns\modui\modsb\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]]}
    local _, class = UnitClass'player'
    local colour = RAID_CLASS_COLORS[class]
    local orig = {}

    PlayerFrameBackground.bg = PlayerFrame:CreateTexture(nil, 'ARTWORK')
    PlayerFrameBackground.bg:SetPoint('TOPLEFT', PlayerFrameBackground)
    PlayerFrameBackground.bg:SetPoint('BOTTOMRIGHT', PlayerFrameBackground, 0, 22)
    PlayerFrameBackground.bg:SetVertexColor(colour.r, colour.g, colour.b, 1)
    PlayerFrameBackground.bg:SetTexture(BG)
    PlayerFrameBackground.bg:SetTexCoord(1, 0, 0, 1)

    PlayerFrame.status = PlayerFrameTexture:GetParent():CreateFontString(nil, 'OVERLAY')
    PlayerFrame.status:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
    PlayerFrame.status:SetShadowOffset(0, 0)
    PlayerFrame.status:SetTextColor(1, 0, 0)
    PlayerFrame.status:SetPoint('CENTER', PlayerFrameHealthBar, 0, -5)

    PlayerFrameHealthBar:SetBackdrop(BACKDROP)
    PlayerFrameHealthBar:SetBackdropColor(0, 0, 0, .6)

    PlayerFrameManaBar:SetBackdrop(BACKDROP)
    PlayerFrameManaBar:SetBackdropColor(0, 0, 0, .6)

    TargetFrameNameBackground:SetTexture(BG)
    TargetFrameNameBackground:SetDrawLayer'BORDER'

    TargetFrameHealthBar:SetBackdrop(BACKDROP)
    TargetFrameHealthBar:SetBackdropColor(0, 0, 0, .6)

    TargetFrameManaBar:SetBackdrop(BACKDROP)
    TargetFrameManaBar:SetBackdropColor(0, 0, 0, .6)

    PlayerFrameGroupIndicator:SetAlpha(0)
    PlayerHitIndicator:SetText(nil)
    PlayerHitIndicator.SetText = function() end
    PetHitIndicator:SetText(nil)
    PetHitIndicator.SetText = function() end

    TargetLevelText:SetJustifyH'LEFT'
    TargetLevelText:SetPoint('LEFT', TargetFrameTextureFrame, 'CENTER', 56, -16)

    local classification = TargetFrameTextureFrame:CreateFontString(nil, 'OVERLAY')
    classification:SetFontObject(GameFontNormalSmall)


    local colourParty = function()              -- PARTY CLASS COLOUR
        for i = 1, MAX_PARTY_MEMBERS do
            local name = _G['PartyMemberFrame'..i..'Name']
            if UnitIsPlayer('party'..i) then
                local _, class = UnitClass('party'..i)
                local colour = RAID_CLASS_COLORS[class]
                if colour then name:SetTextColor(colour.r, colour.g, colour.b) end
            else
                name:SetTextColor(1, .8, 0)
            end
        end
    end


    function TargetFrame_OnShow() end           -- REMOVE TARGETING SOUND
    function TargetFrame_OnHide() CloseDropDownMenus() end


    t = CreateFrame'Frame'
    t:RegisterEvent'PLAYER_TARGET_CHANGED' t:RegisterEvent'UNIT_FACTION' t:RegisterEvent'PARTY_MEMBERS_CHANGED'
    t:SetScript('OnEvent', function()           -- COLOUR UNIT
        local _, class = UnitClass'target'
        local colour = RAID_CLASS_COLORS[class]
        if UnitIsPlayer'target' then TargetFrameNameBackground:SetVertexColor(colour.r, colour.g, colour.b, 1) end
        if arg1 == 'PARTY_MEMBERS_CHANGED' then colourParty() end
    end)

    orig.ShowPartyFrame                    = ShowPartyFrame
    orig.TargetFrame_CheckClassification   = TargetFrame_CheckClassification
    orig.TextStatusBar_UpdateTextString    = TextStatusBar_UpdateTextString
    orig.UIOptionsFrame_UpdateDependencies = UIOptionsFrame_UpdateDependencies

    function ShowPartyFrame()
        orig.ShowPartyFrame() colourParty()
    end

    function TargetFrame_CheckClassification()  -- BOSS/ELITE/RARE TAGS
        orig.TargetFrame_CheckClassification()
        local c = UnitClassification'target'
        if c ~= 'normal' then
            classification:SetPoint('LEFT', TargetHighLevelTexture:IsShown() and TargetHighLevelTexture or TargetLevelText, 'RIGHT')
            classification:SetText(' — |cffef9552'..c..'|r')
        else
            classification:SetText''
        end
    end

    local true_format = function(v)
        if v > 1E7 then return (math.floor(v/1E6))..'m'
        elseif v > 1E6 then return (math.floor((v/1E6)*10)/10)..'m'
        elseif v > 1E4 then return (math.floor(v/1E3))..'k'
        elseif v > 1E3 then return (math.floor((v/1E3)*10)/10)..'k'
        else return v end
    end

                                                -- STATUS TEXT [to-do: true values]
    function TextStatusBar_UpdateTextString(sb)
        if not sb then sb = this end
        orig.TextStatusBar_UpdateTextString(sb)
    	local string = sb.TextString
    	if string and sb:GetName() ~= 'MainMenuExpBar' then
            local pp = UnitPowerType'player'
    		local v  = math.ceil(sb:GetValue())
    		local min, max = sb:GetMinMaxValues()

    		if max > 0 then
    			sb:Show()
                if UnitIsDead'player' then
                    PlayerFrame.status:SetText'Dead'
                    string:SetText''
                    return
                elseif UnitIsGhost'player' then
                    PlayerFrame.status:SetText'Ghost'
                    string:SetText''
                    return
    			elseif v == 0 and sb.zeroText then
                    PlayerFrame.status:SetText''
                    string:SetText''
                    return
    			else
                    PlayerFrame.status:SetText''
                    if sb:GetName() == 'PlayerFrameManaBar'
                    and (pp == 1 or pp == 2 or pp == 3) then
                        string:SetText(v)
                    else
                        local percent = math.ceil(v/max*100)
                        if GetCVar'modBoth' == '1' then
                            string:SetText(true_format(v)..'/'..true_format(max)..' — '..percent..'%')
                            string:SetPoint('RIGHT', -8, 0)
                        elseif GetCVar'modValue'  == '1' and GetCVar'modBoth' == '0' then
                            string:SetText(true_format(v))
                        else
                            string:SetText(percent..'%')
                        end
                    end
                    string:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
                    if GetCVar'modStatus'  == '1' and GetCVar'modBoth' == '0' then
                        string:ClearAllPoints()
                        string:SetJustifyV'MIDDLE'
                        string:SetPoint('CENTER',
                                    PlayerFrame,
                                    (sb:GetName() == 'PlayerFrameManaBar') and 30 or 80,
                                    -2)
                    end
    			end
            end
    	end
    end

    RegisterCVar('modStatus', 1, true)          -- TOGGLE HORIZONTAL VALUES
    MODSTATUS_BAR_TEXT = 'modui: Side-by-Side Status Text'
    UIOptionsFrameCheckButtons['MODSTATUS_BAR_TEXT'] = { index = 70, cvar = 'modStatus'}
    UIOptionsFrameCheckButton70 = CreateFrame('CheckButton', 'UIOptionsFrameCheckButton70', UIOptionsFrameCheckButton2, 'UIOptionsCheckButtonTemplate')
    UIOptionsFrameCheckButton70:SetHeight(20) UIOptionsFrameCheckButton70:SetWidth(20)
    UIOptionsFrameCheckButton70:SetPoint('LEFT', UIOptionsFrameCheckButton2, 'RIGHT', 100, 0)

    local w = UIOptionsFrameCheckButton70:CreateFontString(nil, 'OVERLAY')
    w:SetFontObject(GameFontNormalSmall)
    w:SetText'Will reload ui!'
    w:SetTextColor(1, .2, 0)
    w:SetPoint('TOPLEFT', UIOptionsFrameCheckButton70, 'BOTTOMRIGHT')

    RegisterCVar('modValue', 1, true)           -- TOGGLE PERCENT VALUES
    MODSTATUS_BAR_VALUE = 'modui: \% or True Value Text on Statusbars'
    UIOptionsFrameCheckButtons['MODSTATUS_BAR_VALUE'] = { index = 71, cvar = 'modValue'}
    UIOptionsFrameCheckButton71 = CreateFrame('CheckButton', 'UIOptionsFrameCheckButton71', UIOptionsFrameCheckButton2, 'UIOptionsCheckButtonTemplate')
    UIOptionsFrameCheckButton71:SetHeight(20) UIOptionsFrameCheckButton71:SetWidth(20)
    UIOptionsFrameCheckButton71:SetPoint('LEFT', UIOptionsFrameCheckButton2, 'RIGHT', 100, -30)

    local x = UIOptionsFrameCheckButton71:CreateFontString(nil, 'OVERLAY')
    x:SetFontObject(GameFontNormalSmall)
    x:SetText'Will reload ui!'
    x:SetTextColor(1, .2, 0)
    x:SetPoint('TOPLEFT', UIOptionsFrameCheckButton71, 'BOTTOMRIGHT')

    RegisterCVar('modBoth', 1, true)            -- CONSOLIDATED VALUE DISPLAY (TRUE + %)
    MODSTATUS_BAR_CONSOLIDATE = 'modui: True & % Values on Statusbars'
    UIOptionsFrameCheckButtons['MODSTATUS_BAR_CONSOLIDATE'] = { index = 72, cvar = 'modBoth'}
    UIOptionsFrameCheckButton72 = CreateFrame('CheckButton', 'UIOptionsFrameCheckButton72', UIOptionsFrameCheckButton2, 'UIOptionsCheckButtonTemplate')
    UIOptionsFrameCheckButton72:SetHeight(20) UIOptionsFrameCheckButton72:SetWidth(20)
    UIOptionsFrameCheckButton72:SetPoint('LEFT', UIOptionsFrameCheckButton2, 'RIGHT', 100, -70)

    local z = UIOptionsFrameCheckButton72:CreateFontString(nil, 'OVERLAY')
    z:SetFontObject(GameFontNormalSmall)
    z:SetText'Will reload ui!'
    z:SetTextColor(1, .2, 0)
    z:SetPoint('TOPLEFT', UIOptionsFrameCheckButton72, 'BOTTOMRIGHT')

    local cv = GetCVar'modStatus' local cv2 = GetCVar'modValue' local cv3 = GetCVar'ModBoth'
    local f = CreateFrame'Frame'
    f:RegisterEvent'CVAR_UPDATE'
    f:SetScript('OnEvent', function()
        if (arg1 == 'MODSTATUS_BAR_TEXT' and arg2 ~= cv)
        or (arg1 == 'MODSTATUS_BAR_VALUE' and arg2 ~= cv2)
        or (arg1 == 'MODSTATUS_BAR_CONSOLIDATE' and arg2 ~= cv3) then
            TextStatusBar_UpdateTextString() ReloadUI()
        end
    end)

    function UIOptionsFrame_UpdateDependencies()
        if not UIOptionsFrameCheckButton72:GetChecked() then
            OptionsFrame_EnableCheckBox(UIOptionsFrameCheckButton70)
            OptionsFrame_EnableCheckBox(UIOptionsFrameCheckButton71)
        else
            OptionsFrame_DisableCheckBox(UIOptionsFrameCheckButton70)
            OptionsFrame_DisableCheckBox(UIOptionsFrameCheckButton71)
        end
        orig.UIOptionsFrame_UpdateDependencies()
    end


    --
