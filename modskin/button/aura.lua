

    local _G = getfenv(0)
    local orig = {}

    for i = 0, 23 do                    -- AURA
        local bu = _G['BuffButton'..i]
        modSkin(bu, 16)
        modSkinPadding(bu, 2)
        modSkinColor(bu, .2, .2, .2)
    end

    orig.BuffButton_Update = BuffButton_Update
    function BuffButton_Update()
        orig.BuffButton_Update()
        local name = this:GetName()
        local d = _G[name..'Border']
        if d then
            local r, g, b = d:GetVertexColor()
            modSkinColor(this, r*.7, g*.7, b*.7)
        end
    end

    --
