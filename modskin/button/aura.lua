

    local _G = getfenv(0)


    for i = 0, 23 do                    -- AURA
        local bu = _G['BuffButton'..i]
        modSkin(bu, 16)
        modSkinPadding(bu, 2)
        modSkinColor(bu, .2, .2, .2)
    end
