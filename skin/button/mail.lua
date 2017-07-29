

    local slot = SendMailPackageButton:GetRegions()
    slot:ClearAllPoints()
    slot:SetPoint('TOPLEFT', SendMailPackageButton)
    slot:SetPoint('BOTTOMRIGHT', SendMailPackageButton)

    modSkin(SendMailPackageButton, 1)
    modSkinColor(SendMailPackageButton, .7, .7, .7)

    modSkin(OpenMailMoneyButton, 1)
    modSkinColor(OpenMailMoneyButton, .7, .7, .7)

    modSkin(OpenMailPackageButton, 1)
    modSkinColor(OpenMailPackageButton, .7, .7, .7)

    for i = 1, 7 do
        local bu = _G['MailItem'..i]
        local tx = _G['MailItem'..i..'ButtonIcon']
        local ic = bu:GetRegions()
        if  bu then
            local f = CreateFrame('Frame', nil, bu)
            f:SetPoint('TOPLEFT', ic, 0, 0) f:SetPoint('BOTTOMRIGHT', ic, 0, 6)
            modSkin(f, 1)
            modSkinColor(f, .7, .7, .7)
            tx:SetPoint('TOPLEFT', f)
            tx:SetPoint('BOTTOMRIGHT', f)
        end
    end

    --
