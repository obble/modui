

    local orig = {}

    orig.BuffButton_Update           = BuffButton_Update
    orig.BuffButtons_UpdatePositions = BuffButtons_UpdatePositions

    for i = 0, 23 do                    -- AURA
        local bu = _G['BuffButton'..i]
        local ic = _G['BuffButton'..i..'Icon']
        local du = _G['BuffButton'..i..'Duration']
        bu:SetNormalTexture''
        ic:SetTexCoord(.1, .9, .1, .9)
        modSkin(bu, .25)
        modSkinColor(bu, .7, .7, .7)
        du:ClearAllPoints() du:SetPoint('CENTER', bu, 'BOTTOM', 2, -9)
    end

    for i = 1, 2 do
        local bu = _G['TempEnchant'..i]
        local ic = _G['TempEnchant'..i..'Icon']
        local bo = _G['TempEnchant'..i..'Border']
        local du = _G['TempEnchant'..i..'Duration']
        bu:SetNormalTexture''
        ic:SetTexCoord(.1, .9, .1, .9)
        bo:SetTexture''
        modSkin(bu, 1)
        modSkinColor(bu, 1, 0, 1)
        du:SetJustifyH'LEFT'
        du:ClearAllPoints() du:SetPoint('CENTER', bu, 'BOTTOM', 2, -9)
    end

    function BuffButton_Update()
        orig.BuffButton_Update()
        local name = this:GetName()
        local d = _G[name..'Border']
        if  d then
            local r, g, b = d:GetVertexColor()
            modSkinColor(this, r*1.5, g*1.5, b*1.5)
            d:SetAlpha(0)
        end
    end

    function BuffButtons_UpdatePositions()
        if SHOW_BUFF_DURATIONS == '1' then
            BuffButton8:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, -25)
            BuffButton16:SetPoint('TOPRIGHT', TemporaryEnchantFrame, "TOPRIGHT", 0, -120)
        else
            BuffButton8:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, -5)
            BuffButton16:SetPoint('TOPRIGHT', TemporaryEnchantFrame, 0, -70)
        end
    end

    --
