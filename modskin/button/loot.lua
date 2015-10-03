

    local _G = getfenv(0)

    for i = 1, 4 do                     -- LOOT
        local bu = _G['LootButton'..i]
        modSkin(bu, 18)
        modSkinPadding(bu, 2)
        modSkinColor(bu, .2, .2, .2)
    end
