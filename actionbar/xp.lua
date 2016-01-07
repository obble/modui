
    local BACKDROP = {  bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
                        insets = {left = -1, right = -1, top = -1, bottom = -1} }
    local _, class = UnitClass'Player'
    local colour = RAID_CLASS_COLORS[class]
    local orig = {}

    orig.ReputationWatchBar_Update = ReputationWatchBar_Update

    MainMenuExpBar:SetWidth(1021) MainMenuExpBar:SetHeight(5)
    MainMenuExpBar:ClearAllPoints() MainMenuExpBar:SetPoint('TOP', MainMenuBar, 0, -4)
    MainMenuExpBar:SetBackdrop(BACKDROP)
    MainMenuExpBar:SetBackdropColor(0, 0, 0, 1)

    MainMenuExpBar.spark = MainMenuExpBar:CreateTexture(nil, 'OVERLAY', nil, 7)
    MainMenuExpBar.spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
    MainMenuExpBar.spark:SetWidth(35) MainMenuExpBar.spark:SetHeight(35)
    MainMenuExpBar.spark:SetBlendMode'ADD'

    ReputationWatchStatusBar:SetWidth(1021)
    ReputationWatchStatusBar:SetBackdrop(BACKDROP)
    ReputationWatchStatusBar:SetBackdropColor(0, 0, 0, 1)

    ReputationWatchStatusBar.spark = ReputationWatchStatusBar:CreateTexture(nil, 'OVERLAY', nil, 7)
    ReputationWatchStatusBar.spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
    ReputationWatchStatusBar.spark:SetWidth(35) ReputationWatchStatusBar.spark:SetHeight(35)
    ReputationWatchStatusBar.spark:SetBlendMode'ADD'
    ReputationWatchStatusBar.spark:SetVertexColor(colour.r*1.3, colour.g*1.3, colour.b*1.3, .6)

    function ReputationWatchBar_Update(newLevel)
        if not newLevel then newLevel = UnitLevel'player' end
        orig.ReputationWatchBar_Update(newLevel)
        local _, _, min, max, v = GetWatchedFactionInfo()
        local x

        if v > 0 then x = ((v - min)/(max - min))*ReputationWatchStatusBar:GetWidth() end

        ReputationWatchBar:SetFrameStrata'LOW'
        ReputationWatchBar:SetHeight(newLevel < MAX_PLAYER_LEVEL and 4 or 5)

        if newLevel == MAX_PLAYER_LEVEL then
            ReputationWatchBar:ClearAllPoints()
            ReputationWatchBar:SetPoint('TOP', MainMenuBar, 0, -4)
            ReputationWatchStatusBarText:SetPoint('CENTER', ReputationWatchBarOverlayFrame, 0, 3)
            MainMenuExpBar.spark:Hide()
        else
            MainMenuExpBar.spark:Show()
        end

        ReputationWatchStatusBar:SetHeight(newLevel < MAX_PLAYER_LEVEL and 4 or 5)
        ReputationWatchStatusBar:SetStatusBarColor(colour.r, colour.g, colour.b, 1)

        ReputationWatchStatusBar.spark:SetPoint('CENTER', ReputationWatchStatusBar, 'LEFT', x, -1)
    end

    local f = CreateFrame'Frame'
    f:RegisterEvent'CVAR_UPDATE'
    f:RegisterEvent'PLAYER_ENTERING_WORLD' f:RegisterEvent'PLAYER_XP_UPDATE'
    f:RegisterEvent'UPDATE_EXHAUSTION'     f:RegisterEvent'PLAYER_LEVEL_UP'
    f:SetScript('OnEvent', function()
        local xp, max = UnitXP'player', UnitXPMax'player'
		local x = (xp/max)*MainMenuExpBar:GetWidth()
		MainMenuExpBar.spark:SetPoint('CENTER', MainMenuExpBar, 'LEFT', x, -1)
        if event == 'PLAYER_ENTERING_WORLD' or event == 'UPDATE_EXHAUSTION' then
		    local rest = GetRestState()
		    if rest == 1 then
                MainMenuExpBar.spark:SetVertexColor(0*1.5, .39*1.5, .88*1.5, 1)
		    elseif rest == 2 then
			    MainMenuExpBar.spark:SetVertexColor(.58*1.5, 0*1.5, .55*1.5, 1)
	        end
	    end
    end)

    --
