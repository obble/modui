

    MODUI_HORIZONTAL = true         -- TOGGLE FULL HORIZONTALLY DISPLAYED ACTIONBARS

    if MODUI_HORIZONTAL then
        for i = 1, 12 do
            local bu = _G['MultiBarRightButton'..i]
            bu:SetFrameStrata'LOW' bu:ClearAllPoints()
            if i == 1 then
                bu:SetPoint('BOTTOM', MultiBarBottomLeftButton1, 'TOP', 0, 8)
            else
                local previous = _G['MultiBarRightButton'..i - 1]
                bu:SetPoint('LEFT', previous, 'RIGHT', 6, 0)
            end
        end

        for i = 1, 12 do
            local bu = _G['MultiBarLeftButton'..i]
            bu:SetFrameStrata'LOW' bu:ClearAllPoints()
            if i == 1 then
                bu:SetPoint('LEFT', MultiBarRightButton12, 'RIGHT', 12, 0)
            else
                local previous = _G['MultiBarLeftButton'..i - 1]
                bu:SetPoint('LEFT', previous, 'RIGHT', 6, 0)
            end
        end
    end

    --
