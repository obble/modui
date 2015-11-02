

    local _, class = UnitClass'Player'
    local colour   = RAID_CLASS_COLORS[class]

    local function getLatency()
        local _, _, home = GetNetStats()
        return  '|c00ffffff'..home..'|r ms'
    end

    local function getFPS()
        return '|c00ffffff'..floor(GetFramerate())..'|r fps'
    end

    local stats = function()
        GameTooltip:SetOwner(this, 'ANCHOR_TOPRIGHT', 100, 0)

            -- HEADER
        GameTooltip:AddDoubleLine('modui stats', '—', colour.r, colour.g, colour.b)
        GameTooltip:AddLine' '

            -- LATENCY
        GameTooltip:AddDoubleLine('Ping', getLatency(), colour.r, colour.g, colour.b)
        if SHOW_NEWBIE_TIPS then
             GameTooltip:AddLine' '
             GameTooltip:AddLine(NEWBIE_TOOLTIP_LATENCY, 1, .8, 0, 1)
        end

            -- FPS
        GameTooltip:AddLine' '
        GameTooltip:AddDoubleLine('Framerate', getFPS(), colour.r, colour.g, colour.b)

        GameTooltip:Show()
    end

    MainMenuBarPerformanceBarFrameButton:SetScript('OnEnter', function()
        GameTooltip:ClearLines()
        stats()
    end)

    --
