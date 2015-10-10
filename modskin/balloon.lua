

    local BACKDROP = {  bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
                        edgeFile = nil,
                        edgeSize = 0,
                        insets = {left = 2, right = 2, top = 2, bottom = 2},}
    local events = {    CHAT_MSG_SAY = 'chatBubbles',
                        CHAT_MSG_YELL = 'chatBubbles',
                        CHAT_MSG_PARTY = 'chatBubblesParty',
                        CHAT_MSG_PARTY_LEADER = 'chatBubblesParty',
                        CHAT_MSG_MONSTER_SAY = 'chatBubbles',
                        CHAT_MSG_MONSTER_YELL = 'chatBubbles',
                        CHAT_MSG_MONSTER_PARTY = 'chatBubblesParty',}


    local function styleBubble(f)
        for i = 1, f:GetNumRegions() do                               -- FISH
        	local a, b, c, d, e, f, g, h = f:GetRegions()
            for i,v in pairs ({a,b,c,d,e,f,g,h}) do
            	local pn = {v:GetPoint()}
            	if  v:GetObjectType() == 'Texture' then
               	 	v:SetDrawLayer'OVERLAY'
                	v:ClearAllPoints()                                -- FIX BALLOON & TAIL GAP
                	v:SetPoint(pn[1], pn[2], pn[3], pn[4], pn[5] + 2) -- BY NUDGING UP Y.
            	elseif v:GetObjectType() == 'FontString' then
                	f.textstring = v
            	end
                if v:GetTexture() == [[Interface\Tooltips\ChatBubble-Background]]
                or v:GetTexture() == [[Interface\Tooltips\ChatBubble-Backdrop]] then v:SetTexture'' end
            end
    	end

        if not f.skinned then
            modSkin(f, 18)
            modSkinColor(f, .2, .2, .2)
            f:SetBackdrop(BACKDROP)
            f:SetBackdropColor(0, 0, 0, .8)
            f:SetScale(.95)
            f.skinned = true
        end
    end

    local function isChatBubble(f)                                   -- FIND
        if f:GetName() then return end
        if not f:GetRegions() then return end
        return f:GetRegions():GetTexture() == [[Interface\Tooltips\ChatBubble-Background]]
    end


    local bubbleHook = CreateFrame'Frame'
    for event, cvar in pairs(events) do bubbleHook:RegisterEvent(event) end
    bubbleHook:SetScript('OnEvent', function()                      -- FISH & GO
        local numKids = 0
        local time = math.ceil(GetTime())
        bubbleHook:SetScript('OnUpdate', function(self)
            if math.ceil(GetTime()) == time + 1 then bubbleHook:SetScript('OnUpdate', nil) end
            local newNumKids = WorldFrame:GetNumChildren()
            if newNumKids ~= numKids then
                local a, b, c ,d, e, f, g, h, j, l = WorldFrame:GetChildren()
                for k,v in pairs({a, b, c, d, e, f, g, h, j, l}) do
                    if isChatBubble(v) then styleBubble(v) end
                end
                numKids = newNumKids
            end
        end)
    end)

    --
