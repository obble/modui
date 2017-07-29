


    --[[    this is a modified version of neal's !Beautycase
            https://github.com/renstrom/NeavUI/tree/master/Interface/AddOns/!Beautycase
        api
            modSkin(f, size or 0)
            modSkinSize(f, size)
            modSkinPadding(f, number or [uL1, uL2, uR1, uR2, bL1, bL2, bR1, bR2])
            modSkinDraw(f, drawlayer)
            modSkinTexture(f, texture or 'default')
            modSkinShadowTexture(f, texture)
            modSkinColor(f, r, g, b, a)
            modSkinShadowColor(f, r, g, b, a)
            modSkinHide(f)
            modSkinShow(f)
            modSkinned(f) - true if has a border, false if not
            local height, width, texture, r, g, b, alpha = modSkinInfo(f)    ]]

    local sections  = {'TOPLEFT', 'TOPRIGHT', 'BOTTOMLEFT', 'BOTTOMRIGHT', 'TOP', 'BOTTOM', 'LEFT', 'RIGHT'}

    modSkinned = function(self)
        return self.borderTextures and true or false
    end


    modSkinInfo = function(self)
        return self.borderTextures and self.borderTextures.TOPLEFT:GetVertexColor()
    end


    modSkinPadding = function(self, uL1, uL2, uR1, uR2, bL1, bL2, bR1, bR2)
        -- deprecated
    end


    modSkinColor = function(self, r, g, b, a)
        local  t = self.borderTextures
        if not t then return end
        for  _, tex in pairs(t) do
        	tex:SetVertexColor(r or 1, g or 1, b or 1, a or 1)
        end
    end


    modSkinDraw = function(self, layer, sublayer)
        local  t = self.borderTextures
        if not t then return end
        for  _, tex in pairs(t) do
        	tex:SetDrawLayer(layer or 'OVERLAY', sublayer or 0)
        end
    end

    modSkinHide = function(self)
        local  t = self.borderTextures
        if not t then return end
        for  _, tex in pairs(t) do tex:Hide() end
    end

    modSkinShow = function(self)
        local  t = self.borderTextures
        if not t then return end
        for  _, tex in pairs(t) do tex:Show() end
    end

    modSkin = function(self, offset)
        if type(self) ~= 'table' or not self.CreateTexture or self.borderTextures then return end

        local t = {}
        offset = offset or 0

        for i = 1, 8 do
            local section = sections[i]
            local x = self:CreateTexture(nil, 'OVERLAY', nil, 1)
            x:SetTexture('Interface\\AddOns\\modui\\skin\\method\\texture\\border-'..section..'.tga')
            t[sections[i]] = x
        end

        t.TOPLEFT:SetWidth(8)
        t.TOPLEFT:SetHeight(8)
        t.TOPLEFT:SetPoint('BOTTOMRIGHT', self, 'TOPLEFT', 4 + offset, -4 - offset)

        t.TOPRIGHT:SetWidth(8)
        t.TOPRIGHT:SetHeight(8)
        t.TOPRIGHT:SetPoint('BOTTOMLEFT', self, 'TOPRIGHT', -4 - offset, -4 - offset)

        t.BOTTOMLEFT:SetWidth(8)
        t.BOTTOMLEFT:SetHeight(8)
        t.BOTTOMLEFT:SetPoint('TOPRIGHT', self, 'BOTTOMLEFT', 4 + offset, 4 + offset)

        t.BOTTOMRIGHT:SetWidth(8)
        t.BOTTOMRIGHT:SetHeight(8)
        t.BOTTOMRIGHT:SetPoint('TOPLEFT', self, 'BOTTOMRIGHT', -4 - offset, 4 + offset)

        t.TOP:SetHeight(8)
        t.TOP:SetPoint('TOPLEFT', t.TOPLEFT, 'TOPRIGHT', 0, 0)
        t.TOP:SetPoint('TOPRIGHT', t.TOPRIGHT, 'TOPLEFT', 0, 0)

        t.BOTTOM:SetHeight(8)
        t.BOTTOM:SetPoint('BOTTOMLEFT', t.BOTTOMLEFT, 'BOTTOMRIGHT', 0, 0)
        t.BOTTOM:SetPoint('BOTTOMRIGHT', t.BOTTOMRIGHT, 'BOTTOMLEFT', 0, 0)

        t.LEFT:SetWidth(8)
        t.LEFT:SetPoint('TOPLEFT', t.TOPLEFT, 'BOTTOMLEFT', 0, 0)
        t.LEFT:SetPoint('BOTTOMLEFT', t.BOTTOMLEFT, 'TOPLEFT', 0, 0)

        t.RIGHT:SetWidth(8)
        t.RIGHT:SetPoint('TOPRIGHT', t.TOPRIGHT, 'BOTTOMRIGHT', 0, 0)
        t.RIGHT:SetPoint('BOTTOMRIGHT', t.BOTTOMRIGHT, 'TOPRIGHT', 0, 0)

        self.borderTextures = t
        self.SetBorderColor = SetBorderColor
        self.GetBorderColor = GetBorderColor
    end

    --
