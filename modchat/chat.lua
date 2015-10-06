

    local _G = getfenv(0)
    local type, gsub, time, floor,  _ = type, _G.string.gsub, time, math.floor, _
    local _AddMessage = ChatFrame1.AddMessage
    local blacklist = {[ChatFrame2] = true,}

    ChatFontNormal:SetFont(STANDARD_TEXT_FONT, 14)      -- DEFAULT FONT
    ChatFontNormal:SetShadowOffset(1, -1)
    ChatFontNormal:SetShadowColor(0, 0, 0, 1)


    SLASH_RELOADUI1 = '/rl'                             -- DEVTOOLS
    SlashCmdList.RELOADUI = ReloadUI


    CHAT_FONT_HEIGHTS = {                               -- MORE MENU FONT SIZES
        [1] = 8, [2] = 9, [3] = 10, [4] = 11, [5] = 12, [6] = 13,
        [7] = 14, [8] = 15, [9] = 16, [10] = 17, [11] = 18, [12] = 19, [13] = 20, }


                                                        -- STRING SUBS
     CHAT_GUILD_GET = '|Hchannel:Guild|hg|h %s:\32'                        -- GUILD          'g'
     CHAT_OFFICER_GET = '|Hchannel:o|ho|h %s:\32'                          -- OFFICER        'o'
     CHAT_RAID_GET = '|Hchannel:raid|hr|h %s:\32'                          -- RAID           'r'
     CHAT_RAID_WARNING_GET = 'rw %s:\32'                                   -- RAID W         'rw'
     CHAT_RAID_LEADER_GET = '|Hchannel:raid|hrl|h %s:\32'                  -- RAID L         'rl'
     CHAT_BATTLEGROUND_GET = '|Hchannel:Battleground|hbg|h %s:\32'         -- BG             'bg'
     CHAT_BATTLEGROUND_LEADER_GET = '|Hchannel:Battleground|hbl|h %s:\32'  -- BG L           'bl'
     CHAT_PARTY_GET = '|Hchannel:party|hp|h %s:\32'                        -- PARTY          'p'
     CHAT_PARTY_GUIDE_GET = '|Hchannel:party|hdg|h %s:\32'                 -- DUNGEONGUIDE   'dg'
     CHAT_MONSTER_PARTY_GET = '|Hchannel:raid|hr|h %s:\32'                 -- RAID           'r'

    local AddMessage = function(f, t, r, g, b, id)
        t = gsub(t, '%[(%d+)%. .+%].+(|Hplayer.+)', '%1 %2')               -- WORLD CHANNELS '1'
        t = gsub(t, '|H(.-)|h%[(.-)%]|h', '|H%1|h%2|h')                    -- STRIP BRACKETS
        -- t = string.format('%s %s', date'%X', t)                         -- TIMESTAMP
        return _AddMessage(f, t, r, g, b, id)
    end


     local modScroll = function()                       -- MOUSESCROLL CHAT
         if not arg1 then return end
         local f = this:GetParent()
         if arg1 > 0 then
             if IsShiftKeyDown() then f:ScrollToTop()
             else f:ScrollUp() end
         elseif arg1 < 0 then
             if IsShiftKeyDown() then f:ScrollToBottom()
      		else f:ScrollDown() end
         end
     end


     local hideFrameForever = function (f)                -- HIDE JUNK
         f:SetScript('OnShow', function() f:Hide() end) f:Hide()
     end


     for i = 1, 7 do                                   -- INIT STYLE, SUBS etc
         local chat = _G['ChatFrame'..i]

         hideFrameForever(_G['ChatFrame'..i..'UpButton'])
         hideFrameForever(_G['ChatFrame'..i..'DownButton'])
         hideFrameForever(_G['ChatFrame'..i..'BottomButton'])

         local f = CreateFrame('Frame', nil, chat)
         f:EnableMouse(false)
         f:SetPoint('TOPLEFT', chat)
         f:SetPoint('BOTTOMRIGHT', chat)
         f:EnableMouseWheel(true)
         f:SetScript('OnMouseWheel', modScroll)

         _G['ChatFrame'..i..'UpButton']:GetNormalTexture():SetVertexColor(.5, .5, .5)
         _G['ChatFrame'..i..'DownButton']:GetNormalTexture():SetVertexColor(.5, .5, .5)
         _G['ChatFrame'..i..'BottomButton']:GetNormalTexture():SetVertexColor(.5, .5, .5)

         if not blacklist[chat] then chat.AddMessage = AddMessage end
     end

     ChatFrameMenuButton:GetNormalTexture():SetVertexColor(.5, .5, .5)
     ChatFrameMenuButton:ClearAllPoints() ChatFrameMenuButton:SetPoint('BOTTOMRIGHT', ChatFrame1, 'BOTTOMLEFT', -3, -10)
     ChatMenu:ClearAllPoints() ChatMenu:SetPoint('BOTTOM', UIParent, 0, 100)

     local x = ({ChatFrameEditBox:GetRegions()})
     x[6]:SetAlpha(0) x[7]:SetAlpha(0) x[8]:SetAlpha(0)
     ChatFrameEditBox:ClearAllPoints()
     ChatFrameEditBox:SetPoint('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', -5, 0)
     ChatFrameEditBox:SetPoint('BOTTOMRIGHT', ChatFrame1, 'TOPRIGHT',  5, 0)
     ChatFrameEditBox:SetAltArrowKeyMode(nil)


     ChatTypeInfo.SAY.sticky = 1                        -- STICKY CHANNELS
     ChatTypeInfo.EMOTE.sticky = 1
     ChatTypeInfo.YELL.sticky = 1
     ChatTypeInfo.PARTY.sticky = 1
     ChatTypeInfo.GUILD.sticky = 1
     ChatTypeInfo.OFFICER.sticky = 1
     ChatTypeInfo.RAID.sticky = 1
     ChatTypeInfo.RAID_WARNING.sticky = 1
     ChatTypeInfo.BATTLEGROUND.sticky = 1
     ChatTypeInfo.WHISPER.sticky = 1
     ChatTypeInfo.CHANNEL.sticky = 1

     --
