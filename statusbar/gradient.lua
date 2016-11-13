
    local orig = {}

    local gradient = function(v, f, min, max)
        if v < min or v > max then return end
        if (max - min) > 0 then
            v = (v - min)/(max - min)
        else
            v = 0
        end
        if v > .5 then
            r = (1 - v)*2
            g = 1
        else
            r = 1
            g = v*2
        end
        b = 0
        f:SetStatusBarColor(r, g, b)
    end

    function HealthBar_OnValueChanged(v, smooth)
        if not v then return end
        if string.find(this:GetName(), 'RaidPullout') then return end
        local r, g, b
        local min, max = this:GetMinMaxValues()
        gradient(v, this, min, max)
    end

    orig.CastingBarFrame_OnUpdate = CastingBarFrame_OnUpdate
    function CastingBarFrame_OnUpdate()
        orig.CastingBarFrame_OnUpdate()
        local v = CastingBarFrameStatusBar:GetValue()
        local min, max = this:GetMinMaxValues()
        gradient(v, this, min, max)
    end

    local BagSpaceBarUpdate = function()
        local bar = _G['modbag_inventory'].freespace
        local v = bar:GetValue()
        local min, max = bar:GetMinMaxValues()
        gradient(v, bar, min, max)
    end

    local e = CreateFrame'Frame'
	e:RegisterEvent'PLAYER_ENTERING_WORLD'
	e:RegisterEvent'UNIT_INVENTORY_CHANGED'
	e:RegisterEvent'BAG_UPDATE'
	e:RegisterEvent'BANKFRAME_OPENED'
	e:SetScript('OnEvent', BagSpaceBarUpdate)

    --
