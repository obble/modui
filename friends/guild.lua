
    local orig = {}

    orig.GuildStatus_Update = GuildStatus_Update

    function GuildStatus_Update()
        orig.GuildStatus_Update()
        for i = 1, GUILDMEMBERS_TO_DISPLAY do
            local index = FauxScrollFrame_GetOffset(GuildListScrollFrame) + i
            local _, _, _, _, class, _, _, _, online = GetGuildRosterInfo(index)
            local name = FriendsFrame.playerStatusFrame and _G['GuildFrameButton'..i..'Name'] or _G['GuildFrameGuildStatusButton'..i..'Name']
            if  class then
                local colour = RAID_CLASS_COLORS[strupper(class)]
                if  colour then
                    if online then
                        name:SetTextColor(colour.r, colour.g, colour.b)
                    else
                        name:SetTextColor(colour.r*.7, colour.g*.7, colour.b*.7)
                    end
                end
            else
                name:SetTextColor(1, .8, 0) -- fallback
            end
        end
    end

    --
