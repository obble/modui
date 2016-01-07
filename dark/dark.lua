

    local orig = {}
    local colour = {r = .2, g = .2, b = .2} -- COLOUR APPLIED TO TEXTURES (RGB value)

    orig.TargetFrame_CheckClassification   = TargetFrame_CheckClassification

    for _, v in pairs(MODUI_COLOURELEMENTS_FOR_UI) do
         table.remove(MODUI_COLOURELEMENTS_FOR_UI, v)
    end
    for _, v in pairs(MODUI_COLOURELEMENTS_BORDER_FOR_UI) do
         table.remove(MODUI_COLOURELEMENTS_BORDER_FOR_UI, v)
    end

        -- MINIMAP CLUSTER
    for i, v in pairs({
        MinimapBorder,
        MiniMapMailBorder,
        MiniMapTrackingBorder,
        MiniMapMeetingStoneBorder,
        MiniMapMailBorder,
        MiniMapBattlefieldBorder,
    }) do table.insert(MODUI_COLOURELEMENTS_FOR_UI, v) end

    MinimapBorderTop:Hide()
    MinimapToggleButton:Hide()

    local b = GameTimeFrame:CreateTexture(nil, 'OVERLAY')
    b:SetPoint('TOPLEFT', GameTimeFrame)
    b:SetPoint('BOTTOMRIGHT', GameTimeFrame, 33, -33)
    b:SetTexture[[Interface\Minimap\MiniMap-TrackingBorder]]
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, b)


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
    }) do table.insert(MODUI_COLOURELEMENTS_FOR_UI, v) end

    for i, v in pairs({
        PlayerPVPIcon,
        TargetFrameTextureFramePVPIcon,
        PetActionBarFrameSlidingActionBarTexture0,
        PetActionBarFrameSlidingActionBarTexture1,
    }) do v:SetAlpha(0) end

    for i = 1, 4 do _G['PartyMemberFrame'..i..'PVPIcon']:SetAlpha(0) end


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
    }) do table.insert(MODUI_COLOURELEMENTS_FOR_UI, v) end

    for i,v in pairs({
        MainMenuBarLeftEndCap,
        MainMenuBarRightEndCap,
        ExhaustionTick:GetNormalTexture(),
    }) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
        v:SetDrawLayer('OVERLAY', 7)
    end

    for i = 0, 3 do _G['MainMenuXPBarTexture'..i]:SetTexture'' end
    for i = 0, 3 do _G['ReputationWatchBarTexture'..i]:SetTexture'' end
    for i = 0, 3 do _G['ReputationXPBarTexture'..i]:SetTexture'' end
    for i, v in pairs({ ShapeshiftBarLeft,
                        ShapeshiftBarMiddle,
                        ShapeshiftBarRight, }) do v:SetTexture'' end


        -- BAGS
    for i = 1, 12 do
        local bagName = 'ContainerFrame'..i
        local _, a, b, _, c, _, d = _G[bagName]:GetRegions()
        for _, v in pairs({a, b, c, d}) do table.insert(MODUI_COLOURELEMENTS_FOR_UI, v) end
        if i  > 5 then   -- BANK BAGS
            for _, v in pairs({a, b, c, d}) do table.insert(MODUI_COLOURELEMENTS_FOR_UI, v) end
        end
    end

    local _, a = BankFrame:GetRegions()
    for _, v in pairs({a}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


	    -- PAPERDOLL
    local a, b, c, d, _, e = PaperDollFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- WORLDMAP
    local _, a, b, c, d, e, _, _, f, g, h, j, k = WorldMapFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e, f, g, h, j, k}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- LOOT
    local _, a = LootFrame:GetRegions()
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, a)


        -- TAXI
    local _, a, b, c, d = TaxiFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- MERCHANT
    local _, a, b, c, d, _, _, _, e, f, g, h, j, k = MerchantFrame:GetRegions()
    for _, v in pairs({a, b, c ,d, e, f, g, h, j, k}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

    table.insert(MODUI_COLOURELEMENTS_FOR_UI, MerchantBuyBackItemNameFrame)

        -- MAIL
    local _, a, b, c, d = MailFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

    MailFrame.Material = MailFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    MailFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    MailFrame.Material:SetWidth(530) MailFrame.Material:SetHeight(540)
    MailFrame.Material:SetPoint('TOPLEFT', MailFrame, 23, -74)
    MailFrame.Material:SetVertexColor(.7, .7, .7)
    SendMailPackageButton:SetScript('OnShow', function()
        if MailFrame.Material:IsShown() then MailFrame.Material:Hide() end
    end)
    SendMailPackageButton:SetScript('OnHide', function()
        if MailFrame:IsShown() then MailFrame.Material:Show() end
    end)


        -- SKILL
    local a, b, c, d = SkillFrame:GetRegions()
    for _, v in pairs({a, b, c ,d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end
    for _, v in pairs({ ReputationDetailCorner, ReputationDetailDivider }) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

    table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, ReputationDetailFrame)


        -- REPUTATION
    local a, b, c, d = ReputationFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end
    for i = 1, 15 do
        local a, b = _G['ReputationBar'..i]:GetRegions()
        for _, v in pairs({a, b}) do
            table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
        end
    end


        -- HONOR
    local a, b, c, d = HonorFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- SCOREBOARD
    local a, b, c, d, e, f, _, _, _, _, _, _, g = WorldStateScoreFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e, f, g, h, j, k}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- SPELLBOOK
    local _, a, b, c, d = SpellBookFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

    SpellBookFrame.Material = SpellBookFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    SpellBookFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    SpellBookFrame.Material:SetWidth(525)
    SpellBookFrame.Material:SetHeight(535)
    SpellBookFrame.Material:SetPoint('TOPLEFT', SpellBookFrame, 28, -74)
    SpellBookFrame.Material:SetVertexColor(.7, .7, .7)


        -- LOG
    local _, _, a, b, c, d = QuestLogFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

    QuestLogFrame.Material = QuestLogFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    QuestLogFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    QuestLogFrame.Material:SetWidth(510)
    QuestLogFrame.Material:SetHeight(398)
    QuestLogFrame.Material:SetPoint('TOPLEFT', QuestLogDetailScrollFrame)
    QuestLogFrame.Material:SetVertexColor(.7, .7, .7)

        -- QUEST TIMER
    table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, QuestTimerFrame)
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, QuestTimerHeader)


        -- SOCIAL
    local _, a, b, c, d = FriendsFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

    local a = ({GuildMemberDetailFrame:GetRegions()})
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, a[20])

    table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, GuildMemberDetailFrame)
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, GuildMemberDetailCorner)

        -- MAIL
    local _, a, b, c, d = OpenMailFrame:GetRegions()
    for _, v in pairs({a, b, c, d}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- TRADE
    local _, _, a, b, c, d = TradeFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- TABARD
    local _, a, b, c, d = TabardFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

        -- WARDROBE
    local _, a, b, c, d = DressUpFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- BOOK
    local _, a, b, c, d = ItemTextFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end

    ItemTextFrame.Material = ItemTextFrame:CreateTexture(nil, 'OVERLAY', nil, 7)
    ItemTextFrame.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
    ItemTextFrame.Material:SetWidth(510)
    ItemTextFrame.Material:SetHeight(525)
    ItemTextFrame.Material:SetPoint('TOPLEFT', ItemTextFrame, 26, -80)
    ItemTextFrame.Material:SetVertexColor(.7, .7, .7)


        -- COLOURPICKER
    table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, ColorPickerFrame)
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, ColorPickerFrameHeader)


        -- MENU
    table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, GameMenuFrame)
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, GameMenuFrameHeader)

        -- SOUND MENU
    table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, SoundOptionsFrame)
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, SoundOptionsFrameHeader)

        -- GRAPHICS MENU
    table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, OptionsFrame)
    table.insert(MODUI_COLOURELEMENTS_FOR_UI, OptionsFrameHeader)


        -- HELP
    local a, b, c, d, e, f, g = HelpFrame:GetRegions()
    for _, v in pairs({a, b, c, d, e, f, g}) do
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
    end


        -- QUEST
    for _, v in pairs({
        QuestFrameGreetingPanel,
        QuestFrameDetailPanel,
        QuestFrameProgressPanel,
        QuestFrameRewardPanel,
        GossipFrameGreetingPanel}) do
        local a, b, c, d = v:GetRegions()
        for _, j in pairs({a, b, c, d}) do table.insert(MODUI_COLOURELEMENTS_FOR_UI, j) end

        v.Material = v:CreateTexture(nil, 'OVERLAY', nil, 7)
        v.Material:SetTexture[[Interface\AddOns\modui\dark\quest\QuestBG.tga]]
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
            table.insert(MODUI_COLOURELEMENTS_FOR_UI, v.Corner)
        end
    end


        -- POPUP
    for i = 1, 4 do
    	local f = _G['StaticPopup'..i]
        table.insert(MODUI_COLOURELEMENTS_BORDER_FOR_UI, f)
    end


        -- MIRRORBAR
    for i = 1, MIRRORTIMER_NUMTIMERS do
        local m = _G['MirrorTimer'..i]
        local _, _, a = m:GetRegions()
        table.insert(MODUI_COLOURELEMENTS_FOR_UI, a)
    end

        -- ADDONS
    local f = CreateFrame'Frame'
    f:RegisterEvent'ADDON_LOADED'
    f:SetScript('OnEvent', function()
        if IsAddOnLoaded'Postal' then
            PostalButton1:SetScript('OnShow', function()    -- POSTAL
                if MailFrame.Material:IsShown() then MailFrame.Material:Hide() end
            end)
            PostalButton1:SetScript('OnHide', function()
                if MailFrame:IsShown() then MailFrame.Material:Show() end
            end)
        end
        if arg1 == 'Blizzard_AuctionUI' then        -- AUCTION
            local _, a, b, c, d, e, f = AuctionFrame:GetRegions()
            for _, v in pairs({a, b, c, d, e, f}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
            local a, b = AuctionDressUpFrame:GetRegions()
            local _, _, _, c = AuctionDressUpFrameCloseButton:GetRegions()
            for _, v in pairs({a, b, c}) do table.insert(MODUI_COLOURELEMENTS_FOR_UI, v) end
            for i = 1, 15 do
                local a = _G['AuctionFilterButton'..i]:GetNormalTexture()
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, a)
            end
        elseif arg1 == 'Blizzard_CraftUI'      then -- CRAFT
            local _, a, b, c, d = CraftFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_InspectUI'    then -- INSPECT
            local a, b, c, d = InspectPaperDollFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
            local a, b, c, d = InspectHonorFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_MacroUI'      then -- MACRO
            local _, a, b, c, d = MacroFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
            local a, b, c, d = MacroPopupFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_TalentUI'     then -- TALENTS
            local _, a, b, c, d = TalentFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_TradeSkillUI' then -- TRADESKILL
            local _, a, b, c, d = TradeSkillFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
        elseif arg1 == 'Blizzard_TrainerUI'    then -- TRAINER
            local _, a, b, c, d = ClassTrainerFrame:GetRegions()
            for _, v in pairs({a, b, c, d}) do
                table.insert(MODUI_COLOURELEMENTS_FOR_UI, v)
            end
        end
    end)

    --
