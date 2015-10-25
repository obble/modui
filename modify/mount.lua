

    local tip = CreateFrame('GAMETOOLTIP', 'modmount', nil, 'GameTooltipTemplate')
    tip:SetOwner(UIParent, 'ANCHOR_NONE')

    local dismount = function()
        for i = 1, 16 do
            local j, uc = GetPlayerBuff(i, 'HELPFUL')
            tip:SetPlayerBuff(j)
            local t = _G['modmountTextLeft2']:GetText()
            if t then
                local _, _, speed = string.find(t, 'Increases speed by (.+)%%')
                if speed then CancelPlayerBuff(i) return end
            end
        end
    end

    local f = CreateFrame'Frame'
    f:RegisterEvent'UI_ERROR_MESSAGE' f:RegisterEvent'GOSSIP_SHOW'
    f:SetScript('OnEvent', function()
        if event =='UI_ERROR_MESSAGE' then
            if string.find(arg1, 'mounted') or string.find(arg1, 'while silenced') then
                dismount()
            end
        else
            local _, g1, _, g2, _, g3, _, g4 ,_, g5 = GetGossipOptions()
            for _, v in pairs ({g1, g2, g3, g4, g4}) do
                if v == 'taxi' then dismount() end
            end
        end
    end)

    --
