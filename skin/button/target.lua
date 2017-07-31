

    for i = 1, 5 do
        local bu = _G['TargetFrameBuff'..i]
        modSkin(bu, 1)
        modSkinColor(bu, .7, .7, .7)
    end

    for i = 1, 16 do
        local bu = _G['TargetFrameDebuff'..i]
        modSkin(bu, 1)
        modSkinColor(bu, 1, 0, 0)
    end

    for i = 1, 4 do
        local bu = _G['TargetofTargetFrameDebuff'..i]
        modSkin(bu, -1)
        modSkinColor(bu, 1, 0, 0)
    end

    --
