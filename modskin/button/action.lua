

    local _G = getfenv(0)

    for i = 1, 12 do
        for k, v in pairs({
            _G['ActionButton'..i],
            _G['MultiBarRightButton'..i],
            _G['MultiBarLeftButton'..i],
            _G['MultiBarBottomLeftButton'..i],
            _G['MultiBarBottomRightButton'..i],
            _G['BonusActionButton'..i],}) do
            modSkin(v, 18)
            modSkinPadding(v, 2)
            modSkinColor(v, .2, .2, .2)
        end

        for k, v in pairs({
            _G['MultiBarBottomLeftButton1'],
            _G['MultiBarBottomRightButton12'] }) do
            v:SetFrameStrata'LOW'
        end

        for k, v in pairs({
            _G['ActionButton'..i..'NormalTexture'],
            _G['MultiBarLeftButton'..i..'NormalTexture'],
            _G['MultiBarRightButton'..i..'NormalTexture'],
            _G['MultiBarBottomLeftButton'..i..'NormalTexture'],
            _G['MultiBarBottomRightButton'..i..'NormalTexture'],
            _G['BonusActionButton'..i..'NormalTexture'],}) do
            v:Hide()
        end
    end

    for i = 1, 10 do
        local bu = _G['ShapeshiftButton'..i]
        modSkin(bu, 18)
        modSkinPadding(bu, 2)
        modSkinColor(bu, .2, .2, .2)
        bu:GetNormalTexture():SetTexture''
    end
