

    for i = 1, 12 do                            -- ITEMS
        local bu   = _G['MerchantItem'..i..'ItemButton']
        local slot = _G['MerchantItem'..i..'SlotTexture']
        if bu then
            modSkin(bu, 1)
            modSkinColor(bu, .7, .7, .7)
            slot:Hide()
        end
    end

    local r  = _G['MerchantRepairItemButton']   -- REPAIR
    if r then
        modSkin(r, 1)
        modSkinColor(r, .7, .7, .7)
    end

    local a  = _G['MerchantRepairAllButton']
    if a then
        modSkin(a, 1)
        modSkinColor(a, .7, .7, .7)
    end

    --
