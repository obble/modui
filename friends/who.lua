
    local orig = {}

    orig.WhoList_Update = WhoList_Update

    function WhoList_Update()
        orig.WhoList_Update()
        for i = 1, WHOS_TO_DISPLAY do
            local index = FauxScrollFrame_GetOffset(WhoListScrollFrame) + i
            local _, _, _, _, class = GetWhoInfo(index)
            local name = _G['WhoFrameButton'..i..'Name']
            if  class then
                local colour = RAID_CLASS_COLORS[strupper(class)]
                if  colour then
                    name:SetTextColor(colour.r, colour.g, colour.b)
                else
                    name:SetTextColor(1, 1, 1) -- fallback
                end
            end
        end
    end

    --
