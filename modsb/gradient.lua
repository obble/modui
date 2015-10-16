
    function HealthBar_OnValueChanged(v, smooth)
        if not v then return end
        local r, g, b
        local min, max = this:GetMinMaxValues()

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
        this:SetStatusBarColor(r, g, b)
    end

    --
