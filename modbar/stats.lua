

    local _, class = UnitClass'Player'
    local colour   = RAID_CLASS_COLORS[class]

        -- fish for latency stats
    local function getOurLatency()
        local _, _, home = GetNetStats()
        return  '|c00ffffff'..home..'|r ms'
    end

        -- fish for fps
    local function getFPS()
        return '|c00ffffff'..floor(GetFramerate())..'|r fps'
    end

        -- create tooltip
    local function ReDoMicroMenuTooltip(self)
        GameTooltip:SetOwner(this, 'ANCHOR_TOPRIGHT', 100, 0)

            -- header
        GameTooltip:AddDoubleLine('modui stats', '—', colour.r, colour.g, colour.b)
        GameTooltip:AddLine' '

            -- latency
        GameTooltip:AddDoubleLine('Ping', getOurLatency(), colour.r, colour.g, colour.b)
         if SHOW_NEWBIE_TIPS then
             GameTooltip:AddLine' '
             GameTooltip:AddLine(NEWBIE_TOOLTIP_LATENCY, 1, .8, 0, 1)
         end

           -- fps
        GameTooltip:AddLine' '
        GameTooltip:AddDoubleLine('Framerate', getFPS(), colour.r, colour.g, colour.b)

           -- & go
        GameTooltip:Show()
    end

    MainMenuBarPerformanceBarFrameButton:SetScript('OnEnter', function()
        GameTooltip:ClearLines()
        ReDoMicroMenuTooltip()
    end)

    --
