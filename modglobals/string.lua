

    _G = getfenv(0)

    print = function(m) DEFAULT_CHAT_FRAME:AddMessage(m) end

    tlength = function(t)
        local count = 0
        for _ in pairs(t) do count = count + 1 end
        return count
    end

    CHAT_FLAG_AFK = 'AFK — '
    CHAT_FLAG_DND = 'DND — '
    CHAT_FLAG_GM =  'GM — '

    _G.FOREIGN_SERVER_LABEL = ' —'

    _G.GOLD_AMOUNT =    '|cffffffff%d|r|TInterface\\MONEYFRAME\\UI-GoldIcon:14:14:2:0|t'
    _G.SILVER_AMOUNT =  '|cffffffff%d|r|TInterface\\MONEYFRAME\\UI-SilverIcon:14:14:2:0|t'
    _G.COPPER_AMOUNT =  '|cffffffff%d|r|TInterface\\MONEYFRAME\\UI-CopperIcon:14:14:2:0|t'

    GROUP = 'g'

    --
