

    for i = 1, 12 do                            -- ITEMS
        local bu   = _G['MerchantItem'..i..'ItemButton']
        local slot = _G['MerchantItem'..i..'SlotTexture']
        if bu then
            modSkin(bu, 16)
            modSkinPadding(bu, 2)
            modSkinColor(bu, .2, .2, .2)
            slot:Hide()
        end
    end

    local r  = _G['MerchantRepairItemButton']   -- REPAIR
    local ri = MerchantRepairItemButton:GetRegions()
    if r then
        modSkin(r, 16)
        modSkinPadding(r, 1)
        modSkinColor(r, .2, .2, .2)
        ri:ClearAllPoints()
        ri:SetPoint('TOPLEFT', r, 1, -1)
        ri:SetPoint('BOTTOMRIGHT', r, -1, 1)
    end

    local a  = _G['MerchantRepairAllButton']
    local ai = _G['MerchantRepairAllIcon']
    if a then
        modSkin(a, 16)
        modSkinPadding(a, 1)
        modSkinColor(a, .2, .2, .2)
        ai:ClearAllPoints()
        ai:SetPoint('TOPLEFT', a, 1, -1)
        ai:SetPoint('BOTTOMRIGHT', a, -1, 1)
    end

    --
