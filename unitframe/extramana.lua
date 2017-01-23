

    if tonumber(GetCVar'modUnitFrame') == 0 then return end

    local _, class = UnitClass'player'
    if class ~= 'DRUID' then return end

    local TEXTURE       = [[Interface\AddOns\modui\statusbar\texture\sb.tga]]
    local BACKDROP      = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],}
    local DruidManaLib  = AceLibrary'DruidManaLib-1.0'

    local f = CreateFrame'Frame'

    PlayerFrame.ExtraManaBar = CreateFrame('StatusBar', 'ExtraManaBar', PlayerFrame)
    PlayerFrame.ExtraManaBar:SetWidth(100)
    PlayerFrame.ExtraManaBar:SetHeight(10)
    PlayerFrame.ExtraManaBar:SetPoint('TOP', PlayerFrame, 'BOTTOM', 50, 35)
    PlayerFrame.ExtraManaBar:SetStatusBarTexture(TEXTURE)
    PlayerFrame.ExtraManaBar:SetStatusBarColor(ManaBarColor[0].r, ManaBarColor[0].g, ManaBarColor[0].b)
    PlayerFrame.ExtraManaBar:SetBackdrop(BACKDROP)
    PlayerFrame.ExtraManaBar:SetBackdropColor(0, 0, 0)

    PlayerFrame.ExtraManaBar.Text = PlayerFrame.ExtraManaBar:CreateFontString('ExtraManaBarText', 'OVERLAY', 'TextStatusBarText')
    PlayerFrame.ExtraManaBar.Text:SetFont(STANDARD_TEXT_FONT, 12, 'OUTLINE')
    PlayerFrame.ExtraManaBar.Text:SetPoint('TOP', PlayerFrame.ExtraManaBar, 'BOTTOM', 0, 9)
    PlayerFrame.ExtraManaBar.Text:SetTextColor(.6, .65, 1)


    PlayerFrame.ExtraManaBar:SetScript('OnMouseUp', function(bu)
        PlayerFrame:Click(bu)
    end)

    modSkin(PlayerFrame.ExtraManaBar, 12)
    modSkinPadding(PlayerFrame.ExtraManaBar, 2, 2, 2, 2, 2, 2, 2, 2)
    modSkinColor(PlayerFrame.ExtraManaBar, .2, .2, .2)

    -- pinched from DruidManaBar
    --      overwrite this function or the mana cost from shapeshifting will be subtracted twice
    function DruidManaLib:Subtract()
    end

    local GetValue = function()
        local v = DruidManaLib:GetMana()
        PlayerFrame.ExtraManaBar:SetValue(v)
        PlayerFrame.ExtraManaBar.Text:SetText(true_format(v))
    end

    local GetMaxValue = function()
    	DruidManaLib:MaxManaScript()
    	local _, max = DruidManaLib:GetMana()
    	PlayerFrame.ExtraManaBar:SetMinMaxValues(0, max)
    end

    local GetPowerType = function()
    	if  f.loaded and UnitPowerType'player' ~= 0 then
    		PlayerFrame.ExtraManaBar:Show()
    	else
    		PlayerFrame.ExtraManaBar:Hide()
    		f.loaded = true
    	end
    end

    local UNIT_MANA = function()
    	if  PlayerFrame.ExtraManaBar:IsShown() and UnitIsUnit('player', arg1) then
    		GetValue()
    	end
    end

    local UNIT_MAXMANA = function()
    	if  PlayerFrame.ExtraManaBar:IsShown() and UnitIsUnit('player', arg1) then
    		GetMaxValue()
    	end
    end

    local UNIT_DISPLAYPOWER = function()
    	GetMaxValue()
    	GetValue()
    	GetPowerType()
    end

    local PLAYER_AURAS_CHANGED = function()
    	if  PlayerFrame.ExtraManaBar:IsShown() then
            UNIT_DISPLAYPOWER()
        end
    end

    f:RegisterEvent'UNIT_MANA'
    f:RegisterEvent'UNIT_MAXMANA'
    f:RegisterEvent'UNIT_DISPLAYPOWER'
    f:RegisterEvent'PLAYER_AURAS_CHANGED'
    f:RegisterEvent'PLAYER_ENTERING_WORLD'

    f:SetScript('OnEvent', function()
        if event == 'UNIT_MANA' then
            UNIT_MANA()
        elseif event == 'UNIT_MAXMANA' then
            UNIT_MAXMANA()
        elseif event == 'UNIT_DISPLAYPOWER' then
            UNIT_DISPLAYPOWER()
        elseif event == 'PLAYER_AURAS_CHANGED' then
            PLAYER_AURAS_CHANGED()
        elseif event == 'PLAYER_ENTERING_WORLD' then
            UNIT_DISPLAYPOWER()
            f:UnregisterEvent'PLAYER_ENTERING_WORLD'
        end
    end)

    --
