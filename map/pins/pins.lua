

    local orig = {}
    local pins = {}

    local create = function(button, z)
        local width  = WorldMapDetailFrame:GetWidth()
        local height = WorldMapDetailFrame:GetHeight()
        local x,  y  = WorldMapDetailFrame:GetCenter()
        local cx, cy = GetCursorPosition()

        x = ((cx/WorldMapDetailFrame:GetEffectiveScale()) - (x - width/2))/width
        y = ((y + height/2) - (cy/WorldMapDetailFrame:GetEffectiveScale()))/height

        if x >= 0 and y >= 0 and x <= 1 and y <= 1 then
            local p = CreateFrame('Button', z..' modpin'..'_'..x, button)
            p:SetWidth(32) p:SetHeight(32)
            p:SetPoint('CENTER', button, 'TOPLEFT', x*width + 8, -y*height + 8)
            p:SetScript('OnClick', function()
                p:Hide() p.disable = true
            end)
            p:SetScript('OnEnter', function()
                GameTooltip:SetOwner(p, 'ANCHOR_RIGHT')
                GameTooltip:AddLine(format('Pin: %.0f / %.0f', x*100, y*100))
                GameTooltip:Show()
            end)
            p:SetScript('OnLeave', function() GameTooltip:Hide() end)
            tinsert(pins, p)

            local path = UnitFactionGroup'player' == 'Alliance' and [[Interface\WorldStateFrame\AllianceFlag]]
                         or [[Interface\WorldStateFrame\HordeFlag]]
            local t = p:CreateTexture(nil, 'OVERLAY')
            t:SetTexture(path)
            t:SetAllPoints()
        end
    end

    orig.WorldMapButton_OnClick = WorldMapButton_OnClick
    orig.WorldMapFrame_Update   = WorldMapFrame_Update

    function WorldMapButton_OnClick(mouseButton, button)
        if IsShiftKeyDown() then
            if not button then button = this end
            local z = GetMapInfo()
            create(button, z)
        else orig.WorldMapButton_OnClick(mouseButton, button) end
    end

    function WorldMapFrame_Update()
        orig.WorldMapFrame_Update()
        local z = GetMapInfo()
        for i, v in pairs(pins) do
            if not v.disable then
                local name = v:GetName()
                if string.find(name, z) then v:Show()
                else v:Hide() end
            end
        end
    end

    --
