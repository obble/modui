

    for i = 1, 4 do                     -- LOOT
        local bu = _G['LootButton'..i]
        modSkin(bu, 1)
        modSkinColor(bu, .7, .7, .7)
    end

    for i = 1, 4 do
        local bu = _G['GroupLootFrame'..i..'IconFrame']
        local slot = _G['GroupLootFrame'..i..'SlotTexture']

        bu.f = CreateFrame('Frame', nil, bu)
        bu.f:SetFrameLevel(bu:GetFrameLevel() + 1)
        bu.f:SetPoint('TOPLEFT', bu)
        bu.f:SetPoint('BOTTOMRIGHT', bu)
        bu.f:EnableMouse(false)
        modSkin(bu.f, 1)
        modSkinColor(bu.f, .7, .7, .7)
        
        slot:SetAlpha(0)
    end

    --
