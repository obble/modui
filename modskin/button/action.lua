

    local _G = getfenv(0)

    for i = 1, 12 do                    -- ACTIONBAR
        local bu = _G['ActionButton'..i]
        modSkin(bu, 18)
        modSkinPadding(bu, 2, 2, 2, 2, 2, 2, 2, 2)
        modSkinColor(bu, .2, .2, .2)
        _G['ActionButton'..i..'NormalTexture']:Hide()

        local l = _G['MultiBarBottomLeftButton'..i]
        modSkin(l, 18)
        modSkinPadding(l, 2, 2, 2, 2, 2, 2, 2, 2)
        modSkinColor(l, .15, .15, .15)
        if i == 1 then l:SetFrameStrata'LOW' end
        _G['MultiBarBottomLeftButton'..i..'NormalTexture']:Hide()

        local r = _G['MultiBarBottomRightButton'..i]
        modSkin(r, 18)
        modSkinPadding(r, 2, 2, 2, 2, 2, 2, 2, 2)
        modSkinColor(r, .15, .15, .15)
        if i == 12 then r:SetFrameStrata'LOW' end
        _G['MultiBarBottomRightButton'..i..'NormalTexture']:Hide()
    end
