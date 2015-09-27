

    local AttachToMainbar = true -- reparents tooltip to mainmenubar. true/false

  	local _G = getfenv(0)
  	local sb = [[Interface\AddOns\modui\modsb\texture\sb.tga]]
    local GameTooltip = GameTooltip
    local GameTooltipStatusBar = GameTooltipStatusBar

    GameTooltipStatusBar:SetHeight(4)
    GameTooltipStatusBar:SetStatusBarTexture(sb)
    GameTooltipStatusBar:SetBackdrop({  bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
                                        insets = {left = -1, right = -1, top = -1, bottom = -1} })
    GameTooltipStatusBar:SetBackdropColor(0, 0, 0, 1)

    GameTooltipHeaderText:SetFont(STANDARD_TEXT_FONT, 12)
    GameTooltipHeaderText:SetShadowOffset(.7, -.7)
    GameTooltipHeaderText:SetShadowColor(0, 0, 0, 1)
    GameTooltipText:SetFont(STANDARD_TEXT_FONT, 11)
    GameTooltipText:SetShadowOffset(.7, -.7)
    GameTooltipText:SetShadowColor(0, 0, 0,1)


    local tooltips = {  GameTooltip,
                        ItemRefTooltip,
                        ItemRefShoppingTooltip1,
                     	ItemRefShoppingTooltip2,
	                    ItemRefShoppingTooltip3,
                        ShoppingTooltip1,
                        ShoppingTooltip2,
                        ShoppingTooltip3,
                        WorldMapTooltip,
                        WorldMapCompareTooltip1,
	                    WorldMapCompareTooltip2,
	                    WorldMapCompareTooltip3,
                        FriendsTooltip, }

    local menus =    {  DropDownList1MenuBackdrop,
                        DropDownList2MenuBackdrop,
                        DropDownList3MenuBackdrop,
                        ChatMenu,
                        EmoteMenu,
                        LanguageMenu, }

    local modTipOnShow = function()
        GameTooltip:SetBackdropColor(0, 0, 0, .4)
        GameTooltip:SetBackdropBorderColor(.1, .1, .1, 1)
        if AttachToMainbar then
            GameTooltip:ClearAllPoints()
            GameTooltip:SetPoint('BOTTOMRIGHT', MainMenuBar, -32, CONTAINER_OFFSET_Y)
        end
    end

    GameTooltip:SetScript('OnShow', modTipOnShow)


    for i, v in ipairs(menus) do v:SetScript('OnShow', function()
            this:SetBackdropColor(0, 0, 0, .4)
            this:SetBackdropBorderColor(.1, .1, .1, 1)
        end)
    end


    for i = 1, 6 do                             -- QUEST PROGRESS TOOLTIP
        local p = _G['QuestProgressItem'..i]
    end

    --
