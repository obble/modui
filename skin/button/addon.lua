

    local f = CreateFrame'Frame'
    f:RegisterEvent'ADDON_LOADED'
    f:SetScript('OnEvent', function()
        if arg1 == 'zBar' then          -- ZBAR
            for _, v in pairs({zBar1, zBar2, zBar3, zBar4, zBar9}) do
                for i = 1, 12 do
                    local f = v:GetName()
                    local bu = _G[f..'Button'..i]
                    if bu then
                        modSkin(bu, 18)
                        modSkinPadding(bu, 2)
                        modSkinColor(bu, .2, .2, .2)
                    end
                end
            end
        end
    end)

    --
