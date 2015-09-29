

    local _G = getfenv(0)
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

    t = CreateFrame'Frame'
    t:RegisterEvent'PLAYER_TARGET_CHANGED' t:RegisterEvent'UNIT_FACTION' t:RegisterEvent'PARTY_MEMBERS_CHANGED'
    t:SetScript('OnEvent', function()
        local _, class = UnitClass'target'
        local colour = RAID_CLASS_COLORS[class]
        if UnitIsPlayer'target' then TargetFrameNameBackground:SetVertexColor(colour.r, colour.g, colour.b, 1) end
    end)

    orig.TextStatusBar_UpdateTextString = TextStatusBar_UpdateTextString

    function TextStatusBar_UpdateTextString(textStatusBar)
        if not textStatusBar then textStatusBar = this end
        orig.TextStatusBar_UpdateTextString(textStatusBar)
    	local string = textStatusBar.TextString
    	if string and textStatusBar:GetName() ~= 'MainMenuExpBar' then
    		local value = math.ceil(textStatusBar:GetValue())
    		local min, max = textStatusBar:GetMinMaxValues()
            local pp     = UnitPowerType'player'

    		if max > 0 then
    			textStatusBar:Show()
    			if value == 0 and textStatusBar.zeroText then
    				string:SetText''
    			else
                    if textStatusBar:GetName() == 'PlayerFrameManaBar' and
                        (pp == 1 or pp == 2 or pp == 3) then
                        string:SetText(value)
                    else
                        local percent = math.ceil(value/max*100)
                        string:SetText(percent..'%')
                    end
                    string:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
                    if GetCVar'modStatus'  == '1' then
                        string:ClearAllPoints()
                        string:SetPoint((textStatusBar:GetName() == 'PlayerFrameManaBar') and 'BOTTOMLEFT' or 'BOTTOMRIGHT',
                                    'PlayerFrameManaBar',
                                    (textStatusBar:GetName() == 'PlayerFrameManaBar') and 28 or -12,
                                    8)
                    end
    			end
            end
    	end
    end

    RegisterCVar('modStatus', 1, true)
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

    local cv = GetCVar'modStatus'
    local f = CreateFrame'Frame'
    f:RegisterEvent'CVAR_UPDATE'
    f:SetScript('OnEvent', function()
        if arg1 == 'MODSTATUS_BAR_TEXT' and arg2 ~= cv then
            TextStatusBar_UpdateTextString() ReloadUI()
        end
    end)


    --
