


  	local _G = getfenv(0)
	local BACKDROP = {bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
					insets = {left = -1, right = -1, top = -1, bottom = -1}}

        -- MINIMAP CLUSTER
	for i,v in pairs({
		MinimapBorder,
		MiniMapMailBorder,
		MiniMapTrackingBorder,
		MiniMapMeetingStoneBorder,
		MiniMapMailBorder,
		MiniMapBattlefieldBorder,
    }) do v:SetVertexColor(.15, .15, .15) end

	for i,v in pairs({
		MinimapZoomIn:GetNormalTexture(), MinimapZoomOut:GetNormalTexture()
	}) do v:SetVertexColor(.25, .25, .25) end

	for i,v in pairs({
		MinimapZoomIn:GetDisabledTexture(), MinimapZoomOut:GetDisabledTexture()
	}) do v:SetVertexColor(.1, .1, .1) end

	MinimapBorderTop:Hide()
	MinimapToggleButton:Hide()

	local b = GameTimeFrame:CreateTexture(nil, 'OVERLAY')
	b:SetPoint('TOPLEFT', GameTimeFrame)
	b:SetPoint('BOTTOMRIGHT', GameTimeFrame, 33, -33)
	b:SetTexture[[Interface\Minimap\MiniMap-TrackingBorder]]
	b:SetVertexColor(.2, .2, .2)


        -- UNIT & CASTBAR
	for i,v in pairs({
		PlayerFrameTexture,
  		TargetFrameTexture,
  		PetFrameTexture,
		PartyMemberFrame1Texture,
		PartyMemberFrame2Texture,
		PartyMemberFrame3Texture,
		PartyMemberFrame4Texture,
		PartyMemberFrame1PetFrameTexture,
		PartyMemberFrame2PetFrameTexture,
		PartyMemberFrame3PetFrameTexture,
		PartyMemberFrame4PetFrameTexture,
   		TargetofTargetTexture,
		CastingBarBorder,
	}) do v:SetVertexColor(.15, .15, .15) end

	for i,v in pairs({
		PlayerPVPIcon,
		TargetFrameTextureFramePVPIcon,
		FocusFrameTextureFramePVPIcon,
	}) do v:SetAlpha(0) end

	for i = 1,4 do
		_G["PartyMemberFrame"..i.."PVPIcon"]:SetAlpha(0)
	end

	PlayerFrameGroupIndicator:SetAlpha(0)
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = function() end
	PetHitIndicator:SetText(nil)
	PetHitIndicator.SetText = function() end


        -- MAIN MENU BAR
	for i,v in pairs({
		SlidingActionBarTexture0,
		SlidingActionBarTexture1,
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
        MainMenuMaxLevelBar0,
        MainMenuMaxLevelBar1,
		MainMenuMaxLevelBar2,
		MainMenuMaxLevelBar3,
		MainMenuXPBarTextureLeftCap,
		MainMenuXPBarTextureRightCap,
		MainMenuXPBarTextureMid,
        BonusActionBarTexture0,
        BonusActionBarTexture1,
		ReputationWatchBarTexture0,
		ReputationWatchBarTexture1,
		ReputationWatchBarTexture2,
		ReputationWatchBarTexture3,
		ReputationXPBarTexture0,
		ReputationXPBarTexture1,
		ReputationXPBarTexture2,
		ReputationXPBarTexture3,
	}) do v:SetVertexColor(.25, .25, .25) end

	for i,v in pairs({
		MainMenuBarLeftEndCap,
		MainMenuBarRightEndCap,
		ExhaustionTick:GetNormalTexture(),
	}) do v:SetVertexColor(.3, .3, .3) v:SetDrawLayer('OVERLAY', 7) end

	for i = 0, 3 do _G['MainMenuXPBarTexture'..i]:SetTexture'' end
	for i = 0, 3 do _G['ReputationWatchBarTexture'..i]:SetTexture'' end
    for i, v in pairs({ ShapeshiftBarLeft,
                        ShapeshiftBarMiddle,
                        ShapeshiftBarRight, }) do v:SetTexture'' end

	MainMenuExpBar:SetHeight(5)
	MainMenuExpBar:ClearAllPoints() MainMenuExpBar:SetPoint('TOP', MainMenuBar, 0, -4)
	MainMenuExpBar:SetBackdrop(BACKDROP)
    MainMenuExpBar:SetBackdropColor(0, 0, 0, 1)

	ReputationWatchBar:SetFrameStrata'LOW'
	ReputationWatchBar:SetHeight(4)
	ReputationWatchStatusBar:SetHeight(4)
	ReputationWatchStatusBar:SetBackdrop(BACKDROP)
	ReputationWatchStatusBar:SetBackdropColor(0, 0, 0, 1)


        -- BAGS
    for i = 0, NUM_BAG_FRAMES do
        local bagName = 'ContainerFrame'..i + 1
        local _, a, b, _, c, _, d = _G[bagName]:GetRegions()
        for i,v in pairs({a,b,c,d}) do v:SetVertexColor(.2, .2, .2) end
    end

    local _, a = BankFrame:GetRegions()
    for i,v in pairs({a}) do v:SetVertexColor(.2, .2, .2) end



	    -- PAPERDOLL
    local a, b, c, d, _, e = PaperDollFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e}) do v:SetVertexColor(.3, .3, .3) end


        -- WORLDMAP
    local _, a, b, c, d, e, _, _, f, g, h, j, k = WorldMapFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e, f, g, h, j, k}) do v:SetVertexColor(.3, .3, .3) end


        -- LOOT
    local _, a = LootFrame:GetRegions()
    a:SetVertexColor(.3, .3, .3)


        -- TAXI
    local _, a, b, c, d = TaxiFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(.3, .3, .3) end


        -- MERCHANT
    local _, a, b, c, d, _, _, _, e, f, g, h, j, k = MerchantFrame:GetRegions()
    for i,v in pairs({a, b, c ,d, e, f, g, h, j, k}) do v:SetVertexColor(.3, .3, .3) end
    MerchantBuyBackItemNameFrame:SetVertexColor(.4, .4, .4)


        -- SKILL
    local a, b, c, d = SkillFrame:GetRegions()
    for i,v in pairs({a, b, c ,d}) do v:SetVertexColor(.3, .3, .3) end


        -- REPUTATION
    local a, b, c, d = ReputationFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(.3, .3, .3) end
    for i = 1, 15 do
        local a, b = _G['ReputationBar'..i]:GetRegions()
        for k,v in pairs({a, b}) do v:SetVertexColor(.4, .4, .4) end
    end


        -- HONOR
    local a, b, c, d = HonorFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(.3, .3, .3) end


        -- SPELLBOOK
    local _, a, b, c, d = SpellBookFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(.3, .3, .3) end
    SpellBookFrame.Material = SpellBookFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    SpellBookFrame.Material:SetTexture[[Interface\AddOns\modui\moddark\quest\QuestBG.tga]]
    SpellBookFrame.Material:SetWidth(525)
    SpellBookFrame.Material:SetHeight(535)
    SpellBookFrame.Material:SetPoint('TOPLEFT', SpellBookFrame, 28, -74)
    SpellBookFrame.Material:SetVertexColor(.7, .7, .7)


        -- LOG
    local _, _, a, b, c, d = QuestLogFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(.3, .3, .3) end
    QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    QuestLogFrame.Material:SetTexture[[Interface\AddOns\modui\moddark\quest\QuestBG.tga]]
    QuestLogFrame.Material:SetWidth(510)
    QuestLogFrame.Material:SetHeight(398)
    QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame)
    QuestLogFrame.Material:SetVertexColor(.7, .7, .7)


        -- SOCIAL
    local _, a, b, c, d = FriendsFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(.3, .3, .3) end

        -- HONOR
    GameMenuFrame:SetBackdropBorderColor(.3, .3, .3)
    GameMenuFrameHeader:SetVertexColor(.3, .3, .3)

        -- HELP
    local a, b, c, d, e, f, g = HelpFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e, f, g}) do v:SetVertexColor(.3, .3, .3) end

        -- QUEST
    for i,v in pairs({
        QuestFrameGreetingPanel,
        QuestFrameDetailPanel,
        QuestFrameProgressPanel,
        QuestFrameRewardPanel,
        GossipFrameGreetingPanel}) do
        local a, b, c, d = v:GetRegions()
        for k,j in pairs({a, b, c, d}) do j:SetVertexColor(.35, .35, .35) end

        v.Material = v:CreateTexture(nil, 'OVERLAY', nil, 7)
        v.Material:SetTexture[[Interface\AddOns\modui\moddark\quest\QuestBG.tga]]
        v.Material:SetWidth(506)
        v.Material:SetHeight(506)
        v.Material:SetPoint('TOPLEFT', v, 24, -82)
        v.Material:SetVertexColor(.7, .7, .7)

        if v == GossipFrameGreetingPanel or v == QuestFrameGreetingPanel then
            v.Corner = v:CreateTexture(nil, 'OVERLAY', nil, 7)
            v.Corner:SetTexture[[Interface\QuestFrame\UI-Quest-BotLeftPatch]]
            v.Corner:SetWidth(132)
            v.Corner:SetHeight(64)
            v.Corner:SetPoint('BOTTOMLEFT', v, 21, 68)
            v.Corner:SetVertexColor(.35, .35, .35)
        end
    end


        -- MIRRORBAR
    for i = 1, MIRRORTIMER_NUMTIMERS do
		local m = _G['MirrorTimer'..i]
		local _, _, a = m:GetRegions()
		a:SetVertexColor(.15, .15, .15)
	end


    --
