

    local remaining = 0
    local f = CreateFrame'Frame'

    local update = function()
        remaining = remaining - GetTime()
        local colour = remaining > 20 and '20ff20' or remaining > 10 and 'ffff00' or 'ff0000'
        pvp.label:SetFormattedText(RANDOM_DUNGEON_IS_READY..' |cff%s%s|r remaining.', colour, SecondsToTime(remaining))
        if remaining <= 0 then f:SetScript('OnUpdate', nil) end
    end)

    pvp:SetScript('OnShow', function()
        remaining = GetTime() + 60
        f:SetScript('OnUpdate', update)
    end)

    --
