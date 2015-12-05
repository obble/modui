

    local nodes = setmetatable({}, { __index = function(t, i)
        local line = UIParent:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        if i > 1 then
            line:SetPoint('TOPLEFT', t[i - 1], 'BOTTOMLEFT', 0, -5)
        else
            line:SetPoint('TOPLEFT', UIParent, 'TOP', 30, -80)
        end
        line:SetJustifyH'RIGHT'
        line:SetTextColor(1, .8, 0)
        t[i] = line
        return line
    end})

    local nodeUpdate = function(faction, t)
        local time = math.floor(this.max - GetTime())
        this:SetText(format(faction..' — '..t..' |cffffffff %d\s |r', time))
    end

    local f = CreateFrame'Frame'
    f:RegisterEvent'CHAT_MSG_BG_SYSTEM_ALLIANCE' f:RegisterEvent'CHAT_MSG_BG_SYSTEM_HORDE'
    f:RegisterEvent'CHAT_MSG_BG_SYSTEM_NEUTRAL'
    f:SetScript('OnEvent', function()
        local s = arg1
        local faction, t

        if event == 'CHAT_MSG_BG_SYSTEM_HORDE' then
             faction = '|cffff0e0eHorde|r'
        else faction = '|cff0df1ceAlliance|r'
        end

        if string.find(s, 'claims the (.+)') then
            t = gsub(s, '(.+) claims the (.+)! If left unchallenged, the (.+) will control it in 1 minute!', '%2')
        elseif string.find(s, 'has assaulted the (.+)') then
            t = gsub(s, '(.+) has assaulted the (.+)', '%2')
        end

        if string.find(s, 'has taken the (.+)') or string.find(s, 'has defended the (.+)')
        or string.find(s, 'The (.+) wins') or string.find(s, 'claims the (.+)') then
            for i = 1, tlength(nodes) do
                local node = nodes[i]
                local defend = gsub(s, '(.+) has defended the (.+)', '%2')
                local taken  = gsub(s, '(.+) has taken the (.+)', '%2')
                local claim  = gsub(s, '(.+) claims the (.+)', '%2')
                if string.find(node.name, defend) or string.find(node.name, taken)
                or string.find(node.name, claim)  or string.find(s, 'The (.+) wins') then
                    node:Hide()
                    node:SetScript('OnUpdate', nil)
                    node.name = false
                end
            end
        end

        if t ~= nil then
            for i = 1, 5 do
                local node = nodes[i]
                if not node.name then
                    node.name = t
                    t = gsub(t, '^%l', string.upper)
                    node.max = GetTime() + 65
                    node:Show()
                    node:SetScript('OnUpdate', function() nodeUpdate(faction, t) end)
                    break
                end
            end
        end
    end)

    --
