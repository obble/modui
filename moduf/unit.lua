

    local _G = getfenv(0)
    local BG = [[Interface\AddOns\modui\modsb\texture\sb.tga]]
    local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]]}
    local _, class = UnitClass'player'
    local colour = RAID_CLASS_COLORS[class]
    local orig = {}

    local hideMana = true -- HIDE OR SHOW MANA/RAGE/ENERGY TEXT PERCENTAGE

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

        -- ToT
    --[[ local tot_Name = function()
        if UnitIsPlayer'targettarget' then
            local _, class = UnitClass'targettarget'
            local colour = RAID_CLASS_COLORS[class]
            TargetFrameToTTextureFrameName:SetTextColor(colour.r, colour.g, colour.b, .95)
        else
            TargetFrameToTTextureFrameName:SetTextColor(1, .8, 0)
        end
    end ]]

    orig.TextStatusBar_UpdateTextString = TextStatusBar_UpdateTextString

    function TextStatusBar_UpdateTextString(textStatusBar)
        if not textStatusBar then textStatusBar = this end
        orig.TextStatusBar_UpdateTextString(textStatusBar)
    	local string = textStatusBar.TextString
    	if string and textStatusBar:GetName() ~= 'MainMenuExpBar' then
    		local value = textStatusBar:GetValue()
    		local min, max = textStatusBar:GetMinMaxValues()
    		if max > 0 then
    			textStatusBar:Show()
    			if value == 0 and textStatusBar.zeroText then
    				string:SetText''
    			else
                    if textStatusBar:GetName() == 'PlayerFrameManaBar' and hideMana then string:Hide() end
                    local percent = math.ceil(value/max*100)
    				string:SetText(percent..'%')
                    string:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
                    string:ClearAllPoints()
                    string:SetPoint((textStatusBar:GetName() == 'PlayerFrameManaBar') and 'BOTTOMLEFT' or 'BOTTOMRIGHT',
                                     textStatusBar,
                                    (textStatusBar:GetName() == 'PlayerFrameManaBar') and 18 or -12,
                                    (textStatusBar:GetName() == 'PlayerFrameManaBar') and 6 or -5)
    			end
            end
    	end
    end

    --
