

    local f = { GameTooltip,                -- TIPS
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
                FriendsTooltip,
                DropDownList1MenuBackdrop,  -- DROPDOWN
                DropDownList2MenuBackdrop,
                DropDownList3MenuBackdrop,
                ChatMenu,
                EmoteMenu,
                LanguageMenu,
                TutorialFrame
            }

    for i, v in pairs (f) do
        modSkin(v, 4)
        modSkinColor(v, .8, .8, .8)
    end

    --
