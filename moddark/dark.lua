

    local BACKDROP = {  bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
                        insets = {left = -1, right = -1, top = -1, bottom = -1}}


        -- COLOUR APPLIED TO TEXTURES (RGB value)
    local colour = {r = .2, g = .2, b = .2}


        -- MINIMAP CLUSTER
    for i, v in pairs({
        MinimapBorder,
        MiniMapMailBorder,
        MiniMapTrackingBorder,
        MiniMapMeetingStoneBorder,
        MiniMapMailBorder,
        MiniMapBattlefieldBorder,
    }) do v:SetVertexColor(colour.r, colour.g, colour.b) end

    MinimapBorderTop:Hide()
    MinimapToggleButton:Hide()

    local b = GameTimeFrame:CreateTexture(nil, 'OVERLAY')
    b:SetPoint('TOPLEFT', GameTimeFrame)
    b:SetPoint('BOTTOMRIGHT', GameTimeFrame, 33, -33)
    b:SetTexture[[Interface\Minimap\MiniMap-TrackingBorder]]
    b:SetVertexColor(colour.r, colour.g, colour.b)


        -- UNIT & CASTBAR
    for i, v in pairs({
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
    }) do v:SetVertexColor(colour.r*.9, colour.g*.9, colour.b*.9) end

    for i, v in pairs({
        PlayerPVPIcon,
        TargetFrameTextureFramePVPIcon,
        FocusFrameTextureFramePVPIcon,
    }) do v:SetAlpha(0) end

    for i = 1, 4 do _G['PartyMemberFrame'..i..'PVPIcon']:SetAlpha(0) end

    PlayerFrameGroupIndicator:SetAlpha(0)
    PlayerHitIndicator:SetText(nil)
    PlayerHitIndicator.SetText = function() end
    PetHitIndicator:SetText(nil)
    PetHitIndicator.SetText = function() end


        -- MAIN MENU BAR
    for i, v in pairs({
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
    }) do v:SetVertexColor(colour.r*1.1, colour.g*1.1, colour.b*1.1) end

    for i,v in pairs({
        MainMenuBarLeftEndCap,
        MainMenuBarRightEndCap,
        ExhaustionTick:GetNormalTexture(),
    }) do v:SetVertexColor(colour.r*1.2, colour.g*1.2, colour.b*1.2) v:SetDrawLayer('OVERLAY', 7) end

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
    for i = 1, 12 do
        local bagName = 'ContainerFrame'..i
        local _, a, b, _, c, _, d = _G[bagName]:GetRegions()
        for i,v in pairs({a,b,c,d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
        if i > 5 then   -- BANK BAGS
            for i,v in pairs({a,b,c,d}) do v:SetVertexColor(colour.r*1.3, colour.g*1.3, colour.b*1.3) end
        end
    end

    local _, a = BankFrame:GetRegions()
    for i,v in pairs({a}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


	    -- PAPERDOLL
    local a, b, c, d, _, e = PaperDollFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e}) do v:SetVertexColor(colour.r*1.1, colour.g*1.1, colour.b*1.1) end


        -- WORLDMAP
    local _, a, b, c, d, e, _, _, f, g, h, j, k = WorldMapFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e, f, g, h, j, k}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


        -- LOOT
    local _, a = LootFrame:GetRegions()
    a:SetVertexColor(colour.r, colour.g, colour.b)


        -- TAXI
    local _, a, b, c, d = TaxiFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


        -- MERCHANT
    local _, a, b, c, d, _, _, _, e, f, g, h, j, k = MerchantFrame:GetRegions()
    for i,v in pairs({a, b, c ,d, e, f, g, h, j, k}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    MerchantBuyBackItemNameFrame:SetVertexColor(colour.r*1.3, colour.g*1.3, colour.b*1.3)


        -- SKILL
    local a, b, c, d = SkillFrame:GetRegions()
    for i,v in pairs({a, b, c ,d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    for i,v in pairs({ ReputationDetailCorner,
                       ReputationDetailDivider }) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    ReputationDetailFrame:SetBackdropBorderColor(colour.r, colour.g, colour.b)


        -- REPUTATION
    local a, b, c, d = ReputationFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    for i = 1, 15 do
        local a, b = _G['ReputationBar'..i]:GetRegions()
        for k,v in pairs({a, b}) do v:SetVertexColor(colour.r*1.2, colour.g*1.2, colour.b*1.2) end
    end


        -- HONOR
    local a, b, c, d = HonorFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


        -- SPELLBOOK
    local _, a, b, c, d = SpellBookFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    SpellBookFrame.Material = SpellBookFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    SpellBookFrame.Material:SetTexture[[Interface\AddOns\modui\moddark\quest\QuestBG.tga]]
    SpellBookFrame.Material:SetWidth(525)
    SpellBookFrame.Material:SetHeight(535)
    SpellBookFrame.Material:SetPoint('TOPLEFT', SpellBookFrame, 28, -74)
    SpellBookFrame.Material:SetVertexColor(.7, .7, .7)


        -- LOG
    local _, _, a, b, c, d = QuestLogFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    QuestLogFrame.Material:SetTexture[[Interface\AddOns\modui\moddark\quest\QuestBG.tga]]
    QuestLogFrame.Material:SetWidth(510)
    QuestLogFrame.Material:SetHeight(398)
    QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame)
    QuestLogFrame.Material:SetVertexColor(.7, .7, .7)


        -- SOCIAL
    local _, a, b, c, d = FriendsFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    local a = ({GuildMemberDetailFrame:GetRegions()})
    a[20]:SetVertexColor(colour.r, colour.g, colour.b)
    GuildMemberDetailFrame:SetBackdropBorderColor(colour.r, colour.g, colour.b)
    GuildMemberDetailCorner:SetVertexColor(colour.r, colour.g, colour.b)

        -- MAIL
    local _, a, b, c, d = OpenMailFrame:GetRegions()
    for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


        -- TRADE
    local _, _, a, b, c, d = TradeFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


        -- TABARD
    local _, a, b, c, d = TabardFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


        -- BOOK
    local _, a, b, c, d = ItemTextFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
    ItemTextFrame.Material = ItemTextFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    ItemTextFrame.Material:SetTexture[[Interface\AddOns\modui\moddark\quest\QuestBG.tga]]
    ItemTextFrame.Material:SetWidth(510)
    ItemTextFrame.Material:SetHeight(525)
    ItemTextFrame.Material:SetPoint('TOPLEFT', ItemTextFrame, 26, -80)
    ItemTextFrame.Material:SetVertexColor(.7, .7, .7)


        -- MENU
    GameMenuFrame:SetBackdropBorderColor(colour.r, colour.g, colour.b)
    GameMenuFrameHeader:SetVertexColor(colour.r, colour.g, colour.b)


        -- HELP
    local a, b, c, d, e, f, g = HelpFrame:GetRegions()
    for i,v in pairs({a, b, c, d, e, f, g}) do v:SetVertexColor(colour.r, colour.g, colour.b) end


        -- QUEST
    for i,v in pairs({
        QuestFrameGreetingPanel,
        QuestFrameDetailPanel,
        QuestFrameProgressPanel,
        QuestFrameRewardPanel,
        GossipFrameGreetingPanel}) do
        local a, b, c, d = v:GetRegions()
        for k,j in pairs({a, b, c, d}) do j:SetVertexColor(colour.r, colour.g, colour.b) end

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
            v.Corner:SetVertexColor(colour.r, colour.g, colour.b)
        end
    end


        -- GROUPLOOT
    for i = 1, NUM_GROUP_LOOT_FRAMES do
        local f = _G['GroupLootFrame'..i]
        f:SetBackdropBorderColor(.2, .2, .2)
    end


        -- POPUP
    for i = 1, 4 do
    	local f = _G['StaticPopup'..i]
        f:SetBackdropBorderColor(colour.r, colour.g, colour.b)
    end


        -- MIRRORBAR
    for i = 1, MIRRORTIMER_NUMTIMERS do
        local m = _G['MirrorTimer'..i]
        local _, _, a = m:GetRegions()
        a:SetVertexColor(colour.r*.9, colour.g*.9, colour.b*.9)
    end


        -- ADDONS
    local f = CreateFrame'Frame'
    f:RegisterEvent'ADDON_LOADED'
    f:SetScript('OnEvent', function()
        if     arg1 == 'Blizzard_AuctionUI'    then -- AUCTION
            local _, a, b, c, d, e, f = AuctionFrame:GetRegions()
            for i,v in pairs({a,b,c,d,e,f}) do v:SetVertexColor(colour.r*1.4, colour.g*1.4, colour.b*1.4) end
            for i = 1, 15 do
                local a = _G['AuctionFilterButton'..i]:GetNormalTexture()
                a:SetVertexColor(.4, .4, .4)
            end
        elseif arg1 == 'Blizzard_CraftUI'      then -- CRAFT
            local _, a, b, c, d = CraftFrame:GetRegions()
            for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
        elseif arg1 == 'Blizzard_InspectUI'    then -- INSPECT
            local a, b, c, d = InspectPaperDollFrame:GetRegions()
            for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
        elseif arg1 == 'Blizzard_MacroUI'      then -- MACRO
            local _, a, b, c, d = MacroFrame:GetRegions()
            for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
        elseif arg1 == 'Blizzard_TalentUI'     then -- TALENTS
            local _, a, b, c, d = TalentFrame:GetRegions()
            for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
        elseif arg1 == 'Blizzard_TradeSkillUI' then -- TRADESKILL
            local _, a, b, c, d = TradeSkillFrame:GetRegions()
            for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
        elseif arg1 == 'Blizzard_TrainerUI'    then -- TRAINER
            local _, a, b, c, d = ClassTrainerFrame:GetRegions()
            for i,v in pairs({a, b, c, d}) do v:SetVertexColor(colour.r, colour.g, colour.b) end
        end
    end)

    --
