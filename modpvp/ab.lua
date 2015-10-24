

    for i = 1, 5 do
        local node = CreateFrame('Button', 'modnode'..i, WorldStateAlwaysUpFrame)
        node:SetWidth(10) node:SetHeight(10)
        node:SetPoint('TOPLEFT',
                      i == 1 and UIParent or _G['modnode'..(i -1)],
                      i == 1 and 'TOP' or 'BOTTOMLEFT',
                      i == 1 and 30 or 0,
                      i == 1 and -80 or -5)
        node:Hide()

        local text = node:CreateFontString('modnode'..i..'text', 'OVERLAY')
        text:SetPoint('LEFT', node)
        text:SetFontObject(GameFontNormalSmall)
        text:SetJustifyH'RIGHT'
        text:SetTextColor(1, .8, 0)
    end

    local nodeUpdate = function(text, faction, t)
        local time = math.floor(this.max - GetTime())
        text:SetText(format(faction..' — '..t..' |cffffffff %d\s |r', time))
    end

    local f = CreateFrame'Frame'
    f:RegisterEvent'CHAT_MSG_BG_SYSTEM_ALLIANCE' f:RegisterEvent'CHAT_MSG_BG_SYSTEM_HORDE'
    f:SetScript('OnEvent', function()
        local s = arg1
        local faction, t
        if event == 'CHAT_MSG_BG_SYSTEM_HORDE' then faction = '|cffff0e0eHorde|r' else faction = '|cff0df1ceAlliance|r' end
        if string.find(s, 'claims the (.+)') then
            t = gsub(s, '(.+) claims the (.+)! If left unchallenged, the (.+) will control it in 1 minute!', '%2')
        elseif string.find(s, 'has assaulted the (.+)') then
            t = gsub(s, '(.+) has assaulted the (.+)', '%2')
        end

        for i = 1, 5 do
            local node = _G['modnode'..i]
            local text = _G['modnode'..i..'text']

            if node.name
            and (string.find(s, 'has taken the (.+)') or string.find(s, 'has defended the (.+)')) then
                local defend = gsub(s, '(.+) has defended the (.+)', '%2')
                local taken  = gsub(s, '(.+) has taken the (.+)', '%2')
                local name   = node.name
                if string.find(name, defend) or string.find(name, taken) then
                    node:Hide() text:SetText''
                    node:SetScript('OnUpdate', nil)
                    node.name = false
                end
            end

            if t~= nil and not node.name then
                node.name = t
                t = gsub(t, '^%l', string.upper)
                node.max = GetTime() + 65
                node:Show()
                node:SetScript('OnUpdate', function() nodeUpdate(text, faction, t) end)
                break
            end
        end
    end)

    --
